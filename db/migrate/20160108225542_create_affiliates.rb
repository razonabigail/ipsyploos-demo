class CreateAffiliates < ActiveRecord::Migration
  def change
    create_table :affiliates do |t|
      t.string :user_id
      t.string :lastname
      t.string :firstname
      t.string :email

      t.timestamps null: false
    end
  end
end
