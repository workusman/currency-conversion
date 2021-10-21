class Api::V1::BaseController < ApplicationController
  include ErrorHandler
  include Secured
end
