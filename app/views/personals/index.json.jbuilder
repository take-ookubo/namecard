json.array!(@personals) do |personal|
  json.extract! personal, :division_id, :name, :name_kana, :title, :mail, :memo
  json.url personal_url(personal, format: :json)
end