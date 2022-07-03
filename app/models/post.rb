class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :commentary, dependent: :delete_all
  has_many :like, dependent: :delete_all
  validates :title, presence: true
  validates :image, attached: true, content_type: /\Aimage\/.*\z/
end
