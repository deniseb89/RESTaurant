class SetDefaultForPartiesTable < ActiveRecord::Migration
  def change
  	change_column_default :parties, :has_paid, :false
  end
end
