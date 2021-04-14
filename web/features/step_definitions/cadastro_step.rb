Dado("que acesso a página de cadastro") do
  @signup_page.open
end

Quando("submeto o seguinte formulario de cadastro:") do |table|
  #transformo a tabela em um array de hashes e coleto o primeiro dado dela por ter apenas um usuario
  #assim posso usar as informações do usuario como objeto
  #o first é a mesma coisa que table.hashes[0] porque só tenho um usuario
  user = table.hashes.first

  #passo o hase user para o metodo create
  @signup_page.create(user)

  #faço  a instancia da classe do mongo db, ja chamando o metodo para remover usuario
  MongoDb.new.remove_users(user[:email])
end

# Quando('submeto o meu cadastro sem o nome') do
#     #para usar essa biblioteca é necessario importar dentro do env.rb
#     find('#email').set Faker::Internet.free_email
#     find('#password').set "teste123"
#     click_button 'Cadastrar'
# end
