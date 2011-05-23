class Item < ActiveRecord::Base
  belongs_to :classification
  belongs_to :medium
end
