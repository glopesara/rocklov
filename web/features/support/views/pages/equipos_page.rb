class EquiposPage
  include Capybara::DSL

  def create(equipo)
    #faço uma validação para saber se a classe esta visivel na pagina
    page.has_css?("#equipoForm")

    #chamando o medoto uploado
    #o if usando o lenght maior que zero que é o nuemro de carateres ou de items ne um array
    upload(equipo[:thumb]) if equipo[:thumb].length > 0

    #chamando o medoto uploado
    #o if usando o lenght maior que zero que é o nuemro de carateres ou de items ne um array
    select_cat(equipo[:categoria]) if equipo[:categoria].length > 0

    find("input[placeholder$=equipamento]").set equipo[:nome]

    find("input[placeholder^=Valor]").set equipo[:preco]

    click_button "Cadastrar"
  end

  #metodo para chamar o uploado somente se tiver option na massa
  def select_cat(cat)
    #fazendo o seletor em um select
    #faço um find no id do seletor e dentro dele seleciono o option com o texto da categoria
    #e uso o metodo select_option

    find("#category").find("option", text: cat).select_option
  end

  #metodo para chamar o uploado somente se tiver foto na massa
  def upload(file_name)
    #fazendo o upload da imagem
    #usando Dir.pwd serve para obter o caminho do diretorio principal do projeto
    # guardo na variavel thumb e chamo no find
    #como o imput esta com display: none usa o visible: false para ignorar o display
    thumb = Dir.pwd + "/features/support/fixtures/images/" + file_name
    find("#thumbnail input[type=file]", visible: false).set thumb
  end
end
