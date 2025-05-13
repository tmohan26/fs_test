.PHONY: dev stop logs db-shell build fmt up down

dev:
	docker compose -f compose/base.yml -f compose/dev.override.yml up --build

stop:
	docker compose -f compose/base.yml -f compose/dev.override.yml down -v

logs:
	docker compose -f compose/base.yml -f compose/dev.override.yml logs -f fastapi

db-shell:
	psql -h localhost -p 54322 -U postgres -d postgres || true

build:
	docker build -t fastapi:test docker/fastapi

fmt:
	echo "Add Ruff/Black to format code"

up:
	docker compose -f compose/base.yml up -d

down:
	docker compose -f compose/base.yml down -v
