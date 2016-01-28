class SessionsController < ApplicationController
  
  def new

  end

  def create
    binding.pry
    request.env['omniauth.auth']
  end

end
