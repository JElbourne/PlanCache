class WelcomeController < ApplicationController
  def index
    @dbhost = ENV['DB_HOST']  
  end
end
