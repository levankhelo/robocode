FROM ubuntu
RUN apt-get update
RUN apt-get install -y robocode
RUN ln /usr/games/robocode /bin/robocode
CMD robocode