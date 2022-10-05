class Message < ApplicationRecord
    belongs_to :user
    scope :custom_display, -> { order(:created_at).last(10) }
end
