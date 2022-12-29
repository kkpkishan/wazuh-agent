FROM amazonlinux:latest

LABEL maintainer "Kishan Khatrani"
LABEL version "4.3.10-1"
LABEL description "Wazuh Agent"

RUN echo -e "[wazuh_repo]\ngpgcheck=1\ngpgkey=https://packages.wazuh.com/key/GPG-KEY-WAZUH\nenabled=1\nname=Wazuh repository\nbaseurl=https://packages.wazuh.com/4.x/yum/\nprotect=1" > /etc/yum.repos.d/wazuh.repo

RUN yum install -y wazuh-agent-4.3.10-1


COPY entrypoint.sh /entrypoint.sh
COPY ossec.conf /var/ossec/etc/ossec.conf
RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["sh", "/entrypoint.sh"]