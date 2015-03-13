class ChangeOrgs < ActiveRecord::Migration
  def change
    add_column :organizations, :email_domain, :string, null: false
    drop_table :user_organizations
    add_column :users, :organization_id, :integer
    add_index :users, :organization_id
  end
end
