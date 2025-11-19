module RequestHelpers
  def auth_headers_for(user)
    token = JwtService.encode(user_id: user.id)
    { "Authorization" => "Bearer #{token}" }
  end

  def json_response
    response.parsed_body if response.body.present?
  end
end
