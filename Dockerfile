# Kali Linux Top10
# Docker image with kali-linux-top10 and a handful of other useful tools
# More info: https://medium.com/@infosec_stuff/kali-linux-in-a-docker-container-5a06311624eb
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND noninteractive
# do APT update

RUN apt-get -y update && apt-get -y dist-upgrade && apt-get -y autoremove && apt-get clean git
# install Kali Linux "Top 10" metapackage and a couple "nice to have" tools
RUN apt search glib
RUN apt-get -y install kali-tools-top10 exploitdb man-db dirb nikto wpscan uniscan openssh-server openssl libc-bin

RUN wget https://downloads.arachni-scanner.com/nightlies/arachni-2.0dev-1.0dev-linux-x86_64.tar.gz && tar -xf arachni-2.0dev-1.0dev-linux-x86_64.tar.gz &&cd arachni-2.0dev-1.0dev && cp -r * /usr/bin
RUN cd /home && git clone https://github.com/anandu467/kali && cd kali && chmod +x sshin.py
RUN cd && ls && cd /usr/bin/bin && ls
RUN useradd -p $(openssl passwd -1 nana1122) shadowx
RUN service ssh restart

# initialize Metasploit databse
RUN service postgresql start && msfdb init && service postgresql stop

VOLUME /root /var/lib/postgresql
# default LPORT for reverse shell



ENTRYPOINT ["/bin/bash"]
