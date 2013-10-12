class FixCatRentalRequestColumns < ActiveRecord::Migration
  def change
    change_column :cat_rental_request, :start_date, :datetime, :null => false
    change_column :cat_rental_request, :end_date, :datetime, :null => false
  end
end
