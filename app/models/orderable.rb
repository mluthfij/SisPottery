class Orderable < ApplicationRecord
    belongs_to :product
    belongs_to :cart
    belongs_to :user
    has_many_attached :images
    # has_many :vessels, dependent: :destroy
    # paginates_per 15

    def total
        product.price * quantity
    end

    # 
    # def set_quantity
    #     product.quantity - quantity
    # end
    # 

    # 
    def images_status
        images.empty?
    end
    # 
end
