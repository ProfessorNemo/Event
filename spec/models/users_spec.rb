# frozen_string_literal: true

RSpec.describe User do
  describe '#find_for_oauth' do
    # Создаём объект :access_token
    # В него записываем те данные, которые мы доставали из хэша
    let(:access_token) do
      double(
        :access_token,
        provider: 'vkontakte',
        info: double(email: 'nemo@mail.ru', first_name: 'nemo',
                     image: 'https://avatarko.ru/img/kartinka/11/cherep_ogon_10735.jpg'),
        extra: double(raw_info: double(photo: 'https://avatarko.ru/img/kartinka/11/cherep_ogon_10735.jpg')),
        uid: '1'
      )
    end

    let(:provider) { :vkontakte }

    # Ситуация: пользователь не найден в БД
    context 'when user is not found' do
      it 'returns newly created user' do
        user = User.find_for_oauth(provider, access_token)

        expect(user).to be_persisted
        expect(user.email).to eq 'nemo@mail.ru'
      end
    end

    # Ситуация: юзер найден по почте в БД
    context 'when user is found by email' do
      let!(:existing_user) { create(:user, email: 'nemo@mail.ru') }

      it 'returns this user' do
        expect(User.find_for_oauth(provider, access_token)).to eq existing_user
      end
    end
  end
end
