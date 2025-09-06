*** Settings ***
Library    SeleniumLibrary
Library    XML

*** Variables ***
${URL}                   https://www.amazon.com.br
${CAMPO_PESQUISA}        id=twotabsearchtextbox
${BOTAO_PESQUISA}        id=nav-search-submit-button

*** Keywords ***
# --- Keywords de SETUP e TEARDOWN ---

Abrir o navegador na home da Amazon
    Open Browser    ${URL}    chrome
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    Close Browser

# --- Keywords GHERKIN ---

Dado que estou na home page da Amazon.com.br
    Go To    ${URL}
    Wait Until Page Contains Element    ${CAMPO_PESQUISA}    timeout=5s

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