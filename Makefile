CHECK_LOG_DIR ?= .agent/check-logs

.PHONY: bdd spec-coverage spec-validate

bdd:
	@mkdir -p "$(CHECK_LOG_DIR)"; start=$$(date +%s); log="$(CHECK_LOG_DIR)/bdd.log"; set +e; pytest -p no:randomly -c bdd/pytest.ini bdd >"$$log" 2>&1; rc=$$?; duration=$$(($$(date +%s)-start)); printf 'target=bdd exit_code=%s duration_s=%s log=%s\\n' "$$rc" "$$duration" "$$log" | tee "$(CHECK_LOG_DIR)/bdd.receipt"; cat "$$log"; exit "$$rc"

spec-coverage:
	@mkdir -p "$(CHECK_LOG_DIR)"; start=$$(date +%s); log="$(CHECK_LOG_DIR)/spec-coverage.log"; set +e; agent-ops spec-coverage . >"$$log" 2>&1; rc=$$?; duration=$$(($$(date +%s)-start)); printf 'target=spec-coverage exit_code=%s duration_s=%s log=%s\\n' "$$rc" "$$duration" "$$log" | tee "$(CHECK_LOG_DIR)/spec-coverage.receipt"; cat "$$log"; exit "$$rc"

spec-validate:
	@mkdir -p "$(CHECK_LOG_DIR)"; start=$$(date +%s); log="$(CHECK_LOG_DIR)/spec-validate.log"; set +e; openspec validate --all --strict >"$$log" 2>&1; rc=$$?; duration=$$(($$(date +%s)-start)); printf 'target=spec-validate exit_code=%s duration_s=%s log=%s\\n' "$$rc" "$$duration" "$$log" | tee "$(CHECK_LOG_DIR)/spec-validate.receipt"; cat "$$log"; exit "$$rc"

# raider-host: docker + comfiui portable
COMPOSE = docker-compose -f docker-compose.yml

up:
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down -v

logs:
	$(COMPOSE) logs -f magostudio comfiui

comfiui:
	$(COMPOSE) up -d comfiui

status:
	$(COMPOSE) ps
