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
      t.string :subject
      t.string :lower_subjects, :array => true, :default => '{}'
      t.uuid :cache_id
      t.uuid :user_id
      t.uuid :account_id

      t.timestamps null: false
    end
    add_index :branches, :lower_subjects, using: 'gin'
    add_index :branches, [:user_id, :account_id]
    add_index :branches, [:cache_id, :account_id]
    
    
    create_table :messages, id: :uuid do |t|
      t.uuid :branch_id
      t.uuid :user_id
      t.uuid :account_id
      
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
      
      t.json :files_json

      t.timestamps null: false
    end
    add_index :messages, [:account_id, :branch_id]
    add_index :messages, [:account_id, :email]
    
  end
end
