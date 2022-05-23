class AddNullToSubmitterKey < ActiveRecord::Migration[7.0]
  def change
    change_column_null(:games, :submitter_id, false)
  end
end
