class CreateAdvertisers < ActiveRecord::Migration
  def change
    create_table :advertisers do |t|
      t.string :shop

      t.timestamps null: false
    end
  end
end
