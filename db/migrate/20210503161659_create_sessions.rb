class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.string :session_id, null: FALSE
      t.text :data
      t.timestamps
    end
    add_index :sessions, :session_id, unique: TRUE
    add_index :sessions, :updated_at
  end
end
