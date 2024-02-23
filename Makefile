build:
	docker compose build

update:
	docker compose run --rm app poetry update

install:
	docker compose run --rm app poetry install --no-root

up:
	docker compose up

up-build:
	docker compose up --build

down:
	docker compose down

test:
	rm -f db.sqlite3
	docker compose run --rm app python manage.py migrate --settings=config.settings.test
	docker compose run --rm app coverage run --source='.' manage.py test --settings=config.settings.test
	docker compose run --rm app coverage report

lint:
	docker compose run --rm app flake8 tests
	docker compose run --rm app isort --profile black --check --diff tests api
	docker compose run --rm app black --check --diff tests api
	docker compose run --rm app mypy tests api

format:
	docker-compose run --rm app isort --profile black tests api
	docker-compose run --rm app black tests api

db-makemigrations:
	docker compose exec app python manage.py makemigrations

db-migrate:
	docker compose exec app python manage.py migrate

db-reset:
	docker compose exec app python manage.py reset_db

createsuperuser:
	docker compose exec app python manage.py createsuperuser --noinput

docker-generateschema:
	docker compose run --rm app python manage.py generateschema > src/docs/openapi-schema.yml

docker-graph-models:
	docker compose run --rm app python manage.py graph_models -a -o docs/erd.png

docker-show-urls:
	docker compose run --rm app python manage.py show_urls

docker-django-shell:
	docker compose exec app python manage.py shell_plus
