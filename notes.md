## 使用阿里云ACR存储镜像 Hxxxxx13
docker login --username=huangyi813@gmail.com registry.cn-shenzhen.aliyuncs.com

## 跨平台构建
在Docker中，使用docker build命令默认情况下只能构建单一平台的镜像。为了构建支持多个平台的镜像，需要使用docker buildx build命令，这是因为buildx是Docker的一个插件，它扩展了Docker命令行的功能，允许用户构建跨平台的镜像。

1. 安装Buildx docker 
   buildx install 
2. 启动Buildx实例：在构建之前，需要启动一个Buildx实例。可以使用以下命令启动一个新的Buildx实例：   
    docker buildx create --name mybuilder --driver docker-container --use
3. 指定平台：使用--platform标志来指定要构建的目标平台。    
    docker buildx build --platform linux/amd64,linux/arm64/v8 -t easyai/ragrag:v0.3.0  .

## 构建基础镜像
    
    docker buildx build --platform linux/amd64 -f ./Dockerfile.scratch   --load  -t registry.cn-shenzhen.aliyuncs.com/easyai/ragrag-base:v1.1  . 
    
    docker push registry.cn-shenzhen.aliyuncs.com/easyai/ragrag-base:v1.1

## 构建应用镜像   
   docker buildx build -t easyai/rag:v0.3.0 . --load
   docker tag   easyai/rag:v0.3.0  registry.cn-shenzhen.aliyuncs.com/easyai/ragrag:v0.3.0
   docker push registry.cn-shenzhen.aliyuncs.com/easyai/ragrag:v0.3.0

## 启动服务
   cd docker
   chmod +x ./entrypoint.sh    
   docker compose -f./docker-compose-CN.yml up -d