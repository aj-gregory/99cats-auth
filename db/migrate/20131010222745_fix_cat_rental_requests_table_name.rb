class FixCatRentalRequestsTableName < ActiveRecord::Migration
  def change
    rename_table :cat_rental_request, :cat_rental_requests
  end
end
