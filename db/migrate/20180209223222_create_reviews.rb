class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :score
      t.references :video
      t.references :user
      t.text :content
      t.timestamps
    end
  end
end
