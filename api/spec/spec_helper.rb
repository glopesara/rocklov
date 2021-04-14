#para não precisar mais usar require_relative nos codigos uso eles aqui
require_relative "routes/equipos"
require_relative "routes/signup"
require_relative "routes/sessions"

require_relative "libs/mongo"
require_relative "helpers"
#fazerndo require do md5 para criptrografar a senha
require "digest/md5"

#metodo para receber a senha e retornar no formato md5
def to_md5(pass)
  return Digest::MD5.hexdigest(pass)
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  #criando um metodo que vai garantir que minhas massas estejam criadas toda vez que a api for resetada
  config.before(:suite) do
    users = [
      { name: "Teste Login", email: "teste@login.com", password: to_md5("teste123") },
      { name: "Teste locador", email: "teste@locador.com", password: to_md5("teste123") },
    ]
    MongoDb.new.drop_danger
    MongoDb.new.insert_users(users)
  end
end
