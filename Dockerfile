#Require Node.js12
FROM node:buster

# Create app directory
WORKDIR /usr/src/app

# Bundle app source
COPY . .

# ENV CHROME_BIN="/usr/bin/chromium-browser"\
#     PUPPETEER_SKIP_CHROMIUM_DOWNLOAD="true"

RUN apt update -qq \
  && apt install -yqq --no-install-recommends \
  chromium

RUN npm install && apt-get update && apt-get install -y gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget libgbm-dev libxcb-dri3-0

# RUN apt-get update -qq \
#   && apt-get install -qq --no-install-recommends \
#     ca-certificates \
#     apt-transport-https \
#     gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget libgbm-dev libxcb-dri3-0 \
#   && apt-get upgrade -qq
#
# SHELL ["/bin/bash", "-o", "pipefail", "-c"]
#
# RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#   && echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
#   && apt-get update -qq \
#   && apt-get install -yqq --no-install-recommends \
#     google-chrome-stable
#
# RUN npm install

# RUN apt-get update && \
#   apt-get install -y gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget libgbm-dev libxcb-dri3-0 && \
#   npm install

#Install deps
# RUN apt-get update && \
#   apt-get install -y wget gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget libgbm-dev libxcb-dri3-0 && \
#   wget http://http.us.debian.org/debian/pool/main/c/chromium/chromium_90.0.4430.212-1_armhf.deb && \
#   dpkg -i chromium_90.0.4430.212-1_armhf.deb --fix-missing; apt-get -fy install \
#   npm install

EXPOSE 3000
CMD node ./index.js -r . --oc 1
