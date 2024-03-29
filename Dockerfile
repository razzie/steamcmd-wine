FROM cm2network/steamcmd:root

RUN apt update && apt install -y wine gettext-base xvfb x11-utils
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y wine32
RUN rm -rf /var/lib/apt/lists/*
ENV DISPLAY=:99
RUN winecfg

RUN mkdir /scripts
COPY install.sh /scripts/
COPY entrypoint.sh /scripts/
RUN chmod +x /scripts/install.sh
RUN chmod +x /scripts/entrypoint.sh
RUN chown -R steam /scripts

RUN mkdir /app
RUN ln -s /scripts/install.sh /app/install.sh
RUN ln -s /scripts/entrypoint.sh /app/entrypoint.sh
RUN chown -R steam /app

USER steam
WORKDIR /app
ENTRYPOINT [ "/app/entrypoint.sh" ]