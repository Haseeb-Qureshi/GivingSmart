class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :website_url
      t.string :phone
      t.text :address, limit: 1000
      t.text :description, limit: 2000

      t.timestamps
    end
    add_index :organizations, :name
  end
end
