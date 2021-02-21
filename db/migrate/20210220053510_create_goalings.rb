class CreateGoalings < ActiveRecord::Migration[6.1]
  def change
    create_table :goalings do |t|
      t.references :competition, foreign_key: true
      t.references :goal, foreign_key: true

      t.timestamps
    end
  end
end
