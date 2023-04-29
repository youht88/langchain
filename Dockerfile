From ubuntu

Env LANG en_US.UTF-8 LC_ALL=en_US.UTF-8
Run ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
Workdir /home
Run yes | apt update
Run yes | apt install python3 python3-pip
Run pip3 install jupyter
Run pip3 install langchain openai
Cmd ["jupyter","notebook","--ip=0.0.0.0","--port=8888","--allow-root"]