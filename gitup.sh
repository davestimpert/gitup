#!/usr/bin/env bash

gitups(){	
	RED='\033[33;31m'
	YELLO='\033[33;33m'
	GREEN='\033[33;32m'
	NC='\033[0m' # No Color

	HEAD=$(git rev-parse HEAD)
	CHANGED=$(git status --porcelain | wc -l)

	echo "Fetching..."
	git fetch --all --prune &>/dev/null
	for branch in `git for-each-ref --format='%(refname:short)' refs/heads`; do

		LOCAL=$(git rev-parse --quiet --verify $branch)
		if [ "$HEAD" = "$LOCAL" ] && [ $CHANGED -gt 0 ]; then
			echo -e "${YELLO}WORKING${NC}\t\t$branch"
		elif git rev-parse --verify --quiet $branch@{u}&>/dev/null; then
			REMOTE=$(git rev-parse --quiet --verify $branch@{u})
			BASE=$(git merge-base $branch $branch@{u})
			
			if [ "$LOCAL" = "$REMOTE" ]; then
			   echo -e "${GREEN}OK${NC}\t\t$branch" 
			elif [ "$LOCAL" = "$BASE" ]; then
				if [ "$HEAD" = "$LOCAL" ]; then
					git merge $REMOTE&>/dev/null
				else
					git branch -f $branch $REMOTE
				fi
				echo -e "${GREEN}UPDATED${NC}\t\t$branch"
			elif [ "$REMOTE" = "$BASE" ]; then
				echo -e "${RED}AHEAD${NC}\t\t$branch"
			else
				echo -e "${RED}DIVERGED${NC}\t\t$branch"
			fi
		else
			echo -e "${RED}NO REMOTE${NC}\t$branch"
		fi
	done
}
