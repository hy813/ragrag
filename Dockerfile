# FROM swr.cn-north-4.myhuaweicloud.com/infiniflow/ragflow-base:v1.0
FROM --platform=arm64 registry.cn-shenzhen.aliyuncs.com/easyai/ragrag-base:v1.2
USER  root

WORKDIR /ragflow

ADD ./web ./web
RUN cd ./web && npm i && npm run build

ADD ./api ./api
ADD ./conf ./conf
ADD ./deepdoc ./deepdoc
ADD ./rag ./rag

ENV PYTHONPATH=/ragflow/
ENV HF_ENDPOINT=https://hf-mirror.com

ADD docker/entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

# HY:提前下载好模型
RUN huggingface-cli download --resume-download  --local-dir-use-symlinks False --local-dir ./rag/res/deepdoc  InfiniFlow/text_concat_xgb_v1.0
RUN huggingface-cli download --resume-download  --local-dir-use-symlinks False --local-dir ./rag/res/bge-large-zh-v1.5  BAAI/bge-large-zh-v1.5 

COPY ./rag/res/huqie.txt.trie ./rag/res

ENTRYPOINT ["./entrypoint.sh"]