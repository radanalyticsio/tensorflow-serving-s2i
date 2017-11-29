# Radanalytics Tensorflow Serving #

This is a builder image for a tensorflow serving applications. It is
meant to be used in an openshift project with tensorflow models.

The final image will have tensorflow model installed along with `tensorflow_model_server` binary, a startup script and associated
utilities to start tensorflow prediction endpoint at port `6006`.

## Integration With OpenShift

To make it easier to deploy a tensorflow serving endpoint a template for OpenShift is also included. This can be loaded into your project using:

```
oc create -f https://raw.githubusercontent.com/radanalyticsio/tensorflow-serving-s2i/master/template.json
```

Once loaded, select the ``tensorflow-server`` template from the web console.
The ``APPLICATION_NAME`` , ``SOURCE_REPOSITORY``  and ``SOURCE_DIRECTORY``must be specified.

OR

You can create from commandline.Just create a new application within OpenShift, pointing the S2I builder at the Git repository containing your tensorflow model files.

```
oc new-app --template=tensorflow-server \
    --param=APPLICATION_NAME=tf-reg \
    --param=SOURCE_REPOSITORY=https://github.com/sub-mod/mnist-models \
    --param=SOURCE_DIRECTORY=regression

```
To have any changes to your model automatically redeployed when changes are pushed back up to your Git repository, you can use the [web hooks integration](https://docs.openshift.com/container-platform/latest/dev_guide/builds.html#webhook-triggers) of OpenShift to create a link from your Git repository hosting service back to OpenShift.

## Producing a build image ##

To produce a builder image:

    $ make build

To print usage information for the builder image:

    $ sudo docker run -t <id from the make>

To poke around inside the builder image:

    $ sudo docker run -i -t <id from the make>
    bash-4.2$ cd /opt/app-root # take a look around

To tag and push a builder image:

    $ sudo make push

By default this will tag the image as `radanalyticsio/tensorflow-serving-s2i`,
edit the Makefile and change `PUSH_IMAGE` to control this.

## s2i bin files ##

S2i scripts are located at `./s2i/bin`.

