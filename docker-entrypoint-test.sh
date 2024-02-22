#!/bin/bash
# docker-entrypoint-test.sh

# Check if any arguments are passed
if [ $# -eq 0 ]; then
  # No arguments, run all tests
  exec bundle exec rspec
else
  # Run specific test file(s)
  exec bundle exec rspec "$@"
fi