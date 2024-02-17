git init
git add -A
git commit -m 'deploy:'$(date "+%Y%m%d-%H:%M:%S")
git remote add origin_gitee git@gitee.com:o19859860010/csu_stte_files.git
git push origin_gitee main

exec /bin/bash

