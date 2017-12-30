FROM quay.io/coreos/hyperkube:v1.9.0_coreos.0
ENV CEPH_CODENAME=luminous
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -y && \
    apt-get install -q -yy curl lsb-release && \
    curl https://raw.githubusercontent.com/ceph/ceph/master/keys/release.asc | apt-key add - && \
    echo deb http://download.ceph.com/debian-${CEPH_CODENAME}/ $(lsb_release --codename --short) main | tee /etc/apt/sources.list.d/ceph.list && \
    apt-get update -y && \ 
    apt-get install -q -yy ceph-common && \
    apt-get autoremove -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

LABEL maintainer="ja.lauricella@gmail.com"
