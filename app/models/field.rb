class Field < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :tenant_id }, exclusion: { in: User.column_names }
  validates :type, presence: true

  belongs_to :tenant

  before_destroy :stop_destroy_if_in_use

  # Adds options for fields ActiveSupport validations
  # required def for descendants
  def validation_options
    raise NotImplementedError
  end


  # Prevents field deletion when users use field with semantic value
  def stop_destroy_if_in_use
    throw(:abort) if prevent_destroy?
  end

  # Find any valuable usage of field
  def prevent_destroy? #TODO rebuild via jsonb search
    # tenant.users.where("(data->'#{name}') is not null")
    # need query with the same semantic as
    # tenant.users.where.not(data: {name.to_sym => [nil, '', []]}).limit(1).any?
    tenant.users.any?{|user| user.public_send(name.to_sym).present?}
  end
end
