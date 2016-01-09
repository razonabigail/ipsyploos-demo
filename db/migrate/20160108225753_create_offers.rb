class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
