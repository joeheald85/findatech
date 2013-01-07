class CreateRoles < ActiveRecord::Migration
  def up
    create_table :roles do |t|
      t.string :role
    end
    create_table :user_roles do |t|
      t.integer :user_id
      t.integer :role_id
    end
  end

  def down
  end
end
