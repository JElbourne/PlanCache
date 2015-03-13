class WelcomeController < ApplicationController
  def index
    @dbhost = "Hello"#ENV['DB_HOST']  
  end
end
