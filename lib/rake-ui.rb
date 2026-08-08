# frozen_string_literal: true

require "rake-ui/engine"

module RakeUi
  mattr_accessor :allow_production
  self.allow_production = false

  mattr_accessor :current_user_method
  self.current_user_method = nil

  # Tasks whose name begins with one of these prefixes are visible. Note that
  # a prefix cannot separate a task from its subtasks: "db:migrate" also allows
  # "db:migrate:reset". Use whitelisted_tasks when you need exact names.
  mattr_accessor :whitelisted_prefixes
  self.whitelisted_prefixes = []

  # Tasks named exactly in this list are visible, and nothing else is implied.
  # Combined with whitelisted_prefixes, a task is visible when it matches
  # either. With both empty, every task is visible.
  mattr_accessor :whitelisted_tasks
  self.whitelisted_tasks = []

  # Storage backend: :file (default) or :database
  mattr_accessor :storage_backend
  self.storage_backend = :file

  def self.configuration
    yield(self) if block_given?
    self
  end

  def self.store
    @store = nil if @last_storage_backend != storage_backend
    @last_storage_backend = storage_backend

    @store ||= case storage_backend.to_sym
    when :file
      RakeUi::Storage::FileStore.new
    when :database
      RakeUi::Storage::DatabaseStore.new
    else
      raise ArgumentError, "Unknown RakeUi storage_backend: #{storage_backend}. Use :file or :database."
    end
  end
end
