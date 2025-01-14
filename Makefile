init:
	@bash docker/message.sh "Start"
	make start

setup: stop
	@bash docker/message.sh "Compiling everything"
	docker compose build
	docker compose run --rm api bash -c 'mix deps.get; npm ci; mix ecto.create; mix ecto.migrate; npm run build:pictures'
migrate:
	docker compose run --rm api mix ecto.migrate
logs:
	docker compose logs -f
start: stop
	@bash docker/message.sh "Starting Mobilizon with Docker"
	docker compose up -d api
	@bash docker/message.sh "Docker server started"
stop:
	@bash docker/message.sh "Stopping Mobilizon"
	docker compose down
	@bash docker/message.sh "Mobilizon is stopped"
test: stop
	@bash docker/message.sh "Running tests"
	docker compose -f docker compose.yml -f docker compose.test.yml run api mix prepare_test
	docker compose -f docker compose.yml -f docker compose.test.yml run api mix test $(only)
	@bash docker/message.sh "Done running tests"
format: 
	docker compose run --rm api bash -c "mix format && mix credo --strict"
	@bash docker/message.sh "Code is now ready to commit :)"
target: init
