git init
git add -A
git commit -m 'deploy'
git remote add origin_github git@github.com:dream-oyh/csu_stte_files.git
git push origin_github main
exec /bin/bash