class UpdatePlayer < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :role, :string
  end
end
