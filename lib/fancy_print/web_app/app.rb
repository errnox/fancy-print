require 'sinatra/base'
require 'sinatra/asset_pipeline'
require 'sinatra/activerecord'
require 'sinatra/rroute'
require 'haml'
require 'json'
require 'diffy'
require 'github/markup'
require 'yaml'


module FancyPrint
  class App < Sinatra::Base
    register Sinatra::AssetPipeline
    register Sinatra::Rroute
    register Sinatra::ActiveRecordExtension

    def initialize
      require_relative 'runner'
      Thread.new do
        FancyPrint::Runner.run()
      end
      super()
    end

    configure do
      # ActiveRecord
      db_dir = File.expand_path('../../..', File.dirname(__FILE__))
      if ENV['RACK_ENV'] == 'development'
        set :database, "sqlite3:#{db_dir}/development.sqlite3"
      elsif ENV['RACK_ENV'] == 'test'
        set :database, "sqlite3:#{db_dir}/test.sqlite3"
      else
        set :database, "sqlite3:#{db_dir}/db.sqlite3"
      end

      # Diverse
      config_file = File.expand_path('../../..', File.dirname(__FILE__)) +
        '/bin/config.yaml'
      config = YAML.load_file(config_file)
      set :websocket, {
        :host => config[:websocket_host],
        :port => config[:websocket_port],
      }

      # XSS Protection
      set :no_xss, config[:no_xss]
    end

    # Serve static font files.
    get '/fonts/:file' do
      file = File.dirname(__FILE__) +
        '/assets/stylesheets/partials/fonts/' + params[:file]
      if File.exists?(file)
        f = File.open(file)
        return f
      else
        status 500
      end
    end

  end

  require_relative 'models/init'
  require_relative 'helpers/init'
  require_relative 'routes/init'
  require_relative 'controllers/init'
end
