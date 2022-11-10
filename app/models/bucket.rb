class Bucket < ApplicationRecord
    has_many :keeps, dependent: :destroy
    # has_many :vessels, through: :keeps, dependent: :destroy
    paginates_per 15

    def sum_price
        keeps.to_a.sum { |keep| keep.sum_product }
    end
end
