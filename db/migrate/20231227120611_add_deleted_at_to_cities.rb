class AddDeletedAtToCities < ActiveRecord::Migration[7.1]
  def change
    add_column :cities, :deleted_at, :datetime
    add_index :cities, :deleted_at
  end
end
