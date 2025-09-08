<<<<<<< HEAD
*** Settings ***
Library    SeleniumLibrary
Library    XML

*** Variables ***
${URL}                        https://www.amazon.com.br
${CAMPO_PESQUISA}             id=twotabsearchtextbox
${BOTAO_PESQUISA}             id=nav-search-submit-button
${BOTAO_POPUP_NAO_OBRIGADO}    //input[@aria-labelledby='attachSiNoCoverage-announce']

*** Keywords ***

Abrir o navegador na home da Amazon
    Open Browser    ${URL}    chrome
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    Close Browser

# --- Keywords GHERKIN ---

Dado que estou na home page da Amazon.com.br
    Go To    ${URL}
    Wait Until Page Contains Element    ${CAMPO_PESQUISA}    timeout=10s

Quando acessar o menu "${nome_do_menu}"
    ${locator_menu}    Set Variable    //a[normalize-space()='${nome_do_menu}']
    Wait Until Element Is Visible    ${locator_menu}
    Click Element                    ${locator_menu}

Quando pesquisar pelo produto "${produto}"
    Wait Until Element Is Visible    ${CAMPO_PESQUISA}
    Input Text                       ${CAMPO_PESQUISA}    ${produto}
    Click Button                     ${BOTAO_PESQUISA}

Então o título da página deve ficar "${titulo_esperado}"
    Title Should Be    ${titulo_esperado}

o texto "${texto}" deve ser exibido na página
    Wait Until Page Contains    ${texto}

a categoria "${categoria}" deve ser exibida na página
    ${locator_categoria}    Set Variable    //span[contains(text(),'${categoria}')]
    Wait Until Page Contains Element    ${locator_categoria}

um produto da linha "${produto}" deve ser mostrado na página
    ${locator_resultado}    Set Variable    //div[@data-component-type='s-search-result']//span[contains(normalize-space(.),'${produto}')]
    Wait Until Page Contains Element    ${locator_resultado}


E Adicionar o produto "${produto}" no carrinho
    # CORREÇÃO: As linhas que definem e esperam o link do produto foram adicionadas aqui, ANTES do clique.
    ${locator_link_produto}    Set Variable    //div[@data-component-type='s-search-result']//span[contains(normalize-space(.),'${produto}')]
    Wait Until Element Is Visible    ${locator_link_produto}
    Click Element                    ${locator_link_produto}

    # Na página do produto, clica no botão "Adicionar ao carrinho"
    Wait Until Element Is Visible    id=add-to-cart-button    timeout=10s
    Click Element                    id=add-to-cart-button

    # DEBUG: Vamos tirar uma foto logo após clicar em adicionar
    Capture Page Screenshot    depois_de_clicar_em_adicionar.png

    # Lógica para lidar com o popup
    ${popup_apareceu}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${BOTAO_POPUP_NAO_OBRIGADO}    timeout=15s
    Run Keyword If    ${popup_apareceu}    Click Element    ${BOTAO_POPUP_NAO_OBRIGADO}
    # DEBUG: E outra foto depois de tratar o popup
    Run Keyword If    ${popup_apareceu}    Capture Page Screenshot    depois_de_fechar_popup.png

E Verificar se o produto "${produto}" foi adicionado com sucesso
    Wait Until Page Contains    Adicionado ao carrinho    timeout=15s
    Page Should Contain         ${produto}
       Capture Page Screenshot    pagina_de_confirmacao.png


E Remover o produto "${produto}" do carrinho
    # Primeiro, vamos para a página do carrinho (se já não estivermos nela)
    Execute Javascript    document.getElementById('nav-cart').click();

    # Na página do carrinho, localizamos o botão "Excluir" específico do produto
    ${locator_excluir}    Set Variable    //span[contains(@class, 'sc-product-title') and contains(normalize-space(.), '${produto}')]/ancestor::div[@data-asin]//input[@value='Excluir']
    Wait Until Element Is Visible    ${locator_excluir}
    Click Element                    ${locator_excluir}

    # PASSO 1: Verificamos a mensagem de confirmação imediata, como na sua primeira foto.
   ${locator_confirmacao}    Set Variable    //span[starts-with(@id, 'sc-list-item-removed-msg-text-delete-')]
    Wait Until Element Is Visible    ${locator_confirmacao}    timeout=15s


E Verificar se o carrinho fica vazio
    # PASSO 2: Clicamos no ícone do carrinho NOVAMENTE para ir para a tela final.
    Wait Until Element Is Visible    id=nav-cart    timeout=10s
    Execute Javascript    document.getElementById('nav-cart').click();

     # Usaremos o localizador que havíamos criado para essa tela específica.
      ${locator_carrinho_vazio}    Set Variable    //h3[normalize-space()='Seu carrinho da Amazon está vazio']
       Wait Until Element Is Visible    ${locator_carrinho_vazio}    timeout=10s