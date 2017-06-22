class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :edit, :destroy]
  before_action :require_login, except: [:show]
  before_action :non_user_only, only: [:index]
  before_action :authorize_check, only: [:update, :destroy, :edit]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all.order('created_at DESC').paginate(:page => params[:page]).per_page(20)
  end

  def search
    @items = Item.search(params[:term], fields: ["name", "brand", "model_number", "color"], misspellings: {below: 5}).paginate(:page => params[:page]).per_page(20)
    if @items.blank?
      redirect_to root_path, flash:{danger: "no successful search result"}
    else
      render :search
    end
  end

  def myitem
    @items = current_user.items
    render 'index'
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @stocks = Stock.select('min(resell_price) AS min_price, size').where(sold: false, item_id: @item.id).group(:size).each {|x| p x.min_price}
    @stocks = @stocks.sort_by {|obj| obj.size}
    @stock = @item.stocks.where(sold: false, size: @stocks[0].size).order('resell_price DESC').last
    @table = HistoricalTable.where(model_number: @item.model_number).order('date_time DESC')
    # @box = []
    # @stocks.each do |shoe|
    #   @box << Stock.where(sold: false, size: shoe.size).order('resell_price DESC').last
    # end
    # @box = @box.sort_by {|obj| obj.size}
    # @stock = @box.first
  end

  # GET /items/new
  def new
    @item = Item.new
    @image = @item.images.build
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = current_user.items.new(item_params)

    respond_to do |format|
      if @item.save
        if params[:images]
          params[:images].each do |image|
            @item.images.create(image: image)
          end
        end

        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        if params[:images]
          @item.images.destroy_all
          params[:images].each do |image|
            @item.images.create(image: image)
          end
        end

        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def getstock
    @item = Item.find(params[:item_id])
    @stock = @item.stocks.where(size: params[:size]).order('resell_price DESC').last
    @bid = @stock.bids.order('bidding_price ASC').last
    if @stock.bids.find_by(chosen_bid: true, user_id: current_user.id)
      winner = true
    else
      winner = false
    end
    respond_to do |format|
      format.json {
         render json: {"stock": @stock, "winner": winner, "bid": @bid}
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    def authorize_check
      unless @item.user == current_user || current_user.admin?
        redirect_to root_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params

      params.require(:item).permit(:name, :color, :model_number, :category, :brand, :retail_price, :release_date, :user_id, images_attributes: [:image, :item_id])

    end

    def non_user_only
      redirect_to sign_in_path if current_user.user?
    end
end
