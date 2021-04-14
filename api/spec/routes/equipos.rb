#objeto da rota sessions do login
#não preciso mais do HTTPArty
# require "httparty"
#faço o require relatice para o base api
require_relative "base_api"

#faço a herança do BaseApi para utilizar o HTTParty e a base uri comentadas
class Equipos < BaseApi
  #alem do payload recebe o user id no de parametro para usar no cabeçalho
  def create(payload, user_id)
    return self.class.post(
             "/equipos",
             #não preciso converter para json porque a api não recebe em formato de json
             body: payload,
             headers: {
               #passo o user id para o reder
               "user_id": user_id,
             },
           )
  end

  #o metodo de busca do equipamento pelo id recebe o id do equipamento e o user id
  def find_by_id(equipo_id, user_id)
    return self.class.get(
             #na rota passo o equipo id
             "/equipos/#{equipo_id}",
             headers: {
               #passo o user id para o header para ter a altorização para consultar
               "user_id": user_id,
             },
           )
  end

  #o metodo que remove o equipamento pelo id recebe o id do equipamento e o user id
  def remove_by_id(equipo_id, user_id)
    return self.class.delete(
             #na rota passo o equipo id
             "/equipos/#{equipo_id}",
             headers: {
               #passo o user id para o header para ter a altorização para consultar
               "user_id": user_id,
             },
           )
  end

  #metodo para fazer a solicitação do equipamento
  def booking(equipo_id, user_locator_id)
    return self.class.post(
             #na rota passo o equipo id
             "/equipos/#{equipo_id}/bookings",
             #faço a captura da data atual com o time.now
             body: { date: Time.now.strftime("%d/%m/%Y") }.to_json,
             headers: {
               #passo o user id para o header para ter a altorização para consultar
               "user_id": user_locator_id,
             },
           )
  end
end
