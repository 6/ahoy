class AddOrganizationPhone < ActiveRecord::Migration
  def change
    add_column :organizations, :phone, :string
    Organization.update_all(phone: "+1111111111")
    change_column_null :organizations, :phone, false
  end
end
