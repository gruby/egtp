class Language < ApplicationRecord
  has_many :rights
  has_many :users, through: :rights
  validates_uniqueness_of :name
end