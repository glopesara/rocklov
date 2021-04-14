#describe é uma pasta de testes
# require_relative serve para importar classes isso no rspec
# require_relative "routes/signup"
#classe aonde ta o mongo
# require_relative "libs/mongo"

describe "Post/signup" do
  context "usuario criado com sucesso" do
    before(:all) do
      #monto o payload com as informações do body da api
      payload = { name: "Teste Login", email: "teste@logins.com", password: "teste123" }
      #ao montar o payload chamo a Classe do mongo para fazer a exclusão do email passado no payload
      #remove user é um metodo criado no MongoDb
      MongoDb.new.remove_users(payload[:email])

      @result = Signup.new.create(payload)
    end

    it "validar codigo" do
      expect(@result.code).to eql 200
    end

    it "Validar id do usuario" do
      #para transformar o response do httparty em hash converto ele com o parsed_response coletando a quantidade de caracters
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  context "usuario ja exite" do
    before(:all) do
      #monto o payload com as informações do body da api
      payload = { name: "Teste Login Duplicado", email: "teste@logindup.com", password: "teste123" }
      #faço a chamada da criação com as massas criadas para garantir que o usuario vai estar cadastrado
      #não faço a caputura do retorno porque o usuario pode não estar cadastrado
      Signup.new.create(payload)
      #executo novamente o created mas agora com a certeza que ja esta cadastrado
      @result = Signup.new.create(payload)
    end

    it "Validar o status code" do
      expect(@result.code).to eql 409
    end
  end
  #criando exemplos para campos obrigatorios
  examples = [
    {
      title: "Sem senha",
      payload: {
        name: "teste sem senha",
        email: "teste@qualquer.com",
        password: "",
      },
      code: 412,
      error: "required password",
    },
    {
      title: "sem o campo senha",
      payload: {
        name: "teste sem o campo senha",
        email: "teste@qualquer.com",
      },
      code: 412,
      error: "required password",
    },
    {
      title: "emial em branco",
      payload: {
        name: "teste email em branco",
        email: "",
        password: "123",
      },
      code: 412,
      error: "required email",
    },
    {
      title: "sem o campo email",
      payload: {
        name: "sem o campo email",
        password: "13231",
      },
      code: 412,
      error: "required email",
    },
    {
      title: "name em branco",
      payload: {
        name: "",
        email: "teste@qualquer.com",
        password: "16532",
      },
      code: 412,
      error: "required name",
    },
    {
      title: "sem o campo name",
      payload: {
        email: "teste@qualquer.com",
        password: "1531",
      },
      code: 412,
      error: "required name",
    },
  ]
  #crio o for a estrutura do for each
  #o e guarda os hash
  examples.each do |e|
    #crio o contexto que recebe o e[:titulo]
    context "#{e[:title]}" do
      #ciro o before que sera a pre condição de todos os it
      before(:all) do
        #chamo o sing passando os e que esta guardando o payload e guardo no result
        @result = Signup.new.create(e[:payload])
      end
      it "Valida o code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end
      it "O erro deve ser #{e[:error]}" do
        #usar o parsed_response para transforamar em hash do ruby e pode ter acesso a suas propriedades
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
