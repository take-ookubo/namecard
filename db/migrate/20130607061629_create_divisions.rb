class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.references :company, index: true
      t.string :name
      t.string :name_kana
      t.string :zip
      t.string :address
      t.string :tel
      t.string :fax
      t.string :url

      t.timestamps
    end
    add_index :divisions, [:name]
  end
end
