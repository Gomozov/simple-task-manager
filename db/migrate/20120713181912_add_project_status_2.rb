class AddProjectStatus2 < ActiveRecord::Migration
  def change
        add_column :projects, :public, :boolean, :defoult => true
  end
end
