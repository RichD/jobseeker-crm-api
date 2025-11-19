class ApplicationController < ActionController::API
  def render_response(data, status: :ok)
    status == :no_content ? head(status) : render(json: data, status: status)
  end

  def error_response(errors, status: :unauthorized)
    payload = errors.is_a?(String) ? { error: errors } : { errors: errors }
    render_response(payload, status: status)
  end

  def authorize_request
    header = request.headers["Authorization"]
    token = header.split.last if header.present?
    decoded = JwtService.decode(token)
    @current_user = User.find_by(id: decoded["user_id"]) if decoded

    error_response("Unauthorized") unless @current_user
  end
end
