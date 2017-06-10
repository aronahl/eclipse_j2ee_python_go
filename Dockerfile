FROM aronahl/eclipse_j2ee
USER root
ADD com.googlecode.goclipse.core.prefs org.python.pydev.prefs /opt/workspace/.metadata/.plugins/org.eclipse.core.runtime/.settings/
RUN apt-get update && \
    apt-get dist-upgrade -fy && \
    apt-get install -fy python3 python3-minimal curl git && \
    curl -s https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz | tar -C /usr/local -xzv && \
    mkdir /opt/go && chown user /opt/go && \
    chown -R user /opt/workspace && \
    apt-get autoclean -y && \
    apt-get clean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* 
USER user
RUN /opt/eclipse/eclipse -nosplash -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/neon/,http://pydev.org/updates/ -installIU org.python.pydev.feature.feature.group
RUN /opt/eclipse/eclipse -nosplash -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/neon/,http://goclipse.github.io/releases/ -installIU goclipse_feature.feature.group
ENV GOPATH=/opt/go
RUN /usr/local/go/bin/go get -u github.com/nsf/gocode && \
    /usr/local/go/bin/go get -u golang.org/x/tools/cmd/guru && \
    /usr/local/go/bin/go get -u github.com/rogpeppe/godef
