# FROM swr.cn-north-4.myhuaweicloud.com/infiniflow/ragflow-base:v1.0
FROM --platform=arm64 registry.cn-shenzhen.aliyuncs.com/easyai/ragrag-base:v1.1
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

ENTRYPOINT ["./entrypoint.sh"]