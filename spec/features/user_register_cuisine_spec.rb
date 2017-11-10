require 'rails_helper'

feature 'User register cuisine' do
  scenario 'successfully' do

    visit new_cuisine_path
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Brasileira')
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de cozinha')
  end

  scenario 'and must fill in name' do
    visit new_cuisine_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o Nome da(o) Cozinha')
  end

  scenario 'and is unique' do
    create(:cuisine, name: 'Italiana')
    visit new_cuisine_path
    fill_in 'Nome', with: 'Italiana'
    click_on 'Enviar'
    
    expect(page).to have_content('já existe um(a) Cozinha com este nome')    
  end
end
