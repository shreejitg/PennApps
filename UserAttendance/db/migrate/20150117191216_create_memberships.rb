class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
    	t.integer :user_id
    	t.string :role
    	t.integer :group_id
    end
  end
end
