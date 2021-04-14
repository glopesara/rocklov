#describe é uma pasta de testes
# require_relative serve para importar classes
# require_relative "routes/sessions"
# require_relative "helpers"

describe "Post/sessions" do

  #contexto sever para validar mais de um cenario com a msm pre condição
  context "Login com sucesso" do

    #passando o before(:all) o before só sera reproduzido uma vez para as duas validações
    before(:all) do

      #payload é os parametros para passar para api feito em rash do ruby
      payload = { email: "teste@login.com", password: "teste123" }
      #estancio a classe Sessions e acesso o metodo login
      @result = Sessions.new.login(payload)
    end

    #it é o cenario de teste
    it "Validad status code" do

      #uso o .cod para capturar o status code
      expect(@result.code).to eql 200
    end

    it "Validar id do usuario" do
      #para transformar o response do httparty em hash converto ele com o parsed_response coletando a quantidade de caracters
      expect(@result.parsed_response["_id"].length).to eql 24

      #para transformar o response do httparty em hash converto ele com o parsed_response
      # puts @result.parsed_response
    end
  end

  #fazendo a craiaçaõ de massa de testes usando um array de hash
  # examples = [
  #   {
  #     title: "Senha invalida",
  #     payload: { email: "teste@login.com", password: "131" },
  #     code: 401,
  #     error: "Unauthorized",
  #   },
  #   {
  #     title: "Emial não cadastrado",
  #     payload: { email: "404teste@login.com", password: "131" },
  #     code: 401,
  #     error: "Unauthorized",
  #   },
  #   {
  #     title: "Emial em branco",
  #     payload: { email: "", password: "131" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "Sem o campo e-mail",
  #     payload: { password: "131" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "Senha em branco",
  #     payload: { email: "teste@login.com", password: "" },
  #     code: 412,
  #     error: "required password",
  #   },
  #   {
  #     title: "Sem o campo senha",
  #     payload: { email: "teste@login.com" },
  #     code: 412,
  #     error: "required password",
  #   },
  # ]

  #por Helpers sem um modulo, usasse :: e não .new
  examples = Helpers::get_fixture("login")

  #faço um for each aonde o e é a variavel que representa cada hash do array
  examples.each do |e|
    context "#{e[:title]}" do

      #passando o before(:all) o before só sera reproduzido uma vez para as duas validações
      before(:all) do

        #estancio a classe Sessions e acesso o metodo login
        # payload = { email: "teste@login.com", password: "131" }
        #retiro o payload antigo e adiciono o payload que está na variavel e
        #assim eu passo o new.login(e[:payload])
        @result = Sessions.new.login(e[:payload])
      end

      #it é o cenario de teste
      it "Valida status code #{e[:code]}" do

        #uso o .cod para capturar o status code
        expect(@result.code).to eql e[:code]
      end

      it "Validar mensagem de erro #{e[:error]}" do
        #para transformar o response do httparty em hash converto ele com o parsed_response e passo o campo error
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
