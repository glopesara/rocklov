describe "Get / equipos {equipo_id}" do
  before(:all) do
    #payload é os parametros para passar para api feito em rash do ruby
    payload = { email: "teste@login.com", password: "teste123" }
    #estancio a classe Sessions e acesso o metodo login
    #criar uma varivel para receber a instancia do loging
    result = Sessions.new.login(payload)
    #capturo o id do usuario, criar outra variavel para isso
    @user_id = result.parsed_response["_id"]
  end
  context "get unico equipo" do
    before(:all) do
      #para chamar fazer o envio do thumb utilizo o mudulo cirado no helpers
      @payload = { thumbnail: Helpers::get_thumb("violino.jpg"),
                   name: "violino",
                   category: "Cordas",
                   price: 100 }
      #passo o payload e o user id que vai ser usado no header
      MongoDb.new.remove_equipo(@payload[:name], @user_id)
      #uso o cadastro como uma pré condição para capturar o id do equipamento
      equipo = Equipos.new.create(@payload, @user_id)
      #faço a captura do id do equipamento
      @equipo_id = equipo.parsed_response["_id"]
      #mando o id do equipo e o user id para o metodo find
      @result = Equipos.new.find_by_id(@equipo_id, @user_id)
    end
    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end
    it "deve retornar o nome" do
      #uso o include para saber se dentro do campo NAME contem o valor do payload name
      expect(@result.parsed_response).to include("name" => @payload[:name])
    end
  end

  context "equipo não existe" do
    before(:all) do
      @result = Equipos.new.find_by_id(MongoDb.new.get_mongo_id, @user_id)
    end
    it "deve retornar 404" do
      expect(@result.code).to eql 404
    end
  end
end
