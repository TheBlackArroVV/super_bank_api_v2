module AuthenticationHelper
  def current_user
    return nil unless @_request.headers['Auth-Token']

    token = ::AuthToken.find(token: @_request.headers['Auth-Token'])

    return nil unless token

    User.find(id: token.user_id)
  end

  def user_not_found
    return true if current_user

    @_response.status = 401
    false
  end

  def authenticate_user!
    @_request.halt unless user_not_found
  end
end
