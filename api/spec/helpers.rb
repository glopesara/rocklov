#craindo um modulo para fazer a estancia do arquivo yml
module Helpers
  def get_fixture(item)
    #para carreagar um arquivo YAML
    #symbolize_names: true serve para tranformar cada campo do yaml em simbulos para poder funcionar
    YAML.load(File.read(Dir.pwd + "/spec/fixtures/#{item}.yml"), symbolize_names: true)
  end

  #modulo para fazer a captura da imagem
  def get_thumb(file_name)
    #criando uma variavel da thumbnail que vai receber a foto
    #file.open é para abrir o arquivo
    #file.join
    #Dir.pwd para acessar o arquivo pela pasta raiz
    #rb somente leitrua binaria
    return File.open(File.join(Dir.pwd, "spec/fixtures/images", "#{file_name}"), "rb")
  end

  #definindo as funções do mudulo
  module_function :get_fixture
  module_function :get_thumb
end
