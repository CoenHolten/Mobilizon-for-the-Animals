FROM elixir:1.16.1-otp-26-alpine

RUN apk add --no-cache inotify-tools postgresql-client file make gcc libc-dev argon2 imagemagick cmake build-base libwebp-tools bash ncurses git python3 npm

RUN mkdir /tmp-home
RUN chown -R 1000:1000 /tmp-home

EXPOSE 4000
EXPOSE 5173
