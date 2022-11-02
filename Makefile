RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

db!:
	rails db:drop	db:create	db:migrate	db:fixtures:load
migration:
	bundle exec rails g migration $(RUN_ARGS)

model:
	bundle exec rails g model $(RUN_ARGS)

create:
	bundle exec rails db:create

migrate:
	bundle exec rails db:migrate

rubocop:
	rubocop -A

web:
	ruby bin/rails server -p 3000

run-console:
	bundle exec rails console

c: run-console

.PHONY:	db	test
