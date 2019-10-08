# 脚本压缩部分内容到归档; 脚本自动创建一个Hexo的网站文件夹; 脚本解压归档(以合并内容);
# shell中, 字符串相等应当怎么写, 这个尚未仔细研究.
# 如果shell语句有语法报错, 某个语句执行失败了的话, 这个还没有检查.
# 搜索"shell 语法错误 立即退出", 可以看到 set -e set -u 之类的解决方式, 尚未验证.

# 使用方式: 当前目录下, 直接运行.

HEXO_REL="hexo_section"

echo "====== guess BASE_DIR and HEXO_ABS and ARCHIVED ======"
BASE_DIR="$(pwd)"
HEXO_ABS="${BASE_DIR}/${HEXO_REL}"
ARCHIVED="${HEXO_ABS}.tar.bz2"
echo "HEXO_REL=${HEXO_REL}"
echo "BASE_DIR=${BASE_DIR}"
echo "HEXO_ABS=${HEXO_ABS}"
echo "ARCHIVED=${ARCHIVED}"

echo "====== tar -cjf A.tar.bz2 A                     ======"
# 将文件夹打到压缩包里, 用于后续的合并.
tar -cjf "${ARCHIVED}" "${HEXO_REL}" --remove-files
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi

echo "====== create HEXO_ABS                          ======"
if [ ! -d ${HEXO_ABS} ]; then
    mkdir ${HEXO_ABS}
    if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi
else
    echo "ERROR: HEXO_ABS exists"
    exit 2
fi

echo "====== change to HEXO_ABS                       ======"
cd ${HEXO_ABS}
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi
pwd
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi

echo "====== hexo init                                ======"
hexo init
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi

echo "====== npm install                              ======"
npm install
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi

echo "====== hexo-deployer-git                        ======"
npm install hexo-deployer-git --save
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi

echo "====== hexo-blog-encrypt                        ======"
npm install hexo-blog-encrypt --save
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi

echo "====== change to BASE_DIR                       ======"
cd ${BASE_DIR}
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi
pwd
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi

echo "====== tar -xf A.tar.bz2 -C ./.                 ======"
# 压缩包里面有一个文件夹, 指定路径下面有一个同名文件夹, 将压缩包解压到指定路径, 用以合并文件夹.
tar -xf "${ARCHIVED}" -C "${BASE_DIR}"
if [ $? -ne 0 ]; then echo "[ERROR]:${LINENO}"; exit 1; fi

echo "=========================================="
echo "ALL DONE. SUCCESS."
echo "=========================================="
exit 0
