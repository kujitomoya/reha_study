class Public::RanksController < ApplicationController
  def rank
    impression_favorite_count = {}
    Customer.all.each do |customer|
      impression_favorite_count.store(customer, Favorite.where(impression_id: Impression.where(customer_id: customer.id).pluck(:id)).count)
    end
    @customer_impression_favorite_ranks = impression_favorite_count.sort_by { |_, v| v }.reverse.to_h.keys
  end
end