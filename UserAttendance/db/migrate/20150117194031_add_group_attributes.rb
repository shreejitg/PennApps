class AddGroupAttributes < ActiveRecord::Migration
  def change
  	add_column :groups, :lattitude, :string
  	add_column :groups, :longitude, :string
  	add_column :groups, :reqd_duration_in_secs, :bigint
  	add_column :groups, :attendance_reqd_percentage, :integer
  end
end
