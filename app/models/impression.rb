class Impression < ApplicationRecord
  belongs_to :customer
  belongs_to :field
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  validates :title, presence: true
  validates :name, presence: true
  validates :text, presence: true
  validates :field_id, presence: true
end
