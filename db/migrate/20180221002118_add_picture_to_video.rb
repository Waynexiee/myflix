class AddPictureToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :large_picture, :string
  end
end
