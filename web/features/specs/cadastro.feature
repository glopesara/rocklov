#language: pt
Funcionalidade: Cadastro
    Sendo um músico que possui equipamentos musicais
    Quero fazer o meu cadastro no RockLov
    Para que eu possa disponibilizá-los para locação

    @cadastro
    Cenario: Fazer cadastro

        Dado que acesso a página de cadastro
        #enviando os dados por meio de tabela
        Quando submeto o seguinte formulario de cadastro:
            | nome        | email           | senha    |
            | Teste Teste | teste@teste.com | teste123 |
        #chamado no shared
        Então sou redirecionado para o Dashboard

    @tentativa_cadastro
    #Esquema do Cenario, é um cenario aonde eu preciso adicionar os exemplos do cenario
    Esquema do Cenario: Tentativa de cadastro
        Dado que acesso a página de cadastro
        #enviando os dados por meio de tabela,para fazer isso com esquema do cenario, passo os campos do place holder
        Quando submeto o seguinte formulario de cadastro:
            | nome         | email         | senha         |
            | <nome_input> | <email_input> | <senha_input> |
        #o output vai sempre no resultado esperado
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
            #place holder
            | nome_input  | email_input     | senha_input | mensagem_output                  |
            |             | teste@teste.com | teste123    | Oops. Informe seu nome completo! |
            | Teste Teste |                 | teste123    | Oops. Informe um email válido!   |
            | Teste Teste | teste*teste.com | teste123    | Oops. Informe um email válido!   |
            | Teste Teste | teste@teste.com |             | Oops. Informe sua senha secreta! |


# @tentativa_cadastro
# #usando o esquema de cenario por que os casos só mudam o input e o output
# Cenario: Submeter cadastro sem o nome

#     Dado que acesso a página de cadastro
#     #usando a tabela do formulario de cadastro para aproveitar e fazer o reuso do codigo, não passando o nome
#     Quando submeto o seguinte formulario de cadastro:
#         |nome       |email          |senha   |
#         |           |teste@teste.com|teste123|
#     Então vejo a mensagem de alerta: "Oops. Informe seu nome completo!"

# @tentativa_cadastro
# Cenario: Submeter cadastro sem o email

#     Dado que acesso a página de cadastro
#     Quando submeto o seguinte formulario de cadastro:
#         |nome       |email          |senha   |
#         |Teste Teste|               |teste123|
#     Então vejo a mensagem de alerta: "Oops. Informe um email válido!"

# @tentativa_cadastro
# Cenario: Submeter cadastro com email incorreto

#     Dado que acesso a página de cadastro
#     Quando submeto o seguinte formulario de cadastro:
#         |nome       |email          |senha   |
#         |Teste Teste|teste*teste.com|teste123|
#     Então vejo a mensagem de alerta: "Oops. Informe um email válido!"

# @tentativa_cadastro
# Cenario: Submeter cadastro sem a senha

#     Dado que acesso a página de cadastro
#     Quando submeto o seguinte formulario de cadastro:
#         |nome       |email          |senha   |
#         |Teste Teste|teste@teste.com|        |
#     Então vejo a mensagem de alerta: "Oops. Informe sua senha secreta!"
