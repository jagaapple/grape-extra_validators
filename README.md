<h1 align="center">Grape Extra Validators</h1>

<h4 align="center">🛡 Extra validators for Grape. 🍇</h4>

```rb
params do
  requires :name, type: String, length: 4..32
  requires :age, type: Integer, minimum_value: 0
  requires :website, type: String, start_with: %w(http:// https://)
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
- [Validators](#validators)
  - [For String](#for-string)
    - [Length](#length)
    - [Maximum Length](#maximum-length)
    - [Minimum Length](#minimum-length)
    - [Start With](#start-with)
    - [End With](#end-with)
  - [For Numeric](#for-numeric)
    - [Value](#value)
    - [Maximum Value](#maximum-value)
    - [Minimum Value](#minimum-value)
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


## Validators
### For String
#### Length
The length validator checks whether the parameter is a specified characters length or within a specified characters length
range. You can specify an Integer or Range object to this.

```rb
params do
  requires :name, type: String, length: 4
  requires :bio, type: String, length: 4..512
end
```

#### Maximum Length
The maximum length validator checks whether the parameter is up to a specified characters length. You can specify an Integer
object to this.

```rb
params do
  requires :username, type: String, maximum_length: 20
end
```

#### Minimum Length
The minimum length validator checks whether the parameter is at least a specified characters length. You can specify an Integer
object to this.

```rb
params do
  requires :username, type: String, minimum_length: 20
end
```

#### Start With
The start with length validator checks whether the parameter starts with a specified string. You can specify a String, Symbol,
or Array which has strings object to this.

```rb
params do
  requires :website, type: String, start_with: "https://"
  requires :website, type: String, start_with: %w(http:// https://)
end
```

#### End With
The end with length validator checks whether the parameter ends with a specified string. You can specify a String, Symbol,
or Array which has strings object to this.

```rb
params do
  requires :price, type: String, end_with: "JPY"
  requires :price, type: String, end_with: %w(JPY USD)
end
```

### For Numeric
#### Value
This gem does not support a validator which checks whether the parameter is within a specified range. You can use
[`values` built-in validator](https://github.com/ruby-grape/grape#values) instead.

```rb
params do
  requires :point, type: Integer, values: 0..100
end
```

#### Maximum Value
The maximum value validator checks whether the parameter is equal to or below a specified value. You can specify a Numeric
object to this.

```rb
params do
  requires :level, type: Integer, maximum_value: 5
end
```

#### Minimum Value
The minimum value validator checks whether the parameter is equal to or above a specified value. You can specify a Numeric
object to this.

```rb
params do
  requires :age, type: Integer, minimum_value: 0
end
```


## Contributing to grape-extra_validators
Bug reports and pull requests are welcome on GitHub at
[https://github.com/jagaapple/grape-extra_validators](https://github.com/jagaapple/grape-extra_validators). This project
is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.

Please read [Contributing Guidelines](./.github/CONTRIBUTING.md) before development and contributing.


## License
The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Copyright 2020 Jaga Apple. All rights reserve
