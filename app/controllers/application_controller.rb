class ApplicationController < ActionController::Base
  protect_from_forgery

  layout Proc.new { |controller| controller.request.headers['X-PJAX'] == 'true' ? nil : 'application' }

end
