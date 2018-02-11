class CreateQueueItems < ActiveRecord::Migration
  def change
    create_table :queue_items do |t|
      t.integer :order
      t.references :user
      t.references :video
      t.timestamps
    end
  end
end
