FROM centos:centos6
LABEL maintainer="joe@rstudio.com"

COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
COPY epel.repo /etc/yum.repos.d/epel.repo

RUN yum -y install wget kernel-headers

RUN yum -y install centos-release-scl
RUN yum -y install python27
RUN yum -y install devtoolset-5
RUN yum -y install git
RUN yum -y install xz

COPY make-node.sh /make-node.sh

ENTRYPOINT [ "/make-node.sh" ]
