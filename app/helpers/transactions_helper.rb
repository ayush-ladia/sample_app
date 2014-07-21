module TransactionsHelper

	def buy_stock
		@stock = YahooFinance.quotes([@transaction.symbol], [:ask_real_time])[0]
    	rate = @stock.ask_real_time.to_f
    	quantity = @transaction.quantity
    	cash = current_user.cash_in_hand
    	if cash > quantity*rate
    		cash = (cash.to_f - quantity*rate).to_f
    		@new_stock = current_user.stocks.find_by_symbol(@transaction.symbol)
    		if @new_stock.nil?
    			@new_stock = current_user.stocks.build
    			@new_stock.symbol = @transaction.symbol
    			@new_stock.quantity = 0
  			end
	    	@new_stock.update_attributes(quantity: @new_stock.quantity + quantity)
	    	@transaction.save
    	else
    		flash[:error] = "Not enough cash in hand!"
    		redirect_to new
    	end
    	current_user.update_attributes(cash_in_hand: cash)
    	flash[:notice] = "Sucessfully bought stocks"
    	render "new"
	end
end
