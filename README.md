# ZtAdmin

Gem to generate Admin Scope files for RoR 6 App via CLI

## Versions

```bash
1.x   Rails 5 with Sprockets
2.x:  Ruby 2.7.x / Rails 6 with Webpacker
```

## Functionality

* Initializes the Admin Scope
* Clones generic files
* Generates model 'User'
* Generates admin files for a selected model

## Development

```bash
chruby 2.7.1
bundle gem zt_admin
```

Then update files:

```bash
lib/zt_admin.rb, bin/zt_admin, zt_admin.gemspec, .gitignore
```

### Install gem

```bash
rm zt_admin*.gem; git add .; gem build zt_admin.gemspec; gem install --local zt_admin-x.y.z.gem
```

### Uninstall gem

```bash
gem uninstall -i /Users/zhenya/.gem/ruby/2.7.1 zt_admin
```

## Usage

Use help option `zt_admin -h | --help` for details

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT)