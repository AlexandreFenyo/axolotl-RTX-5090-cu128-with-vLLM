
# this file updated by Alexandre Fenyo (https://fenyo.net) for axolotl to run on NVIDIA GeForce RTX 5090 with vllm

# ARG BASE_TAG=main-base
# FROM axolotlai/axolotl-base:$BASE_TAG
FROM axolotl-base:main-base-py3.11-cu128-2.7.1

# ARG TORCH_CUDA_ARCH_LIST="7.0 7.5 8.0 8.6+PTX"
ARG TORCH_CUDA_ARCH_LIST="7.0 7.5 8.0 8.6 9.0+PTX"
ARG AXOLOTL_EXTRAS=""
ARG AXOLOTL_ARGS=""
# ARG CUDA="118"
ARG CUDA="128"
# ARG PYTORCH_VERSION="2.1.2"
ARG PYTORCH_VERSION="2.7.1"

ARG AXOLOTL_EXTRAS=vllm
ARG AXOLOTL_ARGS=

ENV PYTORCH_VERSION=$PYTORCH_VERSION

# RUN apt-get update && \
#     apt-get install -y --allow-change-held-packages vim curl nano libnccl2 libnccl-dev rsync s3fs && \
#     rm -rf /var/cache/apt/archives && \
#     rm -rf /var/lib/apt/lists/*
RUN apt-get update && \
    apt-get install -y --allow-change-held-packages vim curl nano libnccl2 libnccl-dev rsync s3fs

WORKDIR /workspace

RUN git clone --depth=1 https://github.com/axolotl-ai-cloud/axolotl.git

WORKDIR /workspace/axolotl

# If AXOLOTL_EXTRAS is set, append it in brackets
RUN if [ "$AXOLOTL_EXTRAS" != "" ] ; then \
        pip install --no-build-isolation -e .[deepspeed,flash-attn,ring-flash-attn,optimizers,ray,$AXOLOTL_EXTRAS] $AXOLOTL_ARGS; \
    else \
        pip install --no-build-isolation -e .[deepspeed,flash-attn,ring-flash-attn,optimizers,ray] $AXOLOTL_ARGS; \
    fi && \
    python scripts/unsloth_install.py | sh && \
    python scripts/cutcrossentropy_install.py | sh && \
    pip install pytest && \
    pip cache purge

# fix so that git fetch/pull from remote works with shallow clone
RUN git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" && \
    git config --get remote.origin.fetch && \
    git config --global credential.helper store

COPY .axolotl-complete.bash /root/.axolotl-complete.bash
RUN chmod +x /root/.axolotl-complete.bash && \
    echo 'source /root/.axolotl-complete.bash' >> ~/.bashrc
