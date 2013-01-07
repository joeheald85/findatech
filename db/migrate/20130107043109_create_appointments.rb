class CreateAppointments < ActiveRecord::Migration
  def up
    create_table :appointments do |t|
      t.integer :user_id
      t.integer :tech_id
      t.integer :review_id
      t.string :status
      t.string :description
      t.datetime :appointment_time
      t.timestamps
    end
  end

  def down
  end
end
