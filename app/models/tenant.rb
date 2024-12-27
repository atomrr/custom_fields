class Tenant < ApplicationRecord
  # maybe STI with User
  validates :first_name, :last_name, presence: true

  has_many :fields, dependent: :destroy
  has_many :users, dependent: :destroy

  accepts_nested_attributes_for :fields
end
