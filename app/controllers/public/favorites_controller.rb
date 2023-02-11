class Public::FavoritesController < ApplicationController
  def create
    impression = Impression.find(params[:impression_id])
    favorite = current_customer.favorites.new(impression_id: impression.id)
    favorite.save
    redirect_to impression_path(impression)
  end

  def destroy
    impression = Impression.find(params[:impression_id])
    favorite = current_customer.favorites.find_by(impression_id: impression.id)
    favorite.destroy
    redirect_to impression_path(impression)
  end
end