class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :edit, :destroy]
  before_action :require_login
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
    # @bid = @item.bids.new
    # @errors = @bid.errors.full_messages

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
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
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
      params.require(:item).permit(:name, :gender, :color, :model_number, :category, :brand, :size, :retail_price, :resell_price, :quantity, :release_date, :user_id, images_attributes: [:image, :item_id])
    end

    def non_user_only
      redirect_to sign_in_path if current_user.user?
    end
end
