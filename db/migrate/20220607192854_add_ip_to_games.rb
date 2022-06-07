class AddIpToGames < ActiveRecord::Migration[7.0]
  def change
    def change
      add_column :games, :submitter_ip, :string
    end
  end
end
