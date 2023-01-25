# frozen_string_literal: true

require 'resque/tasks'
require 'resque/scheduler/tasks'

namespace :resque do
  task setup: :environment do
    require 'resque'

    resque_config = YAML.load_file Rails.root.join('config/resque.yml')

    Resque.redis = resque_config['development']
  end

  task setup_schedule: :setup do
    require 'resque-scheduler'

    Resque::Scheduler.dynamic = true
  end

  task scheduler: :setup_schedule
end

Resque.after_fork = proc { ActiveRecord::Base.establish_connection }
