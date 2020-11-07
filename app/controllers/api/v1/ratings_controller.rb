class Api::V1::RatingsController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      create_store
      create_ratings

      render json: @rating
    end
  end

  private

  def create_store
    param = params[:store]

    @store = Store.find_or_create_by!(
      lonlat: "POINT(#{param[:longitude].to_f} #{param[:latitude].to_f})",
      name: param[:name],
      address: param[:address],
      google_place_id: param[:google_place_id]
    )
  end

  def create_ratings
    @rating = Rating.new(ratings_params)

    @rating.store_id = @store.id
    @rating.save!
  end

  def ratings_params
    params.require(:rating).permit(:value, :opinion, :user_name)
  end
end
