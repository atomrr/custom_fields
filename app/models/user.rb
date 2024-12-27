class User < ApplicationRecord
  validates :first_name, :last_name, presence: true
  include Fieldable

  # need to clear fields after deletion of tenant's fields?

end
