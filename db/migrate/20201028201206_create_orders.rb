class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.decimal :amount
      t.integer :currency, default: 0, null: false
      t.string :p24_session_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
