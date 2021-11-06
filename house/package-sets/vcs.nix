{ pkgs }:

with pkgs; [
  gitAndTools.gitFull
  git-filter-repo
  # Because sometimes we need to retrieve oldschool systems!
  cvs
  subversion
  cvs2svn
]
