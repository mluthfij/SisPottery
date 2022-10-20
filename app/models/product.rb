class Product < ApplicationRecord
    acts_as_votable
    belongs_to :user
    has_many_attached :images
    has_many :comments, dependent: :destroy
    has_many :orderables, dependent: :destroy
    has_many :carts, through: :orderables, dependent: :destroy

    validate :validate_images

    paginates_per 9

    # validates :name, presence: true
    # validates :price, presence: true

    # 
    # def set_quantity
    #     orderables.to_a.sum { |orderable| orderable.quantity }
    # end
    # 

    private
    def validate_images
        return if images.count <= 10

        errors.add(:images, 'You can upload max 4 images')
    end
end
