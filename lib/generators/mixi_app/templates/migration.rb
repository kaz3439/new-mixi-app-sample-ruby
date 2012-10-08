class CreateTokens < ActiveRecord::Migration
  def self.up
    create_table :tokens do |t|
      t.string :user_id
      t.string :access_token
      t.string :refresh_token
      t.integer :expires_in

      t.timestamps
    end
  end

  def self.down
    drop_table :tokens
  end
end
