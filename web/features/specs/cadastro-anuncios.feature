#language: pt

Funcionalidade: Cadastro de anuncios

    #contexto é uma pré condição pro cenario
    Contexto: Login
        * Login com "teste@login.com" e "teste123"
    Cenario: Novo equipamento
        Dado que acesse o formulario de cadastro de anuncios
            E que eu tenho o sequinte equipamento:
            #passando uma tabela de coluna aonde só posso ter um registro diferente da do cadastro para realalziar o cadastro do anuncio
            | thumb     | fender-sb.jpg |
            | nome      | fender strato |
            | categoria | Cordas        |
            | preco     | 200           |
        Quando submeto o cadastro desse item
        Então devo ver esse item no meu Dashboard

    @semfoto
    Esquema do Cenario: Tentativa de cadastro de anuncios
        Dado que acesse o formulario de cadastro de anuncios
            E que eu tenho o sequinte equipamento:
            #passando uma tabela de coluna aonde só posso ter um registro diferente da do cadastro para realalziar o cadastro do anuncio
            #elementos passados pela tabela do esquema de cenario
            | thumb     | <foto>      |
            | nome      | <nome>      |
            | categoria | <categoria> |
            | preco     | <preco>     |
        Quando submeto o cadastro desse item
        Então vejo a mensagem de alerta: "<saida>"

        Exemplos:
            | foto          | nome         | categoria | preco | saida                             |
            |               | violão nilon | Outros    | 250   | Adicione uma foto no seu anúncio! |
            | clarinete.jpg | teste um     | Outros    |       | Informe o valor da diária         |
            | clarinete.jpg |              | Outros    | 250   | Informe a descrição do anúncio!   |
            | clarinete.jpg | teste dois   |           | 250   | Informe a categoria               |
            | clarinete.jpg | teste dois   | Outros    | asd   | O valor da diária deve ser numérico!               |


