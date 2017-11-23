require 'rails_helper'

feature 'User attach photo to recipe' do
  scenario 'sucessfully' do
    create(:cuisine, name: 'Arabe')
    create(:recipe_type, name: 'Entrada')
    user = create(:user, email: 'test@cookbook.com')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Enviar uma receita'
    
    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    attach_file('Foto da Receita', Rails.root.join('spec', 'support', 'fixtures', 'Feijoada.jpg'))
    click_on 'Enviar'

    expect(page).to have_xpath("//img[contains(@src,'Feijoada.jpg')]")
  end
  scenario 'and doest uploud pictory' do
    create(:cuisine, name: 'Arabe')
    create(:recipe_type, name: 'Entrada')
    user = create(:user, email: 'test@cookbook.com')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Enviar uma receita'
    
    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'

    save_page
    expect(page).to have_xpath("//img[contains(@src,'missing_main.png')]")
  end
  scenario 'and is not an image' do
    create(:cuisine, name: 'Arabe')
    create(:recipe_type, name: 'Entrada')
    user = create(:user, email: 'test@cookbook.com')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Enviar uma receita'
    
    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    attach_file('Foto da Receita', Rails.root.join('spec', 'support', 'fixtures', 'Blank.doc'))
    click_on 'Enviar'

    expect(page).to have_content('Tipo da imagem não é válido')    
  end
end