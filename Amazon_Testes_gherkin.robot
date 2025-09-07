*** Settings ***
Documentation     Suite de testes do site da Amazon com Gherkin
Resource          amazon_gherkin_resources.robot  

Suite Setup        Abrir o navegador na home da Amazon
Suite Teardown     Fechar o navegador


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
      [Documentation]     Esse teste verifica a busca de produto a adição e remoção de um produto no carrinho de compras.
      [Tags]              busca_produtos lista_busca

    Dado que estou na home page da Amazon.com.br
    Quando pesquisar pelo produto "Xbox Series S"
    Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    um produto da linha "Xbox Series S" deve ser mostrado na página
    
Caso de Teste 03 - Remover Produto do Carrinho
    [Documentation]    Esse teste verifica a adição e remoção de um produto no carrinho de compras.
    [Tags]             carrinho

    E Adicionar o produto "Console Xbox Series S" no carrinho
    E Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso
    E Remover o produto "Console Xbox Series S" do carrinho
    E Verificar se o carrinho fica vazio