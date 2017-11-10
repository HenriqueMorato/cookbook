require 'rails_helper'

feature 'User register recipe_jype' do
  scenario 'successfully' do

    visit new_recipe_type_path
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Sobremesa')
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de receitas')
  end

  scenario 'and must fill in name' do
    visit new_recipe_type_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o Nome da(o) Tipo de Receita')
  end

  scenario 'and is unique' do
    create(:recipe_type, name: 'Prato Principal')
    visit new_recipe_type_path
    fill_in 'Nome', with: 'Prato Principal'
    click_on 'Enviar'
    
    expect(page).to have_content('já existe um(a) Tipo de Receita com este nome')    
  end
end
