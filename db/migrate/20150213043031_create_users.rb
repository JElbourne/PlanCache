class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      
      t.string :provider
      t.string :uid
      
      t.string :nickname
      t.string :email
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :image
      t.string :location

      t.string :oauth_token
      t.datetime :oauth_expires_at
      
      t.timestamps
    end
    
    add_index :users, [:provider, :uid]
  end
end
