
IMAGE_NAME = quay.io/aicoe/tensorflow-serving-s2i:2017
DEFAULT_TF_SERVING_PACKAGE=https://github.com/sub-mod/mnist-app/releases/download/2017_tensorflow_model_server/tensorflow_model_server
.PHONY: build
build:
	docker build --build-arg TF_SERVING_PACKAGE=$(DEFAULT_TF_SERVING_PACKAGE)  --build-arg TF_SERVING_PORT=8500 -t $(IMAGE_NAME) .

.PHONY: test
test:
	docker build -t $(IMAGE_NAME)-candidate .
	IMAGE_NAME=$(IMAGE_NAME)-candidate test/run
