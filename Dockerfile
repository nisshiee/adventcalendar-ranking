FROM ruby:2.4.2-stretch

RUN set -ex \
        \
        && apt-get update \
        && apt-get install -y locales \
        && rm -rf /var/lib/apt/lists/* \
        \
        && locale-gen ja_JP.UTF-8 \
        && localedef -f UTF-8 -i ja_JP ja_JP.utf8

ENV LANG ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8
ENV TZ Asia/Tokyo

COPY Gemfile Gemfile.lock /opt/adventcalender-ranking/

RUN set -ex \
        \
        && cd /opt/adventcalender-ranking/ \
        && gem install bundler \
        && bundle config build.nokogiri --use-system-libraries \
        && bundle install

WORKDIR /opt/adventcalender-ranking/
ENTRYPOINT ["bundle", "exec", "rake"]

COPY Rakefile /opt/adventcalender-ranking/
COPY lib /opt/adventcalender-ranking/lib/
