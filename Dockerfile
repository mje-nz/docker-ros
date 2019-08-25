FROM ros:kinetic-perception

# Use University of Canterbury apt mirror
RUN sed -i "s/http:\/\/archive.ubuntu.com/http:\/\/ucmirror.canterbury.ac.nz/g" /etc/apt/sources.list && \
	sed -i "s/http:\/\/packages.ros.org/http:\/\/ucmirror.canterbury.ac.nz\/linux/g" /etc/apt/sources.list.d/ros1-latest.list && \
	# ucmirror still has old ROS key
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 5523BAEEB01FA116 && \
	apt-get update && \
	# Base images can be a bit out of date
	apt-get upgrade -y && \
	# Install extra packages
	apt-get install -y \
		less \
		nano \
		# psmisc contains killall
		psmisc && \
	rm -rf /var/lib/apt/lists/*

# Set locale
# https://hub.docker.com/_/ubuntu#locales
RUN apt-get update && \
	apt-get install -y locales && \
	rm -rf /var/lib/apt/lists/* && \
	localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

WORKDIR /root
RUN apt-get update && \
	# Set up my dotfiles
	git clone https://github.com/mje-nz/dotfiles .dotfiles && \
    .dotfiles/setup && \
    # Initialise zgen
    zsh -i -c : && \
	rm -rf /var/lib/apt/lists/*

CMD ["zsh"]
