#!/bin/bash

asdf install

mix local.hex --force

mix deps.get && \
mix ecto.setup && \
npm install --prefix slides
