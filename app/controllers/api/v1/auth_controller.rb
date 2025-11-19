class Api::V1::AuthController < ApplicationController
  before_action :authorize_request, only: [:me]

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
    auth_response(@current_user)
  end

  private

  def user_params
    params.permit(:email, :password, :token)
  end

  def user_token(user)
    JwtService.encode(user_id: user.id)
  end

  def auth_response(user, status: :ok)
    render_response(
      { user: { email: user.email }, token: user_token(user) },
      status: status
    )
  end
end
