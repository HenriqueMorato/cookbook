require 'rails_helper'

feature 'User remove recipe' do
  scenario 'sucessfully', driver: :selenium do
    user = create(:user, email: 'test@cookbook.com')
    recipe = create(:recipe, user: user)

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
    click_on 'Apagar receita'
  end
end