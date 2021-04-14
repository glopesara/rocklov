#classe da pagina de cadastro
class SignupPage
  include Capybara::DSL

  def open
    visit "/signup"
  end

  #create receber de parametro user que é um hash
  def create(user)
    find("#fullName").set user[:nome]
    #Faker::Internet.free_email #para usar essa biblioteca é necessario importar dentro do env.rb
    find("#email").set user[:email]
    find("#password").set user[:senha]
    click_button "Cadastrar"
  end
end
