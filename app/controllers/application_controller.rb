class ApplicationController < ActionController::API
  def authenticate_request!
    render json: { errors: ["unauthorized"] }, status: :unauthorized if current_app.nil?
  end

  def current_app
    token = request.headers["Authorization"].to_s.split.last
    @app ||= App.find_by(token: token)
  end
end
