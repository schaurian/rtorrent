ARG rtorrent=rtorrent-0.9.8
FROM ubuntu:latest AS build-env
RUN apt-get update && apt-get install wget p7zip
RUN wget https://github.com/Trogious/rtremote/blob/master/test/deps/$rtorrent.7z
RUN 7za $rtorrent.7z
RUN mv $rtorrent rtorrent
ADD . /src

# final stage
FROM scratch
WORKDIR /app
COPY --from=build-env /src/rtorrent /app/
ENTRYPOINT ./rtorrent
