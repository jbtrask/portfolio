class Item < ActiveRecord::Base
  belongs_to :classification
  belongs_to :medium
  belongs_to :period
end
