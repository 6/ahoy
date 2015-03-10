class CreateTeams < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :twilio_account_sid, null: false
      t.string :twilio_auth_token, null: false
    end

    create_table :user_organizations do |t|
      t.integer :user_id, null: false
      t.integer :organization_id, null: false
      t.timestamps null: false
    end
    add_index :user_organizations, [:user_id, :organization_id], unique: true
  end
end
