FROM node:14-slim

# Create app directory
WORKDIR /usr/src/app

# Bundle app source
COPY . .

ENV CHROME_BIN="/usr/bin/chromium"\
    PUPPETEER_SKIP_CHROMIUM_DOWNLOAD="true"

RUN npm install && apt-get update && apt-get install -y chromium gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0$

RUN ln -s /usr/bin/chromium /usr/bin/chromium-browser

EXPOSE 3000
CMD node ./index.js -r . --oc 2
