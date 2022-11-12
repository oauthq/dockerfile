#!/bin/bash
# lnmp下安装php的wxwork_finance_sdk扩展
# date:2021/08/28

# php的安装目录
INSATLL_PATH_PATH="/etc/php7"
WXWORK_FINANCE_PATH="/home/php7-wxwork-finance-sdk"
# php扩展的c语言sdk目录
WXWORK_FINANCE_C_SDK_PATH="${WXWORK_FINANCE_PATH}/c_sdk"
# 进入workwx的扩展的目录
cd $WXWORK_FINANCE_PATH
# 通过phpize可以建立php的外挂模块
phpize
# 配置编译环境
./configure  --with-php-config=php-config --with-wxwork-finance-sdk="${WXWORK_FINANCE_C_SDK_PATH}"
# 编译和安装
make && make install
