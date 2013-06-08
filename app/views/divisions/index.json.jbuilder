json.array!(@divisions) do |division|
  json.extract! division, :company_id, :name, :name_kana, :zip, :address, :tel, :fax, :url
  json.url division_url(division, format: :json)
end