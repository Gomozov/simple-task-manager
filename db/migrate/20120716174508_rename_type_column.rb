class RenameTypeColumn < ActiveRecord::Migration
  def change
      add_column :stories, :story_type, :string
      remove_column :stories, :type
  end
end
