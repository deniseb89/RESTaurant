class CreatePartiesTable < ActiveRecord::Migration
  def change
  	create_table :parties do |t|
  		t.string :surname
  		t.integer :table_num
  		t.integer :guests_num
  		t.boolean :has_paid
  	end
  end
end
