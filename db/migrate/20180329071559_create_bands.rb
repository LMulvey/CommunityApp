class CreateBands < ActiveRecord::Migration[5.1]
  def change
    create_table :bands do |t|
      t.string :name
      t.string :genre
      t.text :bio
      t.string :profile_image_url

      t.timestamps
    end
  end
end
