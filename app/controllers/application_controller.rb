class ApplicationController < ActionController::Base
  def pretty_json(obj, options = nil)
    render json: JSON.pretty_generate(obj.as_json(options))
  end
end
