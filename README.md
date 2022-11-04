# Events

###### Ruby: `3.0.3` Rails: `6.1.6` Yarn: `3.2.4` Nodejs: `12.22.9` Node: `17.1.0` Language: `Russian/English`
###### Application screenshots are located in the "screenshots" directory
![Снимок экрана от 2022-11-02 04-04-07](https://user-images.githubusercontent.com/102049907/200068218-a5a4c234-88ca-455e-8ec2-382f72169a3e.png)

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
