class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :user_id
      t.string :type
      t.string :description

      t.timestamps
    end
  end
end
