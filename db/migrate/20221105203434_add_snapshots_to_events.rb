class AddSnapshotsToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :snapshot, :string
  end
end
