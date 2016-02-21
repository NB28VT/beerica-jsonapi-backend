class BeerResource < JSONAPI::Resource
  attributes :name, :abv, :brewery_id, :medium_label, :large_label, :icon

  has_one :brewery

  filter :name
end