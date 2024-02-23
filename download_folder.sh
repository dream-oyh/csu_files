read -p "请输入你想下载的文件夹路径：" dir

git init
git config core.sparseCheckout true
echo "$dir" >> .git/info/sparse-checkout
git remote add origin git@gitee.com:o19859860010/csu_stte_files.git
git pull origin main

exec /bin/bash