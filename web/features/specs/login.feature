#language: pt

Funcionalidade: Login
    Sendo um usuário cadastrado
    Quero acessar o sistema da Rocklov
    Para que eu possa anunciar meus equipamentos musicais

    @login
    Cenario: Login do usuário

        Dado que acesso a página principal
        #usar argumento quando for <= a 2 argumentos e o table >2
        Quando submeto minhas credenciais com "teste@login.com" e "teste123"
        #chamado no shared
        Então sou redirecionado para o Dashboard

    @tentativa_login
    Esquema do Cenario: Login invalido
        Dado que acesso a página principal
        #faço a aquisição para tabela de exemplos
        Quando submeto minhas credenciais com "<email_input>" e "<password_input>"
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
            | email_input     | password_input | mensagem_output                  |
            | teste@login.com | 131231         | Usuário e/ou senha inválidos.    |
            | abcd@login.com  | teste123       | Usuário e/ou senha inválidos.    |
            | teste*login.com | teste132       | Oops. Informe um email válido!   |
            |                 | teste132       | Oops. Informe um email válido!   |
            | teste@login.com |                | Oops. Informe sua senha secreta! |




#usar esquema do cenario por conta da repetição
# Cenario: Senha incorreta

#     Dado que acesso a página principal
#     Quando submeto minhas credenciais com senha incorreta
#     Então vejo a mensagem de alerta: Usuário e/ou senha inválidos.

# Cenário: Email não cadastrado

#     Dado que acesso a página principal
#     Quando submeto minhas credenciais com email que não existe na Rocklov
#     Então vejo a mensagem de alerta: Usuário e/ou senha inválidos.

# Cenario: Email incorreto

#     Dado que acesso a página principal
#     Quando submeto minhas credenciais com email incorreto
#     Então vejo a mensagem de alerta: Oops. Informe um email válido!

# Cenario: Email não informado

#     Dado que acesso a página principal
#     Quando submeto minhas credenciais sem o email
#     Então vejo a mensagem de alerta: Oops. Informe um email válido!

# Cenario: Senha não informada

#     Dado que acesso a página principal
#     Quando submeto minhas credenciais sem a senha
#     Então vejo a mensagem de alerta: ops. Informe sua senha secreta!