require 'rails_helper'

feature 'User edit recipe' do
  scenario 'successfully' do
    user = create(:user)
    cuisine = create(:cuisine, name: 'Americana')
    recipe_type = create(:recipe_type, name: 'Prato Principal')    
    recipe = create(:recipe, title: 'Empadão Goiano', 
                    cuisine: cuisine, recipe_type: recipe_type, user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on recipe.title
    click_on 'Editar esta receita'
    
    fill_in 'Título', with: 'Tabule'
    select 'Americana', from: 'Cozinha'
    select 'Prato Principal', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Americana')
    expect(page).to have_css('p', text: 'Prato Principal')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: "45 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Misturar tudo e servir. Adicione limão a gosto.')
  end
  scenario 'and must fill in all fields' do
    user = create(:user)
    recipe = create(:recipe, title: 'Empadão Goiano', user: user)  

    login_as(user, scope: :user)  
    visit edit_recipe_path recipe

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'


    expect(page).to have_content('Você deve informar todos os dados da receita')
  end
  scenario 'and is not his recipe' do
    user = create(:user)
    recipe = create(:recipe)
    login_as(user, scope: :user)  
    visit edit_recipe_path recipe

    expect(current_path).to eq root_path
  end
end