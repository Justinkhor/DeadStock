(Sell Now)
<div class="container">
<%= form_for([@item, @stock]) do |f| %>

  <div class="field">
    <%= f.label :gender %>
    <%= f.select :gender, ['Male', 'Female'] %>
  </div>

  <div class="field">
    <%= f.label :size %>
    <%= f.select :size, ['6', '7', '8', '9', '10', '11', '12', '13', '14'] %>
  </div>

  <br>
  <div class="row">
    <div class="col-md-offset-4 col-md-4">
      <table class = "bid-table">
        <tbody>
          <tr>
            <td>Sell Price: </td>
            <td><%= @item.stocks.order('resell_price DESC').last.bids.order('bidding_price ASC').last.bidding_price %></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>

    <div class="actions">
      <%= f.submit "Sell Now", name: "sell" %>
    </div>
<% end %>
</div>
