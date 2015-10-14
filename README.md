# gitup
Git tool to update all local branches to their remote tracking branches

What it does
---------
1. Fetch
2. Updates each of your branches to their remote tracking branch if they can be fast-forwarded
3. Only updates your current branch if you have a clean working directory
4. Does not touch any branches that are ahead or have diverged from their remote branch
5. Does all this without touching your working copy!  (i.e. NO checkouts, never switches your branch)

Usage
--------
This is a bash script.  When you are in a directory which is a git repo (has a .git dir) then just run gitup.sh

TODO
--------
Make this work in a function
