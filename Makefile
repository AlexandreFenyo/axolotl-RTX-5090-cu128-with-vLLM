
# this file created by Alexandre Fenyo (https://fenyo.net) for axolotl to run on NVIDIA GeForce RTX 5090 with vllm
# successfully tested on :
# - Windows 11 24H2 + NVIDIA GeFore RTX 5090
#   driver 32.0.15.7700 2025/07/14
#   DirectX 12 (FL 12.1)
# - AMD Ryzen Threadripper 7980X 64-Cores

all: base axolotl axolotlcloud axolotlcloudnotmux

base: docker/Dockerfile-base
	docker build -f docker/Dockerfile-base -t axolotl-base:main-base-py3.11-cu128-2.7.1 .

axolotl: docker/Dockerfile
	docker build -f docker/Dockerfile -t axolotl:main-base-py3.11-cu128-2.7.1 .

axolotlcloud: docker/Dockerfile-cloud
	docker build -f docker/Dockerfile -t axolotl-cloud:main-base-py3.11-cu128-2.7.1 .

axolotlcloudnotmux: docker/Dockerfile-cloud-no-tmux
	docker build -f docker/Dockerfile -t axolotl-cloud-no-tmux:main-base-py3.11-cu128-2.7.1 .

push:
	docker tag axolotl-base:main-base-py3.11-cu128-2.7.1 fenyoa/axolotl-base:main-base-py3.11-cu128-2.7.1
	docker tag axolotl:main-base-py3.11-cu128-2.7.1 fenyoa/axolotl:main-base-py3.11-cu128-2.7.1
	docker tag axolotl-cloud:main-base-py3.11-cu128-2.7.1 fenyoa/axolotl-cloud:main-base-py3.11-cu128-2.7.1
	docker tag axolotl-cloud-no-tmux:main-base-py3.11-cu128-2.7.1 fenyoa/axolotl-cloud-no-tmux:main-base-py3.11-cu128-2.7.1
	docker push fenyoa/axolotl-base:main-base-py3.11-cu128-2.7.1
	docker push fenyoa/axolotl:main-base-py3.11-cu128-2.7.1
	docker push fenyoa/axolotl-cloud:main-base-py3.11-cu128-2.7.1
	docker push fenyoa/axolotl-cloud-no-tmux:main-base-py3.11-cu128-2.7.1
