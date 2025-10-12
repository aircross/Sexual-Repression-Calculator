# --- 第一阶段: 构建前端静态资源 ---
# 使用官方 Node.js 镜像，版本为 22-alpine，包含 npm

# 使用轻量的 Node.js Alpine 镜像作为基础
FROM node:22-alpine AS builder

# 设置工作目录
WORKDIR /app

# 复制项目所有文件
COPY . .

RUN echo '======================================================='
RUN ls
RUN echo '======================================================='

# 安装依赖
RUN npm install
# 启动开发服务器
# RUN npm run dev

# 执行生产构建
RUN npm run build
FROM denoland/deno:alpine AS runner

WORKDIR /app

COPY --from=builder /app/dist .

EXPOSE 8000

CMD ["run", "--allow-net", "--allow-read", "server.cjs"]

# 如果你的项目需要更多的配置（例如环境变量），可以在此添加。
