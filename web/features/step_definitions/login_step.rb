Dado("que acesso a página principal") do
  @login_page.open
end

Quando("submeto minhas credenciais com {string} e {string}") do |email, password|
  #classe criada na pasta pages dentro de suporte
  #estancio a classe e chamo as funções passando os dados
  @login_page.with(email, password)
end
