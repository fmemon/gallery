class CreateAlbumizations < ActiveRecord::Migration
  def change
    create_table :albumizations do |t|
      t.integer :album_id, :photo_id, :position
      t.timestamps
    end
  end
end
