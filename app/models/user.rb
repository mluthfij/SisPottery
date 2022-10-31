class User < ApplicationRecord
  before_save { self.username = username.downcase }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

         acts_as_voter

         has_many :messages, dependent: :destroy
         has_many :chatrooms, dependent: :destroy
         has_many :orderables, dependent: :destroy
         has_many :carts, through: :orderables, dependent: :destroy
        #  has_many :products, dependent: :destroy
         has_many :products
         has_many :comments, dependent: :destroy
         has_many :vessels, dependent: :destroy
         has_many :histories, through: :vessels, dependent: :destroy
         has_many :keeps, dependent: :destroy
         has_many :buckets, through: :keeps, dependent: :destroy
         has_many :faileds
        #  has_many :faileds, dependent: :destroy
         has_one_attached :avatar

  
  ##...Avatar Attachment...##
  ## Validations
  validates :avatar, file_size: { less_than_or_equal_to: 5.megabytes },
            file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif'] }

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  #  VALID_USERNAME_REGEX = /\A[a-z0-9_]{4,16}\z/
  validates :username, presence: true, 
            uniqueness: { case_sensitive: false }, 
            length: { minimum: 3, maximum: 25 }
            #  format: { with: VALID_USERNAME_REGEX }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
            uniqueness: { case_sensitive: false }, 
            length: { maximum: 105 },
            format: { with: VALID_EMAIL_REGEX }

  attr_writer :login
  validate :validate_username

  def login
    @login || username || email
  end

  def self.find_for_database_authentication warden_condition
    conditions = warden_condition.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value",
      { value: login.downcase}]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  # def username
  #   #email = john@example.com -> ['john']
  #   return self.email.split('@')[0].capitalize
  # end
  
  
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders, :history]

  def slug_candidates
    [
      :username,
      [:username, :id]
    ]
  end

  def should_generate_new_friendly_id?
    username_changed? || new_record? || slug.nil? || slug.blank?
  end
end