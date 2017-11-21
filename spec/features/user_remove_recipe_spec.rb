require 'rails_helper'

feature 'User remove recipe' do
  scenario 'sucessfully' do
    user = create(:user, email: 'test@cookbook.com')
    recipe = create(:recipe, user: user, title: 'Bolo de fubá')

    visit root_path
    within 'nav' do
      click_on 'Entrar'
    end
    fill_in 'Email', with: 'test@cookbook.com'
    fill_in 'Senha', with: '123456'
    within 'div.form-actions' do
      click_on 'Entrar' 
    end
    click_on recipe.title
    click_on 'Apagar Receita'

    expect(current_path).to eq root_path
    expect(page).to have_content('Receita apagada com sucesso.')    
  end
end