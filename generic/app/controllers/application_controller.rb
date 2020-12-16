class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Zt  # Zeitwerk Names Notation
  before_action :set_locale
end
