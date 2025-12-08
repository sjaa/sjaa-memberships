class AddActiveToOpportunities < ActiveRecord::Migration[7.1]
  def change
    add_column :opportunities, :active, :boolean, default: true, null: false
  end
end
