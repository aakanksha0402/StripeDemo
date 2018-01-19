class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.references :plan, foreign_key: true
      t.string :stripe_customer_id

      t.timestamps
    end
  end
end
