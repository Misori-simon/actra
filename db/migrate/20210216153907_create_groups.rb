class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer :user_id
      t.string :name
      t.string :icon
      t.timestamps
    end
  end
end
