class Tenant < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :users, dependent: :destroy

  has_many :fields, dependent: :destroy

  accepts_nested_attributes_for :fields, allow_destroy: true
end
