class UsersController < ApplicationController

  def show
    render json: user
  end

  def create
    @user = User.new(permitted_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_content
    end
  end

  def update
    user.assign_attributes(permitted_params_for_user)
    if user.save
      render json: user
    else
      render json: user.errors, status: :unprocessable_content
    end
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def permitted_params
    params.permit(*attribute_names)
  end

  def permitted_params_for_user
    params.permit(*with_custom_attributes)
  end

  def attribute_names
    [
        :first_name,
        :last_name,
        :email,
        :tenant_id
    ]
  end


  # Build attribute list for permitted params with
  # custom fields of Tenant instance
  def with_custom_attributes
    attribute_names + custom_attrs
  end

  # Build tenant's custom fields attribute list for permitted params
  def custom_attrs
    user.fields.map do |field|
      field.is_a?(MultipleChoice) ? ({ field.name.to_sym => [] }) : (field.name.to_sym)
    end
  end
end
