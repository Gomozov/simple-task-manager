class RemoveUserStatus < ActiveRecord::Migration
  def change
        remove_column :users, :public
  end
end
