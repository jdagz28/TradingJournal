FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y postgresql wget zsh neofetch git

COPY ./conf/postgresql-conf.sh /postgresql-conf.sh
RUN chmod +x /postgresql-conf.sh

RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

COPY ./conf/zshrc.sh /root/.
RUN chmod +x /root/zshrc.sh
RUN /root/zshrc.sh

ENTRYPOINT ["/postgresql-conf.sh"]
