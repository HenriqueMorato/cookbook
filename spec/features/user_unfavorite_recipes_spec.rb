require 'rails_helper'

feature 'User unfavorites recipes' do
  scenario 'successfully' do
    user = create(:user)
    favorited_recipe = create(:favorite_recipe, user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on favorited_recipe.recipe.title
    click_on 'unfavorite'

    expect(page).to have_content('Receita removida com sucesso dos favoritos')
    expect(page).to have_link('favorite')
    expect(page).not_to have_link('unfavorite')    
  end
  scenario 'and is not logged in' do
    recipe = create(:recipe)
    
    visit recipe_path recipe
    
    expect(page).not_to have_link('#unfavorite')     
  end
  scenario 'and cant see favorite button' do
    user = create(:user)
    favorited_recipe = create(:favorite_recipe, user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on favorited_recipe.recipe.title

    expect(page).to have_link('unfavorite')    
    expect(page).not_to have_link('favorite')
  end
end