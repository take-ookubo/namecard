class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :name_kana
      t.string :zip
      t.string :address
      t.string :tel
      t.string :fax
      t.string :url

      t.timestamps
    end
    add_index :companies, [:name]
  end
end
