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
      
      t.timestamps null: false
    end
    add_index :users, [:provider, :uid]


    create_table :accounts, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :key
      t.string :name

      t.timestamps null: false
    end
    add_index :accounts, :key

    create_table :branches, id: :uuid do |t|
      t.string :subject, :null => false
      t.string :lower_subjects, :array => true, :default => '{}'
      t.uuid :cache_id
      t.uuid :user_id, :null => false
      t.uuid :account_id, :null => false

      t.timestamps null: false
    end
    add_index :branches, :lower_subjects, using: 'gin'
    add_index :branches, [:user_id, :account_id]
    add_index :branches, [:cache_id, :account_id]
    
    
    create_table :messages, id: :uuid do |t|
      t.uuid :branch_id, :null => false
      t.uuid :user_id, :null => false
      t.uuid :account_id, :null => false
      
      t.string :email, :null => false
      t.string :subject, :null => false
      t.hstore :to, :array => true
      t.hstore :from
      t.hstore :cc, :array => true
      
      t.text :body
      t.text :raw_text
      t.text :raw_html
      t.text :raw_body
      t.text :raw_headers
      t.hstore :headers
      
      t.json :files_json

      t.timestamps null: false
    end
    add_index :messages, [:branch_id, :email]
    
    
    create_table :caches, id: :uuid do |t|
      t.uuid :branch_id, :null => false
      t.uuid :message_id, :null => false
      t.uuid :parent_cache
      t.json :files_json, :null => false

      t.timestamps null: false
    end
    add_index :caches, :branch_id
    add_index :caches, :message_id
    add_index :caches, :parent_cache
    
  end
end
