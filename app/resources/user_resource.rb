class UserResource < JSONAPI::Resource
  attributes :name

  has_many :reviews

  filter :name
end