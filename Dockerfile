# Use the official Node.js image as the base image
FROM node:22-bullseye-slim

# Install Google Chrome
RUN apt-get update && \
    apt-get install -y wget fonts-noto-color-emoji && \
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y ./google-chrome-stable_current_amd64.deb && \
    rm -rf ./google-chrome-stable_current_amd64.deb

ARG HOME=/home/node
# Set npm global install directory to the user's home directory
ENV NPM_CONFIG_PREFIX=${HOME}/.npm-global
# Ensure the global npm binary path is in the user's PATH
ENV PATH=$PATH:${NPM_CONFIG_PREFIX}/bin
# Skip the Chromium download when installing puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
USER node
# Install global npm packages
RUN npm install -g docs-to-pdf fs-extra
WORKDIR /pdf

# ENVs Defaults
ENV PUPPETEER_ARGS="--no-sandbox"
ENV DOCS_URL="https://docusaurus.io/docs"
ENV CONTENT_SELECTOR="article"
ENV PAGINATION_SELECTOR="a.pagination-nav__link.pagination-nav__link--next"
ENV EXCLUDE_SELECTOR=".margin-vert--xl a,[class^='tocCollapsible'],.breadcrumbs,.theme-edit-this-page"
ENV COVER_TITLE="Documentation"
ENV OUTPUT_PDF_FILENAME="docs-to-pdf.pdf"

COPY --chown=node:node --chmod=755 entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD []



