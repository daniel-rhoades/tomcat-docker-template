# tomcat-template

Docker image which has been built by Ansible with the following roles:

* `williamyeh.oracle-java`: Oracle JDK installation;
* `daniel-rhoades.tomcat`: Runtime configurable installation of Tomcat.
 
The following options are available to you:

* Any WARs placed in `tomcat_system_home/distributions` be copied to `tomcat_catalina_base`, inside a container these can arrive either by
 * Mounting `tomcat_system_home/distributions` to suitable directory on the host machine (containing the WARs);
 * Providing a URL to a single WAR via the `WEBAPP_DISTRO_URL` environment variable; 
* Any scripts in `tomcat_catalina_base/environment` will be executed before Tomcat starts (via `setenv.sh`).

In the image `tomcat_system_home` defaults to `/opt/cms`.

# Super quick start

1. Install Vagrant;
2. Clone this project;
3. Within this project's directory run: `vagrant up`;
4. Visit http://localhost:8080/simple-jsf-example to see Tomcat hosting an example JSF application.

# Quick start

The Docker image is hosted on DockerHub https://hub.docker.com/r/danielrhoades/tomcat-template/.

There are two ways you can provide your WAR files to Tomcat (see below), in both cases you can also place any environment scripts in a volume mounted to `/opt/cms/environment`, e.g. provide the following option to the Docker run command `--volume /tmp/environment:/opt/cms/environment`.

## Map a host directory containing the WAR(s)

```
$ docker run -p 8080:8080 --volume /tmp/distributions:/opt/cms/distributions danielrhoades/tomcat-template
```

This will deploy any WARs placed in `/tmp/distributions` on the host (change the directory to anything you like).

## Ask the container to download your WAR

```
$ docker run -p 8080:8080 -e WEBAPP_DISTRO_URL=https://github.com/daniel-rhoades/simple-jsf-example/releases/download/v0.1/simple-jsf-example.war danielrhoades/tomcat-template
```

This will download the file specified in the `WEBAPP_DISTRO_URL` environment variable and deploy it to Tomcat (change the URL to anything you like).

# Building the image

This Docker image can be built by a standard Docker build command, there are no special options.