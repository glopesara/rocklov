describe "Post / equipos/booking" do
  #crio um befor dentro do describe para fazer o login e capturar o id do usuario que vai ser o locador
  before(:all) do
    #payload é os parametros para passar para api feito em rash do ruby
    payload = { email: "teste@locador.com", password: "teste123" }
    #estancio a classe Sessions e acesso o metodo login
    #criar uma varivel para receber a instancia do loging
    result = Sessions.new.login(payload)
    #capturo o id do usuario, criar outra variavel para isso
    @locador_id = result.parsed_response["_id"]
  end
  context "solicitar locação" do
    before(:all) do
      #faço o login com o teste para capturar o id
      result = Sessions.new.login(email: "teste@login.com", password: "teste123")
      result_id = result.parsed_response["_id"]
      #dado que eu tenha uma conta com o equipamento cadastrado
      payload = { thumbnail: Helpers::get_thumb("fender-sb.jpg"),
                  name: "Fender",
                  category: "Cordas",
                  price: 100 }
      #removo o equipamento
      MongoDb.new.remove_equipo(payload[:name], result_id)
      #faço a criação do equipamento
      result = Equipos.new.create(payload, result_id)
      #pego o id do equipamento criado
      result_equipo_id = result.parsed_response["_id"]

      #faço a captura do serviço do booking
      #o login da outra conta realizo no before
      @result = Equipos.new.booking(result_equipo_id, @locador_id)
    end

    it "Validar o status code 200" do
      expect(@result.code).to eql 200
    end
  end
end
