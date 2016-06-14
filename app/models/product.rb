class Product < ActiveRecord::Base
  default_scope { order('initiative DESC') }
end
