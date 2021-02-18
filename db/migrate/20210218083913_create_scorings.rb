class CreateScorings < ActiveRecord::Migration[6.1]
  def change
    create_table :scorings do |t|
      t.integer :group_id
      t.integer :goal_id

      t.timestamps
    end
  end
end
