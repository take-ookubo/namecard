class CreatePersonals < ActiveRecord::Migration
  def change
    create_table :personals do |t|
      t.references :division, index: true
      t.string :name
      t.string :name_kana
      t.string :title
      t.string :mail
      t.string :memo

      t.timestamps
    end
    add_index :personals, [:name]
  end
end
