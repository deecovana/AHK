@echo Press Ctrl+C twice to stop!!!
pause OR this will delete ALL LFS files without rollback!!!
git lfs fetch --all
git lfs checkout
git lfs uninstall
git lfs migrate export --everything --include="*"
git add .gitattributes
git commit -m "Stop tracking LFS files"
git push origin --all --force
git push origin --tags --force
git lfs ls-files
git lfs prune
rd /s /q ".git/lfs"
