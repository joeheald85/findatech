class AddUserFields < ActiveRecord::Migration
  def up
    add_column :users, :username, :string
    add_column :users, :full_name, :string
    add_column :users, :bio, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :string
    add_column :users, :lat, :decimal, :precision => 10, :scale => 7
    add_column :users, :lon, :decimal, :precision => 10, :scale => 7
    add_column :users, :distance, :decimal
    add_column :users, :rate, :decimal, :precision => 8, :scale => 2
  end

  def down
  end
end
