class AddColumnTimestampToFoodsTable < ActiveRecord::Migration
  def change
  	add_column :foods, :created_at, :datetime
  	add_column :foods, :updated_at, :datetime  	
  end
end
