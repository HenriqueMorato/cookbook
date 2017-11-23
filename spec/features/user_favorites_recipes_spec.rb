require 'rails_helper'

feature 'User favorites recipes' do
  scenario 'successfully' do
    user = create(:user)
    recipe = create(:recipe, title: 'Feijoada')
    other_recipe = create(:recipe)

    login_as(user, scope: :user)
    visit root_path
    click_on recipe.title
    click_on 'Favoritar'

    expect(page).to have_content('Receita colocada com sucesso nos favoritos')
  end
  scenario 'and view his favorite recipes' do
    user = create(:user)
    recipe = create(:recipe)

    login_as(user, scope: :user)
    visit root_path
    click_on recipe.title
    click_on 'Favoritar'
    click_on 'Meus Favoritos'

    expect(page).to have_content('Minhas receitas favoritas')
    expect(page).to have_content(recipe.title)
    expect(page).not_to have_content(other_recipe.title)
  end
end