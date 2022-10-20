class Keep < ApplicationRecord
    belongs_to :bucket
    belongs_to :user
    paginates_per 15
end
