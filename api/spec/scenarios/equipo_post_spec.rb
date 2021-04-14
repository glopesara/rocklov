# require_relative "routes/equipos"

describe "Post / equipos" do
  #crio um befor dentro do describe para fazer o login e capturar o id do usuario
  before(:all) do
    #payload é os parametros para passar para api feito em rash do ruby
    payload = { email: "teste@login.com", password: "teste123" }
    #estancio a classe Sessions e acesso o metodo login
    #criar uma varivel para receber a instancia do loging
    result = Sessions.new.login(payload)
    #capturo o id do usuario, criar outra variavel para isso
    @user_id = result.parsed_response["_id"]
  end
  context "novo equipo" do
    before(:all) do
      #para chamar fazer o envio do thumb utilizo o mudulo cirado no helpers
      payload = { thumbnail: Helpers::get_thumb("kramer.jpg"),
                  name: "Teste Kramer",
                  category: "Cordas",
                  price: 100 }
      #passo o payload e o user id que vai ser usado no header
      MongoDb.new.remove_equipo(payload[:name], @user_id)
      #capturo a criação do equipamento
      @result = Equipos.new.create(payload, @user_id)
    end

    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end
  end

  context "não autorizado" do
    before(:all) do
      #para chamar fazer o envio do thumb utilizo o mudulo cirado no helpers
      payload = { thumbnail: Helpers::get_thumb("baixo.jpg"),
                  name: "Contra Baixo",
                  category: "Cordas",
                  price: 100 }
      #passo o payload e o user id que vai ser usado no header
      #não preciso remover do banco
      # MongoDb.new.remove_equipo(payload[:name], @user_id)
      #vou passar o user id como nulo usando nil
      @result = Equipos.new.create(payload, nil)
    end

    it "deve retornar 401" do
      expect(@result.code).to eql 401
    end
  end
end
