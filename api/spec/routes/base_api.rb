require "httparty"

class BaseApi
  #incluindo a classe no hhtpary para não precisar chamar o httparty
  include HTTParty

  #usa o base_uri para definir a url padrão do sistema, mudando apenas as rotas
  base_uri "http://rocklov-api:3333"
end
