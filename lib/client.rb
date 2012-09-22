require 'sinatra/base'

CONF = JSON.parse File.open('config/config.json', 'rb').read

class Client < Sinatra::Base
  set :root, File.expand_path('../..', __FILE__)

  get '/' do
    locals = {
      :environment => settings.environment,
      :tinker => {},
      :dependencies => JSON.parse(File.open('config/dependencies.json', 'rb').read),
      :config => {
        :urls => CONF['urls'],
        :layouts => CONF['layouts']
      }
    }
    erb :index, :locals => locals
  end
end

