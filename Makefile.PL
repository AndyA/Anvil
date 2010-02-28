#!/usr/bin/env perl
use inc::Module::Install;
use Module::Install::Catalyst;

name 'WWW-Anvil';
all_from 'lib/WWW/Anvil.pm';

requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::StackTrace';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Runtime' => '5.8002';
requires 'Config::General';
requires 'Moose';
requires 'namespace::autoclean';

test_requires 'Test::More' => '0.88';
catalyst;

install_script glob( 'script/*.pl' );
auto_install;
WriteAll;
