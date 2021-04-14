#classe criada para components de alerta
class Alert
  include Capybara::DSL

  def dark
    return find(".alert-dark").text
  end
end
