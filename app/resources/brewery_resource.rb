class BreweryResource < JSONAPI::Resource
  attributes :name,
    :address,
    :state_id,
    :city,
    :postal_code,
    :latitude,
    :longitude,
    :description,
    :website,
    :established,
    :icon_image,
    :medium_image,
    :large_image,
    :square_medium_image,
    :square_large_image,
    :open_to_public




  has_one :state
  has_many :beers
  has_many :reviews

  filter :name
end