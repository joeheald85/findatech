class AddUserTimezoneAndActive < ActiveRecord::Migration
  def up
    add_column :users, :timezone, :string
    add_column :users, :active, :boolean, :default => true
  end

  def down
  end
end
