class Bucket < ApplicationRecord
    has_many :keeps, dependent: :destroy
    # has_many :vessels, through: :keeps, dependent: :destroy
    paginates_per 15
end
