class AddStatus < ActiveRecord::Migration
  def change
      add_column :users, :public, :boolean, :defoult => true
  end
end
