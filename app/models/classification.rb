class Classification < ActiveRecord::Base
  has_and_belongs_to_many :periods
  has_many :items
end
