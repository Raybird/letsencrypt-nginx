
.PHONY: help nginx-t

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


nginx-t: ## nginx -t
	docker-compose exec nginx nginx -t

# goaccess: ## goaccess
# 	cat nginx/log/access.log | docker run -v $PWD/goaccess/goaccess.conf:/goaccess/goaccess.conf --rm -i -e LANG=$LANG allinurl/goaccess --no-global-config --config-file=/goaccess/goaccess.conf -a -o html --log-format COMBINED - > report.html
# 	xdg-open report.html



.DEFAULT_GOAL := help