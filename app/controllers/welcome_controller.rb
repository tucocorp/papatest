class WelcomeController < ApplicationController
  include Response

  def status
    response = 'PAPATEST WORKING FINE!'
    json_response(response, :ok)
  end
end
