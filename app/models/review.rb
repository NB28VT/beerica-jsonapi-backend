class Review < ActiveRecord::Base
  belongs_to :brewery
  belongs_to :user

  validates :title, presence: true
  validates :brewery_id, presence: true
  validates :content, presence: true
end
