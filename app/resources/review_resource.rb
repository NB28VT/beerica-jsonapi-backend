class ReviewResource < JSONAPI::Resource
  attributes :title, :content, :brewery_id

  has_one :brewery
  has_one :user

end