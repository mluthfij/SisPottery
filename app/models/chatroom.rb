class Chatroom < ApplicationRecord
    # has_many :messages, dependent: :delete_all
    has_many :messages, dependent: :destroy
    # 
    has_many :users, through: :messages, dependent: :destroy
    # 
    # belongs_to :user
end
