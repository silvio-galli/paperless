class Product < ActiveRecord::Base
  enum status: [:arriving, :arrived]
end
