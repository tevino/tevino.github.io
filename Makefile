all: release

.PHONY: remote-github
remote-github:
	@echo "======== Adding github remote if not exist ========"
	git remote | grep github || git remote add github git@github.com:tevino/tevino.github.io.git

.PHONY: release
release: remote-github
	@echo "======== Checking if working directory is clean ========"
	test -z "$$(git status --porcelain)"

	@echo "======== Switching to master branch ========"
	git checkout master

	@echo "======== Checking if working directory is clean ========"
	test -z "$$(git status --porcelain)"

	@echo "======== Creating orphan branch __release ========"
	git checkout --orphan __release
	git commit -m "Release"

	@echo "======== Pushing __release to github master ========"
	git push -f github __release:master || echo "======== ^^^ Caution, push may failed ^^^ ========"

	@echo "======== Removing __release branch ========"
	git checkout master
	git branch -D __release

	@echo "======== Done ========"

