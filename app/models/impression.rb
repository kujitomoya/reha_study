class Impression < ApplicationRecord
  belongs_to :customer
  belongs_to :field
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  def self.search(keyword)
    field_ids = Field.where("name LIKE ?", "%#{keyword}%")
    where(field_id: field_ids.ids)
      .or(where("title LIKE ?", "%#{keyword}%"))
  end

  validates :title, presence: true
  validates :name, presence: true
  validates :text, presence: true
  validates :field_id, presence: true
end
