# frozen_string_literal: true

RSpec.describe 'User registers spec' do
  it 'User registers in the application for the first time' do
    visit '/ru'

    click_link 'Зарегистрироваться'
    expect(page).to have_current_path('/ru/users/sign_up')
    expect(page).not_to have_content('Сменить имя и пароль')

    within('#new_user') do
      fill_in 'Email', with: FFaker::Internet.email
      fill_in 'Имя', with: FFaker::CheesyLingo.word
      fill_in 'Пароль', with: 'Password3456!'
      fill_in 'Подтверждение пароля:', with: 'Password3456!'
    end
    click_button 'Зарегистрироваться'

    expect(page).to have_content 'Добро пожаловать! Вы успешно зарегистрировались.'
  end

  it 'User specified an incorrect password' do
    visit '/ru'

    click_link 'Зарегистрироваться'
    expect(page).to have_current_path('/ru/users/sign_up')

    within('#new_user') do
      fill_in 'Email', with: FFaker::Internet.email
      fill_in 'Имя', with: FFaker::CheesyLingo.word
      fill_in 'Пароль', with: '3456'
      fill_in 'Подтверждение пароля:', with: '3456'
    end
    click_button 'Зарегистрироваться'

    expect(page).to have_content 'Пароль: недостаточной длины (не может быть меньше 8 символов)'
    expect(page).to have_content 'Пароль: недостаточно сложный. Длина должна быть от 8 до 70 символов'
  end
end
