class Store < ApplicationRecord
  has_many :ratings

  validates_presence_of :lonlat, :name, :google_place_id
  validates :google_place_id, uniqueness: true

  scope :within, lambda { |lon, lat, distance = 5|
    where(
      format(
        %{ ST_Distance(lonlat, 'POINT(%<lon>f %<lat>f)') < %<distance>d }, lon: lon, lat: lat, distance: distance * 1000
      )
    )
  }

  def ratings_avarage
    return 0 if ratings.empty?

    (ratings.sum(:value) / ratings.count).to_i
  end
end
