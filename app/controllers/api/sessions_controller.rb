class Api::SessionsController < ApplicationController
  before_action :authenticate_request!

  def create
    output = AuthenticateUser.call(email: params[:email], password: params[:password])
    if output.success?
      render json: output.message
    else
      render json: { error: output.message }, status: 401
    end
  end
end
