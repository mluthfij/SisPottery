class Product < ApplicationRecord
    acts_as_votable
    belongs_to :user
    has_many_attached :images
    has_many :comments, dependent: :destroy
    has_many :orderables, dependent: :destroy
    has_many :carts, through: :orderables, dependent: :destroy

    # 
    has_many :vessels, dependent: :destroy
    has_many :keeps
    has_many :faileds
    # 

    validate :validate_images

    paginates_per 9

    validates :name, presence: true
    validates :price, presence: true

    # 
    # def set_quantity
    #     orderables.to_a.sum { |orderable| orderable.quantity }
    # end
    # 
  
    # extend FriendlyId
    # friendly_id :slug_candidates, use: [:slugged, :finders, :history]

    # def slug_candidates
    # [
    #     :name,
    #     [:name, :id]
    # ]
    # end

    # def should_generate_new_friendly_id?
    #     name_changed? || new_record? || slug.nil? || slug.blank?
    # end

    def new_method
        @order = orderables.first
        @order.images_status
    end

    private
    def validate_images
        return if images.count <= 10

        errors.add(:images, 'You can upload max 4 images')
    end
end
