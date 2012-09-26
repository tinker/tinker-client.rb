require 'sinatra/base'
require 'config'
require 'omniauth'
require 'omniauth-github'

module Tinker
  class Client < Sinatra::Base
    set :root, File.expand_path('../..', __FILE__)
    use Rack::Session::Cookie
    use OmniAuth::Builder do
      provider :github, Config['auth']['github']['id'], Config['auth']['github']['secret']
    end

    get '/' do
      locals = {
        :environment => settings.environment,
        :tinker => {},
        :dependencies => JSON.parse(File.open('config/dependencies.json', 'rb').read),
        :config => {
          :urls => Config['urls'],
          :layouts => Config['layouts']
        }
      }
      erb :index, :locals => locals
    end

    get '/auth/:provider/callback' do
      email = request.env['omniauth.auth'][:info][:email]
      session[:user] = {
        :email => email
      }
      redirect request.env['omniauth.origin'] || '/'
    end

    get '/auth/failure' do
      delete session[:user]
    end

    get '/logout' do
      delete session[:user]
    end
  end
end

