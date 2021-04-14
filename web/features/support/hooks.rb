#canchos oande faço uma ação antes de cada cenario

#faço um befor para fazer minha classe ser uma variavel padrão
Before do
  @login_page = LoginPage.new
  @signup_page = SignupPage.new
  @dash_page = DashBoard.new
  @equipos_page = EquiposPage.new
  @alert = Alert.new

  # codigo para maximizar a pagina do navegador
  # page.driver.browser.manage.window.maximize

  #definindo um tamanho da janela padrão
  page.current_window.resize_to(1440, 900)
end

#faço um after para executar depois de casa cenario
After do
  #save_screenshot serve para tirar um print a qualquer momento
  #passo o local aonde vou salvar o print
  tempo_shot = page.save_screenshot("logs/temp_screenshot.png")

  #chamo o modulo do alure para salvar a evidencia
  #cada linha passo um argumento
  Allure.add_attachment(
    #link para acessar a foto
    name: "Screenshot",
    #tipo do aquivo
    type: Allure::ContentType::PNG,
    #aonde está o aruqivo que esta na temp shot
    source: File.open(tempo_shot),
  )
end
