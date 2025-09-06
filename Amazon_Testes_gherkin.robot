*** Settings ***
Documentation     Suite de testes do site da Amazon com Gherkin
Resource          amazon_gherkin_resources.robot  

Test Setup        Abrir o navegador na home da Amazon
Test Teardown     Fechar o navegador


***Test Cases ***

Caso de Teste 01 - Acesso ao menu "Eletronicos"
    [Documentation]     Esse teste verifica o menu eletronico do site da Amazon.com.br
    ...                 e verifica a categoria computadores e informatica
    [Tags]              menus

    Dado que estou na home page da Amazon.com.br
    Quando acessar o menu "Eletrônicos"
    Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    a categoria "Computadores e Informática" deve ser exibida na página


 Caso de Teste 02 - Pesquisa de Produto
      [Documentation]     Esse teste verifica a busca de produto
      [Tags]              busca_produtos lista_busca

    Dado que estou na home page da Amazon.com.br
    Quando pesquisar pelo produto "Xbox Series S"
    Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    um produto da linha "Xbox Series S" deve ser mostrado na página
    