FROM ubuntu

RUN apt-get update && \
    apt-get -y install expect redis-server nodejs npm

RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install -g coffee-script
RUN npm install -g yo generator-hubot

# create hubot user
RUN	useradd -d /hubot -m -s /bin/bash -U hubot

# change to hubot user
USER	hubot
WORKDIR /hubot

# install hubot
RUN yes | yo hubot --owner="hubot_user" --name="Test" --description="Test" --defaults

# add scripts
RUN npm install hubot-auth --save && npm install
RUN npm install hubot-alias --save && npm install
RUN npm install hubot-hipchat --save && npm install
RUN npm install hubot-google-translate --save && npm install
ADD hubot/hubot-scripts.json /hubot/
ADD hubot/external-scripts.json /hubot/
ADD hubot/scripts/* /hubot/scripts/

# run hubot
CMD ["bin/hubot --adapter hipchat"]
