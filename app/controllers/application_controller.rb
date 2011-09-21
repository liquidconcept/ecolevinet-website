class ApplicationController < ActionController::Base
  protect_from_forgery

  layout Proc.new { |controller| controller.request.headers['X-PJAX'] == 'true' ? nil : 'application' }

  def call_rake(task, options = {})
    options[:rails_env] ||= Rails.env
    args = options.map { |n, v| "#{n.to_s.upcase}='#{v}'" }
    system "/usr/bin/rake #{task} #{args.join(' ')} --trace 2>&1 >> #{Rails.root}/log/rake.log &"
  end
end
