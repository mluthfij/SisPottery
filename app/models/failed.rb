class Failed < ApplicationRecord
    belongs_to :user
    paginates_per 15
end
