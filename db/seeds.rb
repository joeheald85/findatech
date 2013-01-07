# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.find_or_create_by_role('admin')
Role.find_or_create_by_role('user')
Role.find_or_create_by_role('tech')

admin = User.find_by_email('admin@fat.com')
if !admin
  admin = User.create({:email => 'admin@fat.com', :username => 'admin', :password => 's3cr3t!', :password_confirmation => 's3cr3t!'})
  admin.roles << Role.find_by_role('admin')
end
