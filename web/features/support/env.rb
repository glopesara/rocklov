require "capybara"
require "capybara/cucumber"
require "faker"
require "allure-cucumber"

#configurando para acessar as configurações de ambiente dentro da pasta config
CONFIG = YAML.load_file(File.join(Dir.pwd, "features/support/config/#{ENV["CONFIG"]}"))

#recurepando a informação de qual browser usar
# BROWSER = ENV["BROWSER"]
#criando estrutura else if para salvar as informações de qual é o browser em variaveis recebendo do cucumber.yml
# if BROWSER == "firefox"
#   @driver = :selenium
# elsif BROWSER == "fire_headless"
#   @driver = :selenium_headless
# elsif BROWSER == "chrome"
#   @driver = :selenium_chrome
# elsif BROWSER == "chrome_headless"
#   @driver == :selenium_chrome_headless
# end

#criando estrutura case para salvar as informações de qual é o browser em variaveis recebendo do cucumber.yml
case ENV["BROWSER"]
when "firefox"
  @driver = :selenium
when "fire_headless"
  @driver = :selenium_headless
when "chrome"
  @driver = :selenium_chrome
when "chrome_headless"
  @driver == :selenium_chrome_headless
else
  raise "navegador incorreto"
end
Capybara.configure do |config| #bloco para fazer as configurações do capybara
  #definindo qual navegador sera acessado  "selenium = firefox" chamo o @driver da validação de qual driver foi chamado
  config.default_driver = @driver
  #para definir a url padrão do sistema testado
  #como fiz um config com a url padrão de testes uso ela
  #url é o nome do campo aonde esta a url
  config.app_host = CONFIG["url"]
  Capybara.default_max_wait_time = 10 #especifica o time out
end

#bloco de configuração do alurre
AllureCucumber.configure do |config|
  #colocando no diretorio logs
  config.results_directory = "/logs"
  #sempre que o cucumber fizer uma nova execução vai limpa o logs
  config.clean_results_directory = true
  config.logging_level = Logger::INFO
end
