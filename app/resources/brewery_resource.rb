class BreweryResource < JSONAPI::Resource
  attributes :name, :address, :state_id

  has_one :state
  has_many :beers
  has_many :reviews

  filter :name
end