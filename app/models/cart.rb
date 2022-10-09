class Cart < ApplicationRecord
    has_many :orderables, dependent: :destroy
    has_many :products, through: :orderables, dependent: :destroy
    belongs_to :user
    def total
        orderables.to_a.sum { |orderable| orderable.total }
    end
end
