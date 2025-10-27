# frozen_string_literal: true

require "rake-ui/engine"

module RakeUi
  mattr_accessor :allow_production
  self.allow_production = false

  mattr_accessor :current_user_method
  self.current_user_method = nil

  def self.configuration
    yield(self) if block_given?
    self
  end
end
