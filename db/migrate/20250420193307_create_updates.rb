class CreateUpdates < ActiveRecord::Migration[6.0]
  def change
    create_table :updates do |t|
      t.belongs_to :project
      t.belongs_to :user
      t.text :message
      t.integer :comment_id

      t.timestamps
    end
  end
end
