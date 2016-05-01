class CreateGraphs < ActiveRecord::Migration
  def change
    create_table :graphs do |t|
      t.string :answer
      t.references :closest_pair_trial
      t.timestamps null: false
      t.integer :mean
      t.integer :variance
      t.integer :std_dev
    end
  end
end
