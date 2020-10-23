class Store < ApplicationRecord
  has_many :ratings

  validates_presence_of :lonlat, :name, :google_place_id
  validates :google_place_id, uniqueness: true

  scope :within, -> (lon, lat, distance = 5) {
    where(%{ ST_Distance(lonlat, 'POINT(%f %f)') < %d } % [lon, lat, distance * 1000])
  }

  def ratings_avarage
    return 0 if self.ratings.empty?

    (self.ratings.sum(:value) / self.ratings.count).to_i
  end
end
