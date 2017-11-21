require 'rails_helper'

feature 'User register cuisine' do
  scenario 'successfully' do
    user = create(:user, email: 'teste@teste.com',
                         role: 'admin')

    visit root_path
    within 'nav' do
      click_on 'Entrar'
    end
    fill_in 'Email', with: 'teste@teste.com'
    fill_in 'Senha', with: '123456'
    within 'div.form-actions' do
      click_on 'Entrar' 
    end
    click_on 'Criar uma Cozinha'
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Brasileira')
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de cozinha')
  end

  scenario 'and must fill in name' do
    user = create(:user, role: 'admin')
    login_as(user, scope: :user)

    visit new_cuisine_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o Nome da(o) Cozinha')
  end

  scenario 'and is unique' do
    user = create(:user, role: 'admin')
    login_as(user, scope: :user)
    create(:cuisine, name: 'Italiana')

    visit new_cuisine_path
    fill_in 'Nome', with: 'Italiana'
    click_on 'Enviar'
    
    expect(page).to have_content('já existe um(a) Cozinha com este nome')    
  end

  scenario 'and is not admin' do
    user = create(:user)
    login_as(user, scope: :user)

    visit new_cuisine_path
    
    expect(page).to have_content('Acesso Negado, você não possui permissão'\
                                 ' para executar esta ação')
    expect(current_path).to eq root_path
  end
end
