require 'json'
require 'dotenv'


class BrewerySeeder

  def initialize
    @brewery_db = BreweryDB::Client.new do |config|
      config.api_key = ENV['BREWERY_DB_API_TOKEN']
    end

    @states = State.all    
  end

  def seed_breweries
    # Testing
    state = @states.find(45)

    breweries = self.get_state_breweries(state.name)

    self.build_brewery(breweries.first, state)

    # @states.each do |state|
    #   breweries = self.get_state_breweries(state.name)

    #   breweries.each do |brewery|
    #     self.build_brewery(brewery, state)
    #   end
    # end
  end

  def build_brewery(brewery, state)    
    if brewery[:open_to_public] == "Y"
      open_to_public = true
    else
      open_to_public = false
    end

    Brewery.create(
      state: state,
      name: brewery[:brewery][:name],
      address: brewery[:street_address],
      city: brewery[:locality],
      postal_code: brewery[:postal_code],
      latitude: brewery[:latitude],
      longitude: brewery[:longitude],

      open_to_public: open_to_public,

      description: brewery[:brewery][:description],
      website: brewery[:brewery][:website],
      established: brewery[:brewery][:established],

      # Images
      icon_image: brewery[:brewery][:images][:icon],
      medium_image: brewery[:brewery][:images][:medium],
      large_image: brewery[:brewery][:images][:large],
      square_medium_image: brewery[:brewery][:images][:square_medium],
      square_large_image: brewery[:brewery][:images][:square_large]
    )
  end

  def get_state_breweries(state)
    @brewery_db.locations.all(region: state)
  end


end