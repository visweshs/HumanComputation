class CreateGraphs < ActiveRecord::Migration
  def change
    create_table :graphs do |t|
      t.string :experiment
      t.string :answer
      t.timestamps null: false
    end
  end
end
