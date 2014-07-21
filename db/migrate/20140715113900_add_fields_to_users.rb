class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cash_in_hand, :float
    add_column :users, :total_portfolio, :float
  end
end
