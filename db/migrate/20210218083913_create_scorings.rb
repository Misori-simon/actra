class CreateScorings < ActiveRecord::Migration[6.1]
  def change
    create_table :scorings do |t|
      t.references :group, foreign_key: true
      t.references :goal, foreign_key: true

      t.timestamps
    end
  end
end
