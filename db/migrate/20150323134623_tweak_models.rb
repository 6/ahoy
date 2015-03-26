class TweakModels < ActiveRecord::Migration
  def change
    add_index :users, [:email, :organization_id], unique: true
    add_index :users, [:provider, :uid], unique: true
  end
end
