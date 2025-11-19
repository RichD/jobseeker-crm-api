module RequestHelpers
  def auth_headers_for(user)
    token = JwtService.encode(user_id: user.id)
    { "Authorization" => "Bearer #{token}" }
  end

  def json_response
    if response&.body.present?
      response.parsed_body
    else
      {}
    end
  end
end
