class ApplicationController < ActionController::API
  def error_response(errors, status: :unauthorized)
    payload = errors.is_a?(String) ? { error: errors } : { errors: errors }
    render json: payload, status: status
  end
end
