# frozen_string_literal: true

require "rake-ui/engine"

module RakeUi
  mattr_accessor :allow_production
  self.allow_production = false

  # Proc that returns the current user identifier (email, username, etc.)
  # Example: RakeUi.current_user_method = ->(controller) { controller.current_user&.email }
  mattr_accessor :current_user_method
  self.current_user_method = nil

  def self.configuration
    yield(self) if block_given?
    self
  end
end
