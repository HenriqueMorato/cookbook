FROM ruby:2.5.1
MAINTAINER Henrique Morato

ENV NODE_VERSION 8
RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends nodejs \
      vim \
      postgresql-client \
      tzdata \
      locales

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
ENV LC_ALL en_US.utf8

RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
dpkg-reconfigure -f noninteractive tzdata

RUN mkdir -p /cookbook
WORKDIR /cookbook
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN echo "gem: --no-ri --no-rdoc" >> ~/.gemrc
RUN gem install bundler
RUN bundle install
RUN gem install bundler-audit

ADD . /cookbook
