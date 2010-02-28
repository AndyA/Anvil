#!/bin/sh

./script/www_anvil_create.pl \
  model DB DBIC::Schema WWW::Anvil::Schema \
  create=static dbi:Pg:dbname=anvil anvil anvil

