class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :access_level, default: 0
      t.text :bio
      t.integer :approved, default: 0
      t.timestamp :approved_at

      t.timestamps
    end
  end
end
