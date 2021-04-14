#objeto da rota sessions do login
#não preciso mais do HTTPArty
# require "httparty"
#faço o require relatice para o base api
require_relative "base_api"

#faço a herança do BaseApi para utilizar o HTTParty e a base uri comentadas
class Sessions < BaseApi
  #removo o base_uri e o include HTTParty

  #   #incluindo a classe no hhtpary para não precisar chamar o httparty
  #   include HTTParty

  #   #usa o base_uri para definir a url padrão do sistema, mudando apenas as rotas
  #   base_uri "http://rocklov-api:3333"

  def login(payload)

    #para fazer uma requisição post colando a url da rota da api
    #metodo antigo sem o include httparty return HTTParty.post
    #uso o self.class.post para poder fazer uma chamada via post

    return self.class.post(
             #url do serviço da api
             "/sessions",

             #converto o payload para json no corpo da aquisição
             body: payload.to_json,

             #na terceira o cabeçario
             headers: {
               "Content-Type": "application/json",
             },
           )
  end
end
