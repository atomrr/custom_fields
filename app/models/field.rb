class Field < ApplicationRecord
  validates :name, :type, presence: true

  belongs_to :tenant

  def validation_options
    raise NotImplementedError
  end
end
