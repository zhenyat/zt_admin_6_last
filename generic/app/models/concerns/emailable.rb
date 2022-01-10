################################################################################
#   Handles and validates email attribute to be saved
################################################################################
module Emailable
  extend ActiveSupport::Concern

  included do
    before_save {self.email.downcase!}

    validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  end
end