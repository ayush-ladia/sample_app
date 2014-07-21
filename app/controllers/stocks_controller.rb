class StocksController < ApplicationController
	def index
		@stocks = YahooFinance.quotes(["agx","athl","atk","csh","dlr","drii","faro","fig","gold"],[:symbol,:last_trade_price,:last_trade_date,:change,:previous_close,:low_52_weeks,:high_52_weeks, :ask_real_time])
	end
end
