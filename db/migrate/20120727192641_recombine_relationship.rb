class RecombineRelationship < ActiveRecord::Migration
  def change
      remove_column :relationships, :user_id
      add_column :relationships, :member_id, :integer
      remove_column :relationships, :project_id
      add_column :relationships, :work_id, :integer

      add_index :relationships, :work_id
      add_index :relationships, :member_id
      add_index :relationships, [:work_id, :member_id], :unique => true
  end
end
