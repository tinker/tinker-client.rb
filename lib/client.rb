require 'sinatra/base'
require 'config'
require 'httparty'
require 'omniauth'
require 'omniauth-github'

module Tinker
  class Client < Sinatra::Base
    set :root, File.expand_path('../..', __FILE__)
    use Rack::Session::Cookie
    use OmniAuth::Builder do
      provider :github, Config['auth']['github']['id'], Config['auth']['github']['secret']
    end

    get %r{^(?:/([A-Za-z0-9_]+))?/(?:([A-Za-z0-9]{5})(?:/([0-9]+))?/?)?$} do |username, hash, revision|
      tinker = nil
      dependencies = nil
      if (hash)
        revision ||= 0
        response = HTTParty.get(Config['urls']['api']+'/tinkers/'+hash+'/'+revision.to_s)
        tinker = JSON.parse response.body
      end
      if File.exists? 'config/dependencies.json'
        begin
          dependencies = JSON.parse File.open('config/dependencies.json', 'rb').read
        rescue JSON::ParserError => e
          p "Failed to parse dependencies"
        end
      end
      locals = {
        :environment => settings.environment,
        :tinker => tinker,
        :dependencies => dependencies,
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

