class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: {:error => exception.message}, status: 404
  end
end

