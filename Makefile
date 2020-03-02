
IMAGE_NAME = quay.io/aicoe/tensorflow-serving-s2i:2020
DEFAULT_TF_SERVING_PACKAGE=https://github.com/AICoE/tensorflow-wheels/releases/download/tensorflow_serving_api-r2.1-cpu-2020-02-18_155137/tensorflow_model_server
.PHONY: build
build:
	docker build --build-arg TF_SERVING_PACKAGE=$(DEFAULT_TF_SERVING_PACKAGE)  --build-arg TF_SERVING_PORT=8500 -t $(IMAGE_NAME) .

.PHONY: test
test:
	docker build -t $(IMAGE_NAME)-candidate .
	IMAGE_NAME=$(IMAGE_NAME)-candidate test/run
