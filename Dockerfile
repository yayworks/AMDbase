
FROM nimbix/ubuntu-desktop:trusty
MAINTAINER stephen.fox@nimbix.net

RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y make && \ 
    apt-get install -y gfortran && \
    apt-get -y install software-properties-common python-software-properties


RUN add-apt-repository http://dl.openfoam.org/ubuntu
RUN sh -c "wget -O - http://dl.openfoam.org/gpg.key | apt-key add -"
RUN apt-get update && \
    apt-get -y install apt-transport-https && \
    apt-get -y install openfoam4

RUN echo 'source /opt/openfoam4/etc/bashrc' >> /etc/skel/.bashrc


ADD ./scripts /usr/local/scripts

# Add PushToCompute Work Flow Metadata
ADD ./NAE/nvidia.cfg /etc/NAE/nvidia.cfg
ADD ./NAE/AppDef.json /etc/NAE/AppDef.json

#CMD /usr/local/scripts/start.sh
CMD /usr/local/scripts/update_drivers.sh
