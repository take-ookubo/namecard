json.array!(@companies) do |company|
  json.extract! company, :name, :name_kana, :zip, :address, :tel, :fax, :url
  json.url company_url(company, format: :json)
end