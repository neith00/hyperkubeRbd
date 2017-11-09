ARG CEPH_CODENAME=luminous
ARG HYPERKUBE_VERSION=1.8.2
 
FROM quay.io/coreos/hyperkube:v${HYPERKUBE_VERSION}_coreos.0
ARG CEPH_CODENAME
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -y && \
    apt-get install -q -yy curl lsb-release && \
    curl https://raw.githubusercontent.com/ceph/ceph/master/keys/release.asc | apt-key add - && \
    echo deb http://download.ceph.com/debian-${CEPH_CODENAME}/ $(lsb_release --codename --short) main | tee /etc/apt/sources.list.d/ceph.list && \
    apt-get update -y && \ 
    apt-get install -q -yy ceph-common && \
    apt-get autoremove -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
