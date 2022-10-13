class History < ApplicationRecord
    has_many :vessels, dependent: :destroy
    # has_many :orderables, through: :vessels, dependent: :destroy
end
