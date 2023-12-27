class AddDeletedAtToStates < ActiveRecord::Migration[7.1]
  def change
    add_column :states, :deleted_at, :datetime
    add_index :states, :deleted_at
  end
end
