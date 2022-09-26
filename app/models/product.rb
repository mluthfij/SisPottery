class Product < ApplicationRecord
    belongs_to :user
    has_many_attached :images
    has_many :comments, dependent: :destroy

    validate :validate_images

    private
    def validate_images
        return if images.count <= 10

        errors.add(:images, 'You can upload max 4 images')
    end
end
