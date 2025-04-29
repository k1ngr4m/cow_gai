#!/bin/bash

# 获取脚本所在目录
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# 切换到脚本目录
cd "$SCRIPT_DIR"

# 结束占用80端口的进程
echo "正在结束占用80端口的进程..."
pid=$(sudo lsof -i :80 -t)
if [ -n "$pid" ]; then
    echo "找到进程PID: $pid，正在结束..."
    sudo kill -9 $pid
else
    echo "没有找到占用80端口的进程。"
fi

# 创建日志目录
mkdir -p logs

# 启动应用并记录日志
log_file="logs/$(date +'%Y%m%d')_logs.log"
echo "启动应用，日志输出到: $log_file"
sudo nohup python3 app.py > "$log_file" 2>&1 &

echo "应用已启动。"