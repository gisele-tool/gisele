# Gisele

Gisele is a Process Analyzer Toolset

## Description

This is the process modeling and analysis toolset developed during the Gisele and
PIPAS research projects held at the University of Louvain in 2008-2012.

## Installation

This project requires an installation of ruby >= 1.9.2. Then,

    gem install gisele
    gisele --help

For contributors (UCLouvain students, in particular), please consider the following 
scenario:

    gem install bundler --pre
    git clone https://blambeau@github.com/blambeau/gisele.git   # or your own fork
    cd gisele
    bundle install
    rake test                           # please report any test failure on github
    bundle exec ./bin/gisele --help

## Contributing

Gisele is distributed under a MIT license. The common github workflow (fork/pull request) 
applies. Please take contact with Bernard Lambeau with any question.