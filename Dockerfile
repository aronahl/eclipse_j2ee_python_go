FROM python:3.7-stretch
RUN tar -C /usr/local -c . > /tmp/tmp.tar

FROM aronahl/eclipse_j2ee
USER root
ADD com.googlecode.goclipse.core.prefs org.python.pydev.prefs /opt/workspace/.metadata/.plugins/org.eclipse.core.runtime/.settings/
RUN apt-get update && \
    apt-get dist-upgrade -fy && \
    apt-get install -fy curl git && \
    curl -s https://storage.googleapis.com/golang/go1.11.5.linux-amd64.tar.gz | tar -C /usr/local -xzv && \
    mkdir /opt/go && chown user /opt/go && \
    chown -R user /opt/workspace && \
    apt-get autoclean -y && \
    apt-get clean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* 
COPY --from=0 /tmp/tmp.tar /tmp
RUN tar -C/usr/local -xvf /tmp/tmp.tar && \
    rm /tmp/tmp.tar
USER user
RUN /opt/eclipse/eclipse -nosplash -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/neon/,http://pydev.org/updates/ -installIU org.python.pydev.feature.feature.group -profileProperties org.eclipse.update.install.features=true
RUN /opt/eclipse/eclipse -nosplash -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/neon/,http://goclipse.github.io/releases/ -installIU goclipse_feature.feature.group -profileProperties org.eclipse.update.install.features=true
RUN /opt/eclipse/eclipse -nosplash -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/neon/ -installIU org.eclipse.linuxtools.docker.feature.feature.group -profileProperties org.eclipse.update.install.features=true
ENV GOPATH=/opt/go \
    LD_LIBRARY_PATH=/usr/local/lib:/usr/lib
RUN /usr/local/go/bin/go get -u github.com/nsf/gocode && \
    /usr/local/go/bin/go get -u golang.org/x/tools/cmd/guru && \
    /usr/local/go/bin/go get -u github.com/rogpeppe/godef
