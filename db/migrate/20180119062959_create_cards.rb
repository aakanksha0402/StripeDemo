class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.references :customer, foreign_key: true
      t.string :stripe_card_id
      t.boolean :default_card, default: false 
      t.string :last_4
      t.string :brand
      t.string :exp_month
      t.string :exp_year

      t.timestamps
    end
  end
end
