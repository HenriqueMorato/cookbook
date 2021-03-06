require 'rails_helper'

feature 'Visitor register recipe' do
  scenario 'successfully' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    create(:cuisine, name: 'Arabe')
    create(:recipe_type, name: 'Entrada')
    create(:recipe_type, name: 'Prato Principal')
    create(:recipe_type, name: 'Sobremesa')
    create(:user, email: 'test@cookbook.com')

    visit root_path
    within 'nav' do
      click_on 'Entrar'
    end
    fill_in 'Email', with: 'test@cookbook.com'
    fill_in 'Senha', with: '123456'
    within 'div.form-actions' do
      click_on 'Entrar' 
    end   
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'


    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: "45 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Misturar tudo e servir. Adicione limão a gosto.')
  end

  scenario 'and must fill in all fields' do
    create(:user, email: 'test@cookbook.com')
    
    visit root_path
    within 'nav' do
      click_on 'Entrar'
    end
    fill_in 'Email', with: 'test@cookbook.com'
    fill_in 'Senha', with: '123456'
    within 'div.form-actions' do
      click_on 'Entrar' 
    end
    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'


    expect(page).to have_content('Você deve informar todos os dados da receita')
  end
end
