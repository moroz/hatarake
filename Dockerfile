FROM ruby:2.4.1
MAINTAINER k.j.moroz@gmail.com

RUN apt-get update && apt-get install -y build-essential nodejs

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

ENTRYPOINT ["bundle", "exec"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
