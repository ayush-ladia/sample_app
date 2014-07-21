class CreateStocksAgain < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.integer :quantity
      t.integer :user_id
      t.timestamps
    end

    add_index :stocks, [:user_id, :created_at]
  end
end
