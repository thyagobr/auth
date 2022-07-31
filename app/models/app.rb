class App < ApplicationRecord
  has_many :users
  has_secure_token
end
