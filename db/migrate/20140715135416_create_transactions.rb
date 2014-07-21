class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :symbol
      t.string :action
      t.integer :quantity
      t.integer :user_id
      t.float :rate
      t.float :amount

      t.timestamps
    end
    add_index :transactions, [:user_id, :created_at]
  end
end
