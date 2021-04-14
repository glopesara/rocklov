#language: pt
Funcionalidade: Remover anuncios
    Contexto: login
    * Login com "teste@remover.com" e "teste123"
    @remover
    Cenario: Remover um Anuncio
    #para fazer a exlusão do anuncio eu preciso estar logado por isso vou usar o context para fazer o login
        Dado que eu tenha um anuncio indesejado:
            | thumb     | telecaster.jpg |
            | nome      | telecaster     |
            | categoria | Cordas         |
            | preco     | 200            |
        Quando eu solicito a exclusão desse item
            E confirmo a exclusão
        Entao não devo ver esse item no Dashboard

    Cenario: Desistir da exclusão
        Dado que eu tenha um anuncio indesejado:
            | thumb     | conga.jpg |
            | nome      | Conga     |
            | categoria | Cordas    |
            | preco     | 200       |
        Quando eu solicito a exclusão desse item
            Mas não confirmo a exclusão
        Entao devo ver esse item no Dashboard