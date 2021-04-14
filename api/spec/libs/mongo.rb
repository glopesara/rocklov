require "mongo"

#para salvar o log do mongo que aparecia no cmder
Mongo::Logger.logger = Logger.new("./logs/mong.log")

#craindo uma classe para o mongodb
class MongoDb
  #passando a ter as coleções como propriedades da classe
  attr_accessor :users, :equipos, :client

  #definindo variaveis globais dentro da classe
  def initialize
    #fazendo a conexão no banco de dados
    @client = Mongo::Client.new("mongodb://rocklov-db:27017/rocklov")

    #se conecta na coleção de user do mongo, na tabela de usuarios... e coloca em outra variavel
    @users = client[:users]

    #se conecta na coleção de user do mongo, na tabela de equipamentos... e coloca em outra variavel
    @equipos = client[:equipos]
  end

  #metodo para apagar o banco
  def drop_danger
    client.database.drop
  end

  #metodo para inserir usuarios no banco
  def insert_users(docs)
    @users.insert_many(docs)
  end

  #craindo uma função para remover usuario que recebe o email, que vai ser chamada no step de cadastro
  def remove_users(email)

    #faço a chamada para deletar todos os dados que tiverem o email usando o delete_many
    @users.delete_many({ email: email })
  end

  #criando o metodo para capturar o id do usuario no banco
  def get_user(email)
    #faço a chamada para buscar o id do usuario com find que vai trazer uma lista de usuarios
    #mas com essa condição que passo do email coloco o firt que vai trazer a esperada
    user = @users.find({ email: email }).first

    #capturo somente o _id do usuario e faço o return do metodo
    return user[:_id]
  end

  #criando um metodo para remover equipamento que recebe e nome do equipamento
  def remove_equipo(nome, user_id)
    # #chamo e metodo get_user para buscar no banco o anuncio do email utilizado da massa
    # user_id = get_user(email)

    #tenho que criar uma variavael para converter o id de string para objc id
    obj_id = BSON::ObjectId.from_string(user_id)

    #nesse caso da api não preciso do email
    #como ja capturo o user id só passo ele de parametro
    #faço a chamada para deletar o anuncio que tiver o nome e o id do usuario usando o delete_many
    @equipos.delete_many({ name: nome, user: obj_id })
  end

  #criando metodo para simular um object id falso
  def get_mongo_id
    return BSON::ObjectId.new
  end
end

# teste para retornar MongoDb.new.get_user("teste@login.com")
