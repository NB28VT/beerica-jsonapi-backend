class Beer < ActiveRecord::Base
  belongs_to :brewery

  validates :name, presence: true
  validates :brewery_id, presence: true
end
