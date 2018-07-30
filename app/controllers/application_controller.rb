class ApplicationController < ActionController::Base
  before_action :underscore_params!

  protect_from_forgery with: :null_session
  respond_to :json

  private
    def underscore_params!
      params.deep_transform_keys!(&:underscore)
    end
end
