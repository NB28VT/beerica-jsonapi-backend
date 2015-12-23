class StateResource < JSONAPI::Resource
  attributes :name, :abbreviation

  has_many :breweries

  filter :name
end