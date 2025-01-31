# Use the official Node.js image as the base image
FROM node:22-bullseye

# Update the package list and install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends gnupg wget curl unzip fontconfig fonts-dejavu fonts-liberation fonts-noto fonts-noto-cjk fonts-noto-color-emoji fonts-freefont-ttf && \
    # Add Google's public key for package verification
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    # Add Google Chrome's repository to the sources list
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
    # Update the package list again and install Google Chrome
    apt-get update -y && \
    apt-get install -y --no-install-recommends google-chrome-stable && \
    # Clean up APT when done
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/* && \
    # Get the installed Chrome version
    CHROME_VERSION=$(google-chrome --product-version) && \
    # Download the corresponding ChromeDriver version
    wget -q --continue -P /chromedriver "https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/$CHROME_VERSION/linux64/chromedriver-linux64.zip" && \
    # Unzip ChromeDriver and move it to the system PATH
    unzip /chromedriver/chromedriver* -d /usr/local/bin/ && \
    # Remove the temporary ChromeDriver directory
    rm -rf /chromedriver && \
    # Update font cache
    fc-cache -fv

# Install global npm packages
RUN npm install -g docs-to-pdf fs-extra
WORKDIR /pdf
ENV DEFAULT_ARGS="--puppeteerArgs=--no-sandbox "
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD []