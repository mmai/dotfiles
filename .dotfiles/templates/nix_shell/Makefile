init:
	cat .env.nixenv | sed s/dbuser:/$$(whoami):/ > .env.local
dev: checknix
	nix develop
checknix:
	bash ./nixfiles/checknix.sh
