class BeerResource < JSONAPI::Resource
  attributes :name, :abv, :brewery_id

  has_one :brewery

  filter :name
end