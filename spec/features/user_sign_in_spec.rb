# frozen_string_literal: true

RSpec.describe 'User sign in' do
  let(:user) { create(:user) }

  before do
    user.save
  end

  after do
    user.destroy
  end

  it 'Registered user is trying to login' do
    visit '/ru'

    click_link 'Войти'
    expect(page).to have_current_path('/ru/users/sign_in')

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Пароль', with: user.password
    end
    click_button 'Войти'

    expect(page).to have_content 'Вход в систему выполнен.'
  end

  it 'User wants to end the session' do
    visit '/ru'

    click_link 'Войти'
    expect(page).to have_current_path('/ru/users/sign_in')

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Пароль', with: user.password
    end
    click_button 'Войти'

    expect(page).to have_content 'Вход в систему выполнен.'

    visit "/ru/users/#{user.id}"

    expect(page).to have_content user.name

    click_link 'Выйти'
    expect(page).to have_current_path('/ru')

    expect(page).to have_content 'Выход из системы выполнен.'
  end

  it 'User enters incorrect data' do
    visit '/ru'

    click_link 'Войти'
    expect(page).to have_current_path('/ru/users/sign_in')

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Пароль', with: '123'
    end
    click_button 'Войти'

    expect(page).to have_content 'Неправильный Email: или пароль.'
  end
end
