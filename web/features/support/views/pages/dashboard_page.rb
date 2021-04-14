#classe da pagina dashboard

class DashBoard
  include Capybara::DSL

  def go_equipo_form
    click_button "Criar anúncio"
  end

  def equipo_list
    return find(".equipo-list")
  end

  #metodo que retorna verdadeiro ou falso se esta direcionando para tela do dashbord
  def on_dash?
    return page.has_css?(".dashboard")
  end

  def request_removal(name)
    #faço um find na classe equipo list que contem a lista de equipamentos
    #uso o ,text: para procurar o que contem o texto
    equipo = find(".equipo-list li", text: name)
    #agora faço uma busca dentro do elemento
    equipo.find(".delete-icon").click
  end

  def confirme_remove
    #clica no elemento que contem o texto sim
    click_on "Sim"
  end

  #retorna verdadeiro ou falso
  def hass_no_equipo?(name)
     #metodo que retornar verdadeiro ou falso
  #retorna verdadeiro se não encontrar o css buscado na pagina
    return page.has_no_css?(".equipo-list li", text: name)
  end
end
