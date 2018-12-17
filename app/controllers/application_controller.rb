class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def not_authorized
    render '{"error": "not_authorized"}', status: :unauthorized
  end

  def not_found
    render '{"error": "not_found"}', status: :not_found
  end
end
