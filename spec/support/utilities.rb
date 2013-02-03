def sign_in(user)
  cookies[:remember_token] = user.remember_token
end
