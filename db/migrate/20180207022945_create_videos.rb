class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :smaller_cover_url
      t.string :larger_cover_url
      t.timestamps
    end
  end
end
