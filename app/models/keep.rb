class Keep < ApplicationRecord
    belongs_to :bucket
    belongs_to :user
    paginates_per 15
    # 
    belongs_to :product
    # 
    
    def sum_product
        product_price * quantity
    end
end
