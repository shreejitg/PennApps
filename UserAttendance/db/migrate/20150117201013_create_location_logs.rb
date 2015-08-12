class CreateLocationLogs < ActiveRecord::Migration
  def change
    create_table :location_logs do |t|
    	t.bigint :user_id
    	t.string :lattitude
    	t.string :longitude
    	t.timestamps
    end
  end
end
