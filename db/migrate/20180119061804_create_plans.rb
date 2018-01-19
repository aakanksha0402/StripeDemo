class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :amount
      t.string :interval
      t.string :desired_plan_id
      t.string :stripe_plan_id

      t.timestamps
    end
  end
end
