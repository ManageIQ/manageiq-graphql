# ManageIQ::GraphQL

[![Gem Version](https://badge.fury.io/rb/manageiq-graphql.svg)](http://badge.fury.io/rb/manageiq-graphql)
[![Build Status](https://travis-ci.org/ManageIQ/manageiq-graphql.svg?branch=hammer)](https://travis-ci.org/ManageIQ/manageiq-graphql)
[![Code Climate](https://codeclimate.com/github/ManageIQ/manageiq-graphql.svg)](https://codeclimate.com/github/ManageIQ/manageiq-graphql)
[![Test Coverage](https://codeclimate.com/github/ManageIQ/manageiq-graphql/badges/coverage.svg)](https://codeclimate.com/github/ManageIQ/manageiq-graphql/coverage)
[![Dependency Status](https://gemnasium.com/ManageIQ/manageiq-graphql.svg)](https://gemnasium.com/ManageIQ/manageiq-graphql)
[![Security](https://hakiri.io/github/ManageIQ/manageiq-graphql/hammer.svg)](https://hakiri.io/github/ManageIQ/manageiq-graphql/hammer)
[![Chat](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/ManageIQ/api)
[![Translate](https://img.shields.io/badge/translate-zanata-blue.svg)](https://translate.zanata.org/zanata/project/view/manageiq-graphql)

The [GraphQL](http://graphql.org/) API for [ManageIQ](https://github.com/ManageIQ/manageiq)

**Note: This project is currently in early alpha**

## Installation

This Rails engine is included with ManageIQ! No separate installation required.

## Contributing

### Prerequisites

It is assumed you have met all prerequisites for installing the ManageIQ app,
as described [here](http://manageiq.org/docs/guides/developer_setup).

### Setup

First, fork/clone the project:

```plaintext
git clone git@github.com:username/manageiq-graphql.git
```

Next, run the setup script:

```plaintext
$ cd manageiq-graphql
$ bin/setup
```

This should be sufficient to meet all development dependencies. During
development, if you need to update the dependencies you can do so by running:

```plaintext
$ bin/update
```

For more details on developing ManageIQ plugins, please refer to the
[ManageIQ Plugin Development guide](http://manageiq.org/docs/guides/developer_setup/plugins).

### Running the test suite

To run the entire test suite:

```plaintext
$ bundle exec rake spec
```

Individual files/tests can be run using the RSpec's normal executable:

```plaintext
$ bundle exec rspec spec/path/to/spec.rb:<optional line number>
```

## License

The gem is available as open source under the terms of the [Apache-2.0 License](https://opensource.org/licenses/Apache-2.0).
