# frozen_string_literal: true

RSpec.describe 'User creates an event' do
  let!(:user) { create(:user) }
  let(:event) { build(:event, user_id: user.id) }

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

    click_link 'Создать событие'

    expect(page).to have_content 'Создать событие'
    within('#new_event') do
      fill_in 'Название', with: event.title
      fill_in 'Место проведения', with: event.address
      fill_in 'Описание:', with: event.description
      # fill_in 'Дата и время:', with: event.datetime
      check('event_notifications')
      fill_in 'Пин-код', with: event.pincode
    end
    click_button 'Сохранить'

    expect(page).to have_content 'Вы создали новое мероприятие'

    click_link 'Изменить'
    within('.edit_event') do
      attach_file('event_snapshot', Rails.root.join('spec', 'support', 'avatar.jpeg'))
    end

    click_button 'Сохранить'
    expect(page).to have_content 'Вы обновили мероприятие'
    expect(page.has_css?('.img-thumbnail')).to eq(true)
  end
end

