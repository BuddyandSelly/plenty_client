FROM ruby:4.0

WORKDIR /gem

COPY . .

RUN bundle install

CMD ["irb", "-I", "lib", "-r", "plenty_client"]
