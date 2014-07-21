class TransactionsController < ApplicationController
  def new
  	#@transaction ||= current_user.transactions.build(params[:transaction])
  end

  def create
    @transaction = current_user.transactions.build(params[:transaction])
    if @transaction.quantity.nil?
    elsif @transaction.action == "buy"
    	buy_stock
    elsif @transaction.action == "sell"
      sell_stock
    end
    @my_stocks = current_user.stocks
  end

  def index
    @transactions = current_user.transactions.reverse
  end

  def update
    @transaction = current_user.transactions.build(params[:transaction])
    if @transaction.quantity.nil?
      render "new"
      return
    elsif @transaction.action == "buy"
      buy_stock
    elsif @transaction.action == "sell"
      sell_stock
    end
    respond_to do |format|
      debugger
      format.html { redirect_to @user }
      debugger
      format.js
    end
  end

  def destroy
  end

  private

  def buy_stock
    rate = @transaction.rate
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
      flash.now[:error] = "Not enough cash in hand!"
      return
    end
    current_user.update_attributes(cash_in_hand: cash)
    flash.now[:notice] = @transaction.quantity.to_s + " stocks of " + @transaction.symbol + " bought successfully!"
  end

  def sell_stock
    rate = @transaction.rate.to_f
    quantity = @transaction.quantity.to_f
    cash = current_user.cash_in_hand
    stock_in_question = current_user.stocks.find_by_symbol(@transaction.symbol)
    if stock_in_question.quantity >= quantity
      cash = (cash.to_f + quantity*rate).to_f
      stock_in_question.quantity = stock_in_question.quantity - quantity
      if stock_in_question.quantity == 0
        stock_in_question.destroy
      else
        stock_in_question.save
        @transaction.save
        end
    else
      flash.now[:error] = "You are trying to sell more than you have"
      return
    end
    current_user.update_attributes(cash_in_hand: cash)
    flash.now[:notice] = @transaction.quantity.to_s + " stocks of " + @transaction.symbol + " bought successfully!"
    return
  end

end
