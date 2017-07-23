require 'rspec'
require 'rspec/expectations'
require 'rack/test'
require 'json'
require 'base64'


require 'helpers/spec_helper'


RSpec.configure do |c|
  c.include TestHelpers
  c.around do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
end
