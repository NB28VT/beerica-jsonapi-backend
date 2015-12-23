class Brewery < ActiveRecord::Base
  has_many :beers
  has_many :reviews
  belongs_to :state

  validates :name, presence: true
  validates :address, presence: true
  validates :state_id, presence: true
end
