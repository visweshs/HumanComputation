class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :x
      t.integer :y
      t.string :label
      t.references :graph, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
