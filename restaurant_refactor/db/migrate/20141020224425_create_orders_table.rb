class CreateOrdersTable < ActiveRecord::Migration
  def change
  	create_table :orders do |t|
  		t.references :parties
  		t.references :foods

  		t.timestamps
  	end
  end
end
