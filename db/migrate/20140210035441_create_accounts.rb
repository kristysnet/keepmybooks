class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string      :name
      t.timestamps
    end
    add_index :accounts, :name, unique: true

    create_table :transactions do |t|
      t.integer     :account_id
      t.date        :transaction_date
      t.string      :receiver
      t.string      :note
      t.float       :amount
      t.boolean     :deposit
      t.integer     :category_id
      t.timestamps
    end
    add_index :transactions, :account_id
    add_index :transactions, :category_id
    add_index :transactions, :deposit

    create_table :categories do |t|
      t.string      :name
      t.integer     :parent_id
      t.timestamps
    end
    add_index :categories, :parent_id
  end
end
