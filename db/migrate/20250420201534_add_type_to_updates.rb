class AddTypeToUpdates < ActiveRecord::Migration[6.0]
  def change
    add_column :updates, :type, :string
  end
end
