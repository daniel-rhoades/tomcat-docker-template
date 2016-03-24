#
# Dockerfile for building a base image that contains Ansible and running the test playbook
#

FROM williamyeh/ansible:ubuntu14.04-onbuild

MAINTAINER Daniel Rhoades <daniel@danielrhoades.com>

ENV PLAYBOOK playbook.yml
RUN ansible-playbook-wrapper

EXPOSE 8080

ENV USER_HOME /opt/cms
ENV CATALINA_BASE /opt/cms/tomcat
ENV PATH $CATALINA_BASE/bin:$USER_HOME/bin:$PATH
WORKDIR $USER_HOME

VOLUME ["$USER_HOME/environment", "$USER_HOME/distributions"]

USER cms
ENTRYPOINT ["entrypoint.sh"]
CMD ["catalina.sh", "run"]