class Failed < ApplicationRecord
    belongs_to :user
    belongs_to :product
    paginates_per 15
end
