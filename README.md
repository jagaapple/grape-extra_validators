<h1 align="center">Grape Extra Validators</h1>

<h4 align="center">🛡 Extra validators for Grape. 🍇</h4>

```rb
params do
  requires :name, type: String, length: 4..32
  requires :age, type: Integer, minimum_value: 0
  requires :website, type: String, starts_with: %w(http:// https://)
end
```

<div align="center">
<a href="https://rubygems.org/gems/grape-extra_validators"><img src="https://img.shields.io/gem/v/grape-extra_validators" alt="gem"></a>
<a href="https://circleci.com/gh/jagaapple/grape-extra_validators"><img src="https://img.shields.io/circleci/project/github/jagaapple/grape-extra_validators/master.svg" alt="CircleCI"></a>
<a href="https://codecov.io/gh/jagaapple/grape-extra_validators"><img src="https://img.shields.io/codecov/c/github/jagaapple/grape-extra_validators.svg"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/github/license/jagaapple/grape-extra_validators.svg" alt="license"></a>
<a href="https://twitter.com/jagaapple_tech"><img src="https://img.shields.io/badge/contact-%40jagaapple_tech-blue.svg" alt="@jagaapple_tech"></a>
</div>

## Table of Contents

<!-- TOC depthFrom:2 -->

- [Table of Contents](#table-of-contents)
- [Quick Start](#quick-start)
  - [Requirements](#requirements)
  - [Installation](#installation)
  - [Setup](#setup)
- [Contributing to grape-extra_validators](#contributing-to-grape-extra_validators)
- [License](#license)

<!-- /TOC -->


## Quick Start
### Requirements
- Ruby 2.4 or higher
- Grape 1.0.0 or higher

### Installation
```bash
$ gem install grape-extra_validators
```

If you are using Bundler, add the gem to Gemfile.

```bash
gem "grape-extra_validators"
```

### Setup
Firstly you have to do.


## Contributing to grape-extra_validators
Bug reports and pull requests are welcome on GitHub at
[https://github.com/jagaapple/grape-extra_validators](https://github.com/jagaapple/grape-extra_validators). This project
is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.

Please read [Contributing Guidelines](./.github/CONTRIBUTING.md) before development and contributing.


## License
The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Copyright 2020 Jaga Apple. All rights reserve
