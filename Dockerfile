FROM ruby:3.3.0

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  postgresql-client \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN gem install bundler
RUN gem install rails

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["bash"]