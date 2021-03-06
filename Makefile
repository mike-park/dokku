GITRECEIVE_URL = https://raw.github.com/progrium/gitreceive/master/gitreceive
SSHCOMMAND_URL = https://raw.github.com/progrium/sshcommand/master/sshcommand

all: install

install: gitreceive sshcommand
	cp dokku /usr/local/bin/dokku
	cp receiver /home/git/receiver
	cp nginx-app-conf /home/git/nginx-app-conf
	cp nginx-reloader.conf /etc/init/nginx-reloader.conf
	echo "include /home/git/*/nginx.conf;" > /etc/nginx/conf.d/dokku.conf

gitreceive:
	wget -qO /usr/local/bin/gitreceive ${GITRECEIVE_URL}
	chmod +x /usr/local/bin/gitreceive
	gitreceive init

sshcommand:
	wget -qO /usr/local/bin/sshcommand ${SSHCOMMAND_URL}
	chmod +x /usr/local/bin/sshcommand
	sshcommand create dokku /usr/local/bin/dokku

count:
	cat receiver dokku bootstrap.sh nginx-app-conf nginx-reloader.conf | wc -l