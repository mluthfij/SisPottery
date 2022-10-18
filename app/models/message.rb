class Message < ApplicationRecord
    belongs_to :chatroom
    belongs_to :user
    scope :custom_display, -> { order(:created_at).last(10) }
    validates :content, presence: true
end
