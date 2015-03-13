class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :organization_id, null: false
      t.string :type, null: false
      t.timestamps null: false
      t.string :body, null: false, limit: 160
      t.string :twilio_message_id
      t.integer :customer_id, null: false
      t.string :from_phone, null: false
      t.string :to_phone, null: false

      # Inbound
      t.json :twilio_data

      # Outbound
      t.integer :sender_user_id
      t.hstore :delivery_statuses, default: '', null: false
    end
    add_index :messages, :twilio_message_id
    add_index :messages, :customer_id
    add_index :messages, :sender_user_id

    create_table :customers do |t|
      t.integer :organization_id, null: false
      t.string :phone, null: false
      t.timestamps null: false
      t.string :name
      t.string :email
    end
    add_index :customers, :phone
  end
end
