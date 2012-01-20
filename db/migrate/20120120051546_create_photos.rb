class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.text :description
      t.date :taken_on
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size

      t.timestamps
    end
  end
end
