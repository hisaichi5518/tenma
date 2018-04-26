# 天満(Tenma)

Tenma is command line tool for mobile application development.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tenma'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tenma

## Usage

### Prepare for mobile application releases

#### 1. Create `tenma/prepare.yml`

```yaml
github:
    web_url: "https://github.com/"
    api_url: "https://github.com/api/v3"
    owner: "hisaichi5518"
    repo: "tenma"
kpt_issue:
    labels:
        - KPT
    title: "v<%= @context.options.raw.version %> KPT"
    body: |
        KPT issue's body
release_issue:
    labels:
        - Release
    title: "v<%= @context.options.raw.version %> Release"
    body: |
        Release issue's body
release_branch:
    version_file: "VERSION"
    hotfix:
        base: "master"
        branch: "hotfix/v<%= @context.options.raw.version %>"
    normal:
        base: "develop"
        branch: "release/v<%= @context.options.raw.version %>"
    release_note: |
        release note's template
release_pullreq:
    bases:
        - master
        - develop
    labels:
        - ReleaseBranch
    title: "【<%= base_branch %>】<%= @context.options.raw.version %> Release"
    body: |
        Release pull-request's body
```

#### 2. Run command

Run following command, if you want to create KPT issue and Release issue.
```
bundle exec tenma prepare --kpt-issue --release-issue --version 7.14.0
```

Run following command, if you want to create Release branch and Release pull-requests.
```
bundle exec tenma prepare --release-branch --release-pullreqs --version 7.14.0
```

Execute the `tenma help prepare` command, If you want more information.

### Android's remote build


#### 1. Create `tenma/ichiba.json`

```yaml
android_sdk:
    license: "your license key"
    update_list:
        - platform-tools
        - build-tools-27.0.3
        - android-27
        - extra-android-m2repository
        - extra-google-m2repository
        - extra-google-google_play_services
```

#### 2. Run command

Run following command, if you want to create and provision remote-build instance.
```
bundle exec tenma ichiba --create-instance --provision-instance
```

Run following command, if you want to delete remote-build instance.
```
bundle exec tenma ichiba --delete-instance
```

Execute the `tenma help ichiba` command, If you want more information.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hisaichi5518/tenma.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
