FROM centos:7
USER root
RUN yum -y install wget
RUN yum install -y git
#RUN yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl gettext
RUN yum -y install which
RUN wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
RUN rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
RUN yum -y install jenkins
RUN yum -y install java
RUN yum install -y initscripts
COPY id_rsa $JENKINS_HOME/id_rsa
COPY id_rsa.pub $JENKINS_HOME/id_rsa.pub
RUN chmod 600 $JENKINS_HOME/id_rsa && chmod 600 $JENKINS_HOME/id_rsa.pub
RUN /etc/init.d/jenkins start
RUN mkdir -p ~/.ssh
RUN mv $JENKINS_HOME/id_rsa* ~/.ssh

RUN echo "    IdentityFile $HOME/.ssh/id_rsa" >> /etc/ssh/ssh_config &&\
      echo "    StrictHostKeyChecking no      " >> /etc/ssh/ssh_config
RUN /bin/bash -c "eval '$(ssh-agent -s)';ssh-add $HOME/.ssh/id_rsa;"

#RUN ssh-keyscan -H github.com >> ~/.ssh/known_hosts

  ##CMD touch $HOME/.ssh/config &&\
  ##   echo "Host git@github.com:jurema/patio-jenkins.git" >> $HOME/.ssh/config &&\
  ##   echo "    HostName       github.com                           " >> $HOME/.ssh/config &&\
  ##   echo "    User           git                                  " >> $HOME/.ssh/config &&\
  ##   echo "    IdentityFile   $HOME/.ssh/id_rsa" >> $HOME/.ssh/config &&\
  ##   echo "    IdentitiesOnly yes                                  " >> $HOME/.ssh/config

# Configure git
CMD eval git config --global user.email $GITHUB_EMAIL && git config --global user.name $GITHUB_USERNAME

# Clone _Jenkins_ config
CMD cd /tmp && rm -rf $REPOSITORY_NAME && git clone git@github.com:jurema/patio-jenkins.git && mv /tmp/$REPOSITORY_NAME $JENKINS_HOME/


EXPOSE 8080
