class TenantsController < ApplicationController

  def show
    render json: tenant, include: { fields: { only: [:id, :name, :type, :data] } }
  end

  def create
    @tenant = Tenant.new(permitted_params)
    if @tenant.save
      render json: @tenant, include: { fields: { only: [:id, :name, :type, :data] } }
    else
      render json: @tenant.errors, status: :unprocessable_content
    end
  end

  def update
    tenant.assign_attributes(permitted_params)
    begin
      if tenant.save
        render json: tenant, include: { fields: { only: [:id, :name, :type, :data] } }
      else
        render json: tenant.errors, status: :unprocessable_content
      end
    rescue ActiveRecord::RecordNotDestroyed => e
      tenant.errors.add(:fields, "Field :#{e.record&.name} is in use. Clear content before deletion")
      render json: tenant.errors, status: :unprocessable_content
    end
  end

  private

  def tenant
    @tenant ||= Tenant.find(params[:id])
  end

  def permitted_params
    params.permit(
        :first_name,
        :last_name,
        :email,
        fields_attributes: [
            :id, :name, :type, :_destroy, data: []
        ]
    )
  end
end
