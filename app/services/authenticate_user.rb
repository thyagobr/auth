class AuthenticateUser
  def self.call(input)
    return Failure.new("email is missing") unless input[:email]
    return Failure.new("password is missing") unless input[:password]

    user = User.find_by(email: input[:email])
    return Failure.new("user not found") unless user

    if user.authenticate(input[:password])
      Success.new(user.present)
    else
      Failure.new("authentication failed")
    end
  end
end
