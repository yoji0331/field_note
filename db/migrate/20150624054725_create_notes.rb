class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :body
      t.integer :user_id
      t.float :lat
      t.float :lng
      t.string :date
      t.string :weather

      t.timestamps
    end
    add_index :notes, [:user_id, :created_at]
  end
end
