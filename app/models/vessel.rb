class Vessel < ApplicationRecord
    # 
    # belongs_to :orderable
    # 
    belongs_to :history
    belongs_to :user
    
end
