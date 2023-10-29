class User < ApplicationRecord
  has_secure_password #validations: false

  validates :email, presence: true
  validates_uniqueness_of :email
  validates :language_id, inclusion: { in: Language.all.pluck(:id) }
  normalizes :email, with: -> email { email.strip.downcase }

  has_many :rights, dependent: :delete_all
  has_many :comments, dependent: :destroy
  has_many :items
  has_many :events
  has_many :languages, through: :rights
  belongs_to :language

  generates_token_for :password_reset, expires_in: 5.minutes do
    password_salt&.last(10)
  end

  def named
    if nick?
      nick
    else
      email.split("@")[0].capitalize
    end
  end

  def role
    if admin?
      "LC"
    else
      r = rights.find_by(language_id: Language.find_by( id: language_id ) )
      if r 
        r.role 
      else
        false 
      end 
    end
  end
end
