class Api::V1::AuthController < ApplicationController
  def signup
    user = User.create(user_params)

    if user.persisted?
      auth_response(user, status: :created)
    else
      error_response(
        user.errors.to_hash(full_messages: true),
        status: :unprocessable_content
      )
    end
  end

  def login
    user = User.find_by(email: user_params[:email]&.downcase)

    if user&.authenticate(user_params[:password])
      auth_response(user)
    else
      error_response("Invalid credentials")
    end
  end

  def me
    if authorize_request
      auth_response(@current_user)
    else
      error_response("Unauthorized")
    end
  end

  private

  def user_params
    params.permit(:email, :password, :token)
  end

  def user_token(user)
    JwtService.encode(user_id: user.id)
  end

  def auth_response(user, status: :ok)
    render json: { user: { email: user.email }, token: user_token(user) },
           status: status
  end

  def authorize_request
    header = request.headers["Authorization"]
    token = header.split.last if header.present?
    decoded = JwtService.decode(token)
    @current_user = User.find_by(id: decoded["user_id"]) if decoded
  end
end
