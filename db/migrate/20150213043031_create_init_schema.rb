class CreateInitSchema < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    enable_extension 'hstore'
    
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

    
    create_table :messages, id: :uuid do |t|
      t.uuid :branch_id
      t.uuid :tenant_id
      
      t.string :email
      t.string :subject
      t.hstore :to, :array => true
      t.hstore :from
      t.hstore :cc, :array => true
      
      t.text :body
      t.text :raw_text
      t.text :raw_html
      t.text :raw_body
      t.text :raw_headers
      t.hstore :headers
      
      t.json :files_array

      t.timestamps null: false
    end
    add_index :messages, [:tenant_id, :branch_id]
    add_index :messages, [:tenant_id, :email]
    
  end
end
