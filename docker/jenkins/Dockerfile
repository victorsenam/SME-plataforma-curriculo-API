FROM centos:7
RUN yum -y install wget
RUN yum -y install git
RUN wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
RUN rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
RUN yum -y install jenkins
RUN yum -y install java
RUN yum install -y initscripts
RUN /etc/init.d/jenkins start
EXPOSE 5000
