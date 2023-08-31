# 使用官方 Node.js 執行環境作為基底映像檔
FROM node:18-alpine

# 設定工作目錄
WORKDIR /usr/src/app


# 將 package.json 和 yarn.lock 複製到工作目錄
COPY package.json yarn.lock ./

# 使用 Yarn 安裝應用程式所需的依賴套件
RUN yarn install && \ 
    apk add --no-cache tini


# 複製應用程式的源碼到工作目錄
COPY . .

# 宣告應用程式使用的通訊埠
EXPOSE 8081

ENTRYPOINT [ "/sbin/tini", "--" ]
# 啟動應用程式
CMD [ "node", "server.js" ]
