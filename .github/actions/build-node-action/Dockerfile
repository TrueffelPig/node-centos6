FROM centos:centos6
LABEL maintainer="joe@rstudio.com"

COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
COPY epel.repo /etc/yum.repos.d/epel.repo

RUN yum -y install wget kernel-headers

RUN yum -y install centos-release-scl
RUN yum -y install python27
RUN yum -y install rh-python36
RUN yum -y install devtoolset-9
RUN yum -y install git
RUN yum -y install xz

RUN wget http://copr-be.cloud.fedoraproject.org/results/mosquito/myrepo-el6/epel-6-x86_64/glibc-2.17-55.fc20/glibc-2.17-55.el6.x86_64.rpm
RUN wget http://copr-be.cloud.fedoraproject.org/results/mosquito/myrepo-el6/epel-6-x86_64/glibc-2.17-55.fc20/glibc-common-2.17-55.el6.x86_64.rpm
RUN wget http://copr-be.cloud.fedoraproject.org/results/mosquito/myrepo-el6/epel-6-x86_64/glibc-2.17-55.fc20/glibc-devel-2.17-55.el6.x86_64.rpm
RUN wget http://copr-be.cloud.fedoraproject.org/results/mosquito/myrepo-el6/epel-6-x86_64/glibc-2.17-55.fc20/glibc-headers-2.17-55.el6.x86_64.rpm
RUN wget http://copr-be.cloud.fedoraproject.org/results/mosquito/myrepo-el6/epel-6-x86_64/glibc-2.17-55.fc20/glibc-utils-2.17-55.el6.x86_64.rpm
RUN wget http://copr-be.cloud.fedoraproject.org/results/mosquito/myrepo-el6/epel-6-x86_64/glibc-2.17-55.fc20/glibc-static-2.17-55.el6.x86_64.rpm
RUN wget http://copr-be.cloud.fedoraproject.org/results/mosquito/myrepo-el6/epel-6-x86_64/glibc-2.17-55.fc20/nscd-2.17-55.el6.x86_64.rpm

RUN rpm -Uvh --force --nodeps glibc-2.17-55.el6.x86_64.rpm glibc-common-2.17-55.el6.x86_64.rpm glibc-devel-2.17-55.el6.x86_64.rpm glibc-headers-2.17-55.el6.x86_64.rpm
RUN rpm -Uvh --force --nodeps glibc-static-2.17-55.el6.x86_64.rpm glibc-utils-2.17-55.el6.x86_64.rpm nscd-2.17-55.el6.x86_64.rpm

COPY make-node.sh /make-node.sh

ENTRYPOINT [ "/make-node.sh" ]
