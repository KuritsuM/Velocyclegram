class ApplicationController < ActionController::Base
  def index
    render html: "<span style=\"color: red;\">hello_world</span>"
  end
end
