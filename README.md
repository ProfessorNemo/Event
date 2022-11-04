# Events

###### Ruby: `3.0.3` Rails: `6.1.6` Yarn: `3.2.4` Nodejs: `12.22.9` Node: `17.1.0` Language: `Russian/English`
###### Application screenshots are located in the "screenshots" directory
![Снимок экрана от 2022-11-04 23-18-04](https://user-images.githubusercontent.com/102049907/200075558-3879ba17-b481-4054-87dc-8f24a7252c97.png)
![Снимок экрана от 2022-11-04 23-16-56](https://user-images.githubusercontent.com/102049907/200075570-11d9dca1-43c9-4c67-8470-37fec868cedd.png)
![Снимок экрана от 2022-11-04 23-00-29](https://user-images.githubusercontent.com/102049907/200075573-80743a18-d97f-4fd4-9f12-ab823a5b8bc9.png)
![Снимок экрана от 2022-11-02 04-21-49](https://user-images.githubusercontent.com/102049907/200075582-d45691e3-319f-4b2c-8fb7-e05059d5c1b5.png)
![Снимок экрана от 2022-11-02 04-11-47](https://user-images.githubusercontent.com/102049907/200075589-b02f0129-9fef-4f47-8d3a-6fcbf3c00076.png)
![Снимок экрана от 2022-11-02 04-06-18](https://user-images.githubusercontent.com/102049907/200075593-e770ea5d-78bf-4230-99c8-0a97e9d7d13e.png)
![Снимок экрана от 2022-11-02 04-05-12](https://user-images.githubusercontent.com/102049907/200075596-027f53e6-d8b1-4d57-810d-808062ad740a.png)
![Снимок экрана от 2022-11-02 04-04-58](https://user-images.githubusercontent.com/102049907/200075598-dfac56b6-7f11-47a2-8605-50e2eebeb19e.png)
![Снимок экрана от 2022-11-02 04-04-14](https://user-images.githubusercontent.com/102049907/200075601-68787364-a57b-47bb-97c1-35aa6dfa2944.png)
![Снимок экрана от 2022-11-02 04-04-07](https://user-images.githubusercontent.com/102049907/200075608-3ccd4c77-6a61-44af-af09-5d6a239828fd.png)
![Снимок экрана от 2022-11-02 04-03-59](https://user-images.githubusercontent.com/102049907/200075614-1cfadb1c-9e19-4774-97e7-86e14fbe3c10.png)
![Снимок экрана от 2022-11-02 04-03-54](https://user-images.githubusercontent.com/102049907/200075617-6c6f571f-5f95-435d-a1b8-8f7cfe65a18e.png)
![Снимок экрана от 2022-11-02 04-03-42](https://user-images.githubusercontent.com/102049907/200075622-37b57e2f-d85b-485a-ab48-2fa143373591.png)
![Снимок экрана от 2022-11-02 04-03-32](https://user-images.githubusercontent.com/102049907/200075628-c0b84c8a-48f8-4697-abc2-264f62488f12.png)
![Снимок экрана от 2022-11-02 04-03-20](https://user-images.githubusercontent.com/102049907/200075649-f6e8916e-2f28-4908-b257-4ad391dafeb4.png)
![Снимок экрана от 2022-11-02 04-02-29](https://user-images.githubusercontent.com/102049907/200075661-117189e5-c0d7-4128-aa9e-70899acbf976.png)
![Снимок экрана от 2022-11-02 03-24-49](https://user-images.githubusercontent.com/102049907/200075667-281462e9-e6aa-4162-aa41-83a5948863a3.png)
![Снимок экрана от 2022-10-30 03-27-55](https://user-images.githubusercontent.com/102049907/200075668-f754b6f4-c551-4015-bd7b-076fa5727a3d.png)
![Снимок экрана от 2022-10-30 03-27-30](https://user-images.githubusercontent.com/102049907/200075672-278e615d-3e44-47c3-9bad-96328664e2b1.png)
![Снимок экрана от 2022-10-30 03-27-15](https://user-images.githubusercontent.com/102049907/200075679-1f0e8ccd-5167-42e7-8270-a032dcd471fe.png)
![Снимок экрана от 2022-10-30 02-31-20](https://user-images.githubusercontent.com/102049907/200075701-5bade681-755e-4618-a4a2-a1f5b6719e1a.png)
![Снимок экрана от 2022-10-30 02-30-42](https://user-images.githubusercontent.com/102049907/200075705-20ac3a48-1f5c-42b4-9cca-237979e86925.png)


An application where you can create events and meetings, subscribe to them, add photos, comments, mark a place on the map and receive email notifications.

Quick registration via: `Vkontakte`, `Google`, `Github`

The venue is displayed in Yandex.Maps.

`Esbuild` is used as stack for assets.

### Gems used:

- [`devise`](https://github.com/heartcombo/devise) to work with users
- [`rails-i18n`](https://github.com/svenfuchs/rails-i18n) to internationalization
- [`pundit`](https://github.com/varvet/pundit) to authentication
- [`carrierwave`](https://github.com/carrierwaveuploader/carrierwave) to upload images
- [`rmagick`](https://github.com/rmagick/rmagick) for image processing
- [`mailjet`](https://github.com/mailjet/mailjet-gem) for email notifications
- [`letter_opener`](https://github.com/ryanb/letter_opener) to send emails in the development.
- [`rspec-rails`](https://github.com/rspec/rspec-rails) for tests
- [`factory_bot_rails`](https://github.com/thoughtbot/factory_bot_rails)
- [`resque`](https://github.com/resque/resque) for background jobs
- [`resque-scheduler`](https://github.com/resque/resque-scheduler) this is an extension to Resque that adds support for queueing items in the future
- [`omniauth-rails_csrf_protection`](https://github.com/cookpad/omniauth-rails_csrf_protection) for OAuth authentication
  - [`omniauth-google-oauth2`](https://github.com/zquestz/omniauth-google-oauth2)
  - [`omniauth-github`](https://github.com/omniauth/omniauth-github)
  - [`omniauth-vkontakte`](https://github.com/mamantoha/omniauth-vkontakte)
- ...

### Installation

1. Clone repo
```
$ git clone https://github.com/ProfessorNemo/Event
$ cd bbq
```

2. Install gems
```
$ bundle update
```

3. Install and update all dependencies in "package.json" file
```
$ yarn install
```

4. Create database and run migrations
```
$ rails db:create db:migrate
```

5. Generate `master.key` and credentials file
```
$ EDITOR=nano rails credentials:edit
```

Example of `credentials.yml.enc` (**Optional for services working**)
```yml

```yml
action_mailer:
  mail_from: <value>
  user_name: <value>
  password: <value>
maps:
  api_key: <value>
mail:
  default_mail: <value>
  mailjet_api_key: <value>
  mailjet_secret_key: <value>
oauth:
  vkontakte_app_id: <value>
  vkontakte_secret_key: <value>
  github_client_id: <value>
  github_secret_key: <value>
  client_id: <value>
  client_secret: <value>
```

`:mail` — [`Mailjet`](https://www.mailjet.com/)

`:maps` — [`Yandex.Maps API`](https://yandex.ru/dev/maps)

`:oauth` — [`OAuth VK`](https://dev.vk.com/) [`OAuth Github`](https://developer.github.com/) [`OAuth Google`](https://developers.google.com/identity/protocols/oauth2)



6. Start sever:
```
$ bin/dev
```

We launch the web-server built into Resque, where you can monitor what tasks are being performed. In a separate console tab:

7. Start web-server Resque:
```
$ bundle exec resque-web
или - (http://localhost:3000/jobs)
```

Then, in the console, in a separate tab, we launch the queue (more precisely, the worker) with the QUEUE parameter. (event* - will process all queued tasks whose name starts with "event"):

8. Start a worker:
```
$ QUEUE=event* bundle exec rake environment resque:work
```

The scheduler's rake task is responsible for both queuing items from the schedule and polling the deferred queue for items that are ready to be placed on work queues. In a separate terminal tab, run the command:

9. Start a scheduler:
```
$ bundle exec rake resque:scheduler
```

10. In another tab, we will look at the logs:
```
$ tail -f log/development_resque.log
```

```
"ctrl-C" - turn off the worker
```
```
"$ bundle exec resque-web -K" - extinguish the Resque web server
```

### Сommands to run test:
```
$ bundle exec rspec spec/models/users_spec.rb
```

Open `localhost:3000` or `lvh.me:3000` in browser.
