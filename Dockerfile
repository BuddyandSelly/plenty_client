FROM ruby:3.1

WORKDIR /gem

RUN gem install 'faraday:1.10.3' 'typhoeus:1.4.0' \
    && gem install json rspec webmock byebug

COPY . .

CMD ["irb", "-I", "lib", "-r", "plenty_client"]
