class User < ApplicationRecord
  # attr_accessor :name
  has_secure_password
end
