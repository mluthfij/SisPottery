class Vessel < ApplicationRecord
    # 
    belongs_to :product
    # 
    belongs_to :history
    belongs_to :user
    validates :date, presence: true
    paginates_per 15
end
