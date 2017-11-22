require 'rails_helper'

feature 'Visitor search recipes' do
  scenario 'sucessfully' do
    recipe = create(:recipe, title: 'Bolo de Fubá')
    create(:recipe, title: 'Feijoada')    

    visit root_path
    fill_in 'search_recipes', with: 'Bolo de Fubá'
    click_on 'Buscar'

    expect(page).to have_content('Bolo de Fubá')
    expect(page).not_to have_content('Feijoada')
  end
  scenario 'and finds nothing' do
    visit root_path
    fill_in 'search_recipes', with: 'Bolo de Fubá'
    click_on 'Buscar'

    expect(page).to have_content('Nenhuma receita encontrada')
  end
  scenario 'and find multiple results' do
    create(:recipe, title: 'Bolo de Fubá')
    create(:recipe, title: 'Bolo de Cenoura')
    create(:recipe, title: 'Bolo Formigueiro')
    
    visit root_path
    fill_in 'search_recipes', with: 'bolo'
    click_on 'Buscar'

    expect(page).to have_content('Bolo de Fubá')
    expect(page).to have_content('Bolo de Cenoura')
    expect(page).to have_content('Bolo Formigueiro')
  end
end