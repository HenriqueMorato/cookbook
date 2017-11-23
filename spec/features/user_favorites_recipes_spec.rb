require 'rails_helper'

feature 'User favorites recipes' do
  scenario 'successfully' do
    user = create(:user)
    recipe = create(:recipe, title: 'Feijoada')
    other_recipe = create(:recipe)

    login_as(user, scope: :user)
    visit root_path
    click_on recipe.title
    click_on 'favorite'

    expect(page).to have_content('Receita colocada com sucesso nos favoritos')
  end
  scenario 'and view his favorite recipes' do
    user = create(:user)
    recipe = create(:recipe, title: 'Sanduiche de Banana')
    other_recipe = create(:recipe, title: 'Feijoada')    

    login_as(user, scope: :user)
    visit root_path
    click_on recipe.title
    click_on 'favorite'
    click_on 'Minhas Receitas Favoritas'

    expect(page).to have_content('Minhas receitas favoritas')
    expect(page).to have_content(recipe.title)
    expect(page).not_to have_content(other_recipe.title)
  end
  scenario 'and is not logged in' do
    recipe = create(:recipe)

    visit recipe_path recipe

    expect(page).not_to have_link('#favorite')
  end
  scenario 'and is redirect to root if not logged in' do
    recipe = create(:recipe)

    visit favorite_recipes_path

    expect(page).to have_content('Para continuar, efetue '\
                                 'login ou registre-se.')
    expect(current_path).to eq user_session_path
  end
  scenario 'and has a lot of favorites' do
    user = create(:user)
    recipes = []
    10.times do
      recipes << create(:recipe)
    end

    login_as(user, scope: :user)
    recipes.each do |recipe|
      visit recipe_path recipe
      click_on 'favorite'
    end
    visit favorite_recipes_path

    10.times do |index|
      expect(page).to have_content(recipes[index].title)
    end
  end
  scenario 'and cant see unfavorite button' do
    user = create(:user)
    recipe = create(:recipe)

    login_as(user, scope: :user)
    visit recipe_path recipe

    expect(page).to have_link('favorite')
    expect(page).not_to have_link('#unfavorite')
  end
end