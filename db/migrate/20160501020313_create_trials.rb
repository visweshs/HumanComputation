class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.references :experiment, index: true, foreign_key: true
      t.integer :time_milliseconds
      t.string :user_answer
      t.boolean :correct
      t.timestamps null: false
    end
  end
end
