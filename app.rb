require "sinatra"
require "active_record"
require "rack-flash"
require "./lib/database_connection"

class App < Sinatra::Application
  enable :sessions
  use Rack::Flash


  def initialize
    super
    @database_connection = DatabaseConnection.establish(ENV["RACK_ENV"])
  end


  get "/" do

    erb :home

  end
  post "/emails" do


    @database_connection.sql("INSERT INTO users (email) VALUES ('#{params[:email]}')")
    flash[:notice] = "Thank you for registering"
    redirect "/"
  end


end