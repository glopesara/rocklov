#pata para adicionar steps compartilhados

Então("sou redirecionado para o Dashboard") do
  #agora ele bate no metodo que responde se o dashboard está disponivel e responde sim
  expect(@dash_page.on_dash?).to be true #have_css '.dashboard' #verfifica se na pagina contem o css
end

Então("vejo a mensagem de alerta: {string}") do |alerta|
  #chamo a função do @login_page do alert_dark
  expect(@alert.dark).to have_text alerta
end
