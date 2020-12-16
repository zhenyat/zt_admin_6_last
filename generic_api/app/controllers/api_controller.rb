class ApiController < ActionController::API
  protect_from_forgery with: :null_session  # For APIs
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Zt  # Zeitwerk Names notification
  before_action :set_locale
end