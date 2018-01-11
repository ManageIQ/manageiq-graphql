# ManageIQ::GraphQL

[![Gem Version](https://badge.fury.io/rb/manageiq-graphql.svg)](http://badge.fury.io/rb/manageiq-graphql)
[![Build Status](https://travis-ci.org/ManageIQ/manageiq-graphql.svg)](https://travis-ci.org/ManageIQ/manageiq-graphql)
[![Code Climate](https://codeclimate.com/github/ManageIQ/manageiq-graphql.svg)](https://codeclimate.com/github/ManageIQ/manageiq-graphql)
[![Test Coverage](https://codeclimate.com/github/ManageIQ/manageiq-graphql/badges/coverage.svg)](https://codeclimate.com/github/ManageIQ/manageiq-graphql/coverage)
[![Dependency Status](https://gemnasium.com/ManageIQ/manageiq-graphql.svg)](https://gemnasium.com/ManageIQ/manageiq-graphql)
[![Security](https://hakiri.io/github/ManageIQ/manageiq-graphql/master.svg)](https://hakiri.io/github/ManageIQ/manageiq-graphql/master)

[![Chat](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/ManageIQ/api?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Translate](https://img.shields.io/badge/translate-zanata-blue.svg)](https://translate.zanata.org/zanata/project/view/manageiq-graphql)

The [GraphQL](http://graphql.org/) V2 API for [ManageIQ](https://github.com/ManageIQ/manageiq)

**Note: This project is currently in early alpha**

## Installation

Add the following to ManageIQ's Gemfile:

```ruby
gem 'manageiq-graphql', :git => "https://github.com/manageiq/manageiq-graphql"
```

Then execute:

```bash
$ bundle install
```

Finally, mount the engine's routes in ManageIQ's `config/routes.rb`:

```ruby
mount ManageIQ::GraphQL::Engine, :at => '/graphql'
```

## Running the test suite

```ruby
$ bin/rspec
```

## License

The gem is available as open source under the terms of the [Apache-2.0 License](https://opensource.org/licenses/Apache-2.0).
