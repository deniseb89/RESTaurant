class CreateFoodsTable < ActiveRecord::Migration
  def change
  	create_table :foods do |t|
  		t.string :name
  		t.string :cuisine
  		t.float :price
  		t.string :allergens
  		t.string :spicy_level
  	end
  end
end
