git lfs fetch --all
git lfs checkout
git lfs uninstall
git lfs migrate export --everything --include="*"
git add .gitattributes
git commit -m "Stop tracking LFS files"
git push origin --all --force
git push origin --tags --force
