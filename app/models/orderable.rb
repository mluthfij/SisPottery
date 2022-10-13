class Orderable < ApplicationRecord
    belongs_to :product
    belongs_to :cart
    belongs_to :user
    # has_many :vessels, dependent: :destroy

    def total
        product.price * quantity
    end

    # 
    # def set_quantity
    #     product.quantity - quantity
    # end
    # 
end
