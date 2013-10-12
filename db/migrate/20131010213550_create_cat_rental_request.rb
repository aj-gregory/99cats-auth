class CreateCatRentalRequest < ActiveRecord::Migration
  def change
    create_table :cat_rental_request do |t|
      t.string :cat_id, :null => false
      t.string :start_date, :null => false
      t.string :end_date, :null => false
      t.string :status, :null => false

      t.timestamps
    end

    add_index :cat_rental_request, :cat_id
  end
end
