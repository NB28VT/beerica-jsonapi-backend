class Review < ActiveRecord::Base
  belongs_to :brewery

  validates :title, presence: true
  validates :brewery_id, presence: true
  validates :content, presence: true
end
