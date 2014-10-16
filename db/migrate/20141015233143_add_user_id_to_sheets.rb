class AddUserIdToSheets < ActiveRecord::Migration
  def change
    add_column :sheets, :user_id, :integer
    add_index :sheets, :user_id
  end
end
