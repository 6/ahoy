class AddTokenToOrgs < ActiveRecord::Migration
  def change
    add_column :organizations, :token, :string, unique: true, null: false
  end
end
