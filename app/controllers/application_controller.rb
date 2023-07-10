class ApplicationController < ActionController::Base
  include AuthHelper
  include Pundit::Authorization
end
