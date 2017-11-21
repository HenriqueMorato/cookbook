require 'rails_helper'

feature 'User register recipe_type' do
  scenario 'successfully' do
    create(:user, email: 'teste@teste.com', role: 1)
    
    visit root_path
    within 'nav' do
      click_on 'Entrar'
    end
    fill_in 'Email', with: 'teste@teste.com'
    fill_in 'Senha', with: '123456'
    within 'div.form-actions' do
      click_on 'Entrar' 
    end
    click_on 'Criar um Tipo de Receita'
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Sobremesa')
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de receitas')
  end

  scenario 'and must fill in name' do
    user = create(:user, role: 1)
    login_as(user, scope: :user)
    visit new_recipe_type_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o Nome da(o) Tipo de Receita')
  end

  scenario 'and is unique' do
    user = create(:user, role: 1)
    login_as(user, scope: :user)
    create(:recipe_type, name: 'Prato Principal')
    visit new_recipe_type_path
    fill_in 'Nome', with: 'Prato Principal'
    click_on 'Enviar'
    
    expect(page).to have_content('já existe um(a) Tipo de Receita com este nome')    
  end

  scenario 'and is not admin' do
    user = create(:user)
    login_as(user, scope: :user)

    visit new_recipe_type_path
    
    expect(page).to have_content('Acesso Negado, você não possui permissão'\
                                 ' para executar esta ação')
    expect(current_path).to eq root_path
  end
end
