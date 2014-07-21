class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :action
      t.integer :quantity
      t.float :rate
      t.integer :user_id

      t.timestamps
    end

    add_index :stocks, [:user_id, :created_at]
  end
end
