Dado("Login com {string} e {string}") do |email, password|
  @email = email

  @login_page.open
  @login_page.with(email, password)
  #checkpoint para garantir que só vai para o proximo passo quando estiver no dashboard
  expect(@dash_page.on_dash?).to be true
end

Dado("que acesse o formulario de cadastro de anuncios") do
  @dash_page.go_equipo_form
end

Dado("que eu tenho o sequinte equipamento:") do |table|
  #rows_hash metodo que tranforama uma tabela de coluna para um obejto de ruby
  @anuncio = table.rows_hash

  #chamo o metodo do criado no libis do mongo para garantir que o anuncio não esteja cadastrado no banco.
  MongoDb.new.remove_equipo(@anuncio[:nome], @email)
end

Quando("submeto o cadastro desse item") do
  @equipos_page.create(@anuncio)
end

Então("devo ver esse item no meu Dashboard") do
  #epero que dento de equipo-list contenha o nome do anuncio
  expect(@dash_page.equipo_list).to have_content @anuncio[:nome]
  #epero que dento de equipo-list contenha o preço do anuncio
  expect(@dash_page.equipo_list).to have_content "R$#{@anuncio[:preco]}/dia"
end

#remover anuncios

Dado("que eu tenha um anuncio indesejado:") do |table|
  #para capturar o id do usuario logado
  #o comando pode ser rodado no console e tera as informaões do local storege
  #uso o return para ele devolver o valor do id
  #para não dar conflito nas "" coloco '' no do javascript
  user_id = page.execute_script("return localStorage.getItem('user')")
  log user_id
  #codigo para abrir o arquivo e devolve no tipo file, esta no helpers da api
  thumbnail = File.open(File.join(Dir.pwd, "features/support/fixtures/images", table.rows_hash[:thumb]), "rb")
  #criando equipo
  @equipo = {
    #table.rows_hash para transformar o table do rub em hash
    thumbnail: thumbnail,
    name: table.rows_hash[:nome],
    category: table.rows_hash[:categoria],
    price: table.rows_hash[:preco],
  }
  EquiposService.new.create(@equipo, user_id)

  #acessa a pagina atual e faz um refresh
  visit current_path
end

Quando("eu solicito a exclusão desse item") do
  @dash_page.request_removal(@equipo[:name])
end

Quando("confirmo a exclusão") do
  @dash_page.confirme_remove
end

Entao("não devo ver esse item no Dashboard") do
  expect(@dash_page.hass_no_equipo?(@equipo[:name])).to be true
end
