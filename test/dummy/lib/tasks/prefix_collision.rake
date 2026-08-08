# frozen_string_literal: true

# These two mirror the shape of db:migrate and db:migrate:reset: one task's full
# name is a prefix of the other's, so prefix matching cannot tell them apart.
desc "Task that is safe to expose"
task :migrate_like do
  puts "migrate_like"
end

namespace :migrate_like do
  desc "Task that must not ride along when migrate_like is allowed"
  task :destroy_everything do
    puts "destroy_everything"
  end
end
