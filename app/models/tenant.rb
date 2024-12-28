class Tenant < ApplicationRecord
  # maybe STI with User
  validates :first_name, :last_name, presence: true

  has_many :users, dependent: :destroy

  has_many :fields, dependent: :destroy

  accepts_nested_attributes_for :fields, allow_destroy: true
end
