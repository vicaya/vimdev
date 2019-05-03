FROM python:3.7
LABEL maintainer="vicaya <vimdev@vicaya.com>" license="MIT"

ENV HOME /home

RUN apt-get update && \
    apt-get -y install bash-completion cmake vim-nox \
        apt-transport-https software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    apt-add-repository "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" && \
    apt-get update && apt-get -y install docker-ce-cli && \
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

COPY .bashrc .gitconfig .vimrc $HOME/
RUN mkdir /workspace && vim -T dumb +PlugUpdate +qall && chmod -R a+rX $HOME/

WORKDIR /workspace
ENTRYPOINT ["vim"]
