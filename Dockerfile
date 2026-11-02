FROM ruby:4.0.7

WORKDIR /gem

RUN gem install --no-document \
      faraday faraday-retry faraday-typhoeus typhoeus json \
      rspec simplecov webmock

COPY . .

CMD ["irb", "-I", "lib", "-r", "plenty_client"]
