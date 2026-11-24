.PHONY: build up down logs health backup clean
build:
	docker compose build
up:
	docker compose up -d --build
down:
	docker compose down
logs:
	docker compose logs -f
health:
	./scripts/health_check.sh
backup:
	./scripts/backup.sh ./data ./backups 5
clean:
	rm -f logs/*.log backups/*.tar.gz
