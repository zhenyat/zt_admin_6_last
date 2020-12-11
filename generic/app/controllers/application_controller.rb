class ApplicationController < ActionController::Base
  include Zt  # Zeitwerk
#  protect_from_forgery with: :exception
  before_action :set_locale
end
