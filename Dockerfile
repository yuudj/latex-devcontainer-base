FROM debian:bullseye-slim

ARG GIT_COMMIT="unknown"
ARG GIT_BRANCH="unknown"
ARG BUILD_ID="unknown"

LABEL \
    org.opencontainers.image.authors="https://github.com/yuudj/" \
    org.opencontainers.image.version=$BUILD_ID \
    org.opencontainers.image.revision=$GIT_COMMIT \
    org.opencontainers.image.url="https://github.com/yuudj/latex-devcontainer-base" \
    org.opencontainers.image.documentation="https://github.com/yuudj/latex-devcontainer-base" \
    org.opencontainers.image.source="https://github.com/yuudj/latex-devcontainer-baser" \
    org.opencontainers.image.title="Latex Dev container Debian" \
    org.opencontainers.image.description="Latex development container for Visual Studio Code / GitHub Codespaces"
    
ENV GIT_COMMIT=$GIT_COMMIT
ENV GIT_BRANCH=$GIT_BRANCH
ENV BUILD_ID=$BUILD_ID

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get -y install --no-install-recommends \
        apt-utils \
        git \
        procps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Tex Live
RUN apt-get update && apt-get -y upgrade \
    && apt-get -y install --no-install-recommends \
    texlive-latex-base \
    texlive-extra-utils \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-science \
    biber chktex latexmk make python3-pygments python3-pkg-resources cm-super inkscape curl \
    texlive-lang-spanish \
    texlive-bibtex-extra \
    biber  \ 
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# latexindent modules
RUN curl -L http://cpanmin.us | perl - App::cpanminus \
    && cpanm Log::Dispatch::File \
    && cpanm YAML::Tiny \
    && cpanm File::HomeDir \
    && cpanm Unicode::GCString 

ENV DEBIAN_FRONTEND=dialog \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8