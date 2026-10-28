FROM ruby:3-slim

# Set working directory
WORKDIR /srv/jekyll
ENV HOME=/srv/jekyll

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install bundler
RUN gem install bundler

# Copy Gemfile and Gemfile.lock first for optimal layer caching
COPY Gemfile* ./

RUN bundle install

# Set up volume mounts
VOLUME ["/srv/jekyll"]

# Jekyll port
EXPOSE 4000

# Default command
CMD ["jekyll", "serve", "--host", "0.0.0.0", "--port", "4000", "--livereload", "--trace"]