#arquivo para criar uma classe para importar o httparty
require "httparty"

class BaseService
  include HTTParty
  base_uri "http://rocklov-api:3333"
end
