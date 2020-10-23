class Rating < ApplicationRecord
  belongs_to :store

  validates_presence_of :value, :opinion, :user_name
end
