# 天満(Tenma)

Tenma is command line tool for mobile application development.

- [:kissing_closed_eyes:Prepare for mobile application release.](README.md#kissing_closed_eyeskissing_closed_eyes-prepare-for-mobile-application-release-kissing_closed_eyeskissing_closed_eyes)
- [:relaxed:Manipulate "Android-remote-build" instance.](README.md#relaxedrelaxed-manipulate-android-remote-build-instance-relaxedrelaxed)

## Usage

### :kissing_closed_eyes::kissing_closed_eyes: Prepare for mobile application release. :kissing_closed_eyes::kissing_closed_eyes:

#### 1. :paperclip: Set `TENMA_GITHUB_TOKEN` environment.

[Github Personal access tokens](https://github.com/settings/tokens) is required. The only necessary scope is repo.

Set `TENMA_GITHUB_TOKEN` at .zshrc or .bashrc.
```
export TENMA_GITHUB_TOKEN=your-github-personal-access-token
```

#### 2. :memo: Create `tenma/prepare.yml`

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
    changelogs:
        - path: "./fastlane/metadata/android/ja-JP/changelogs"
          body: |
              changelog's body
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

#### 3. :runner: Run command

Run following command, if you want to create KPT issue and Release issue.
```
bundle exec tenma prepare --kpt-issue --release-issue --version 7.14.0
```

Run following command, if you want to create Release branch and Release pull-requests.
```
bundle exec tenma prepare --release-branch --release-pullreqs --version 7.14.0
```

#### 4. :helicopter: Finish!

Execute the `tenma help prepare` command, If you want more information.

Ex)
```
 $ bundle exec help prepare
Usage:
  tenma prepare --version=VERSION

Options:
  [--kpt-issue], [--no-kpt-issue]
  [--release-issue], [--no-release-issue]
  [--release-branch], [--no-release-branch]
  [--release-pullreqs], [--no-release-pullreqs]
  [--config-file=CONFIG-FILE]
                                                 # Default: ./tenma/prepare.yml
  [--github-token=GITHUB-TOKEN]
                                                 # Default: <Github personal access token>
  --version=VERSION
```

### :relaxed::relaxed: Manipulate "Android-remote-build" instance. :relaxed::relaxed:

#### 1. :cloud: Install and init `gcloud` command.

[About gcloud](https://cloud.google.com/sdk/gcloud)

#### 2. :paperclip: Set `TENMA_ICHIBA_INSTANCE_PROJECT` environment.

Set `TENMA_ICHIBA_INSTANCE_PROJECT` at .zshrc or .bashrc.

```
export TENMA_ICHIBA_INSTANCE_PROJECT=your-gcp-project
```

#### 3. :memo: Create `tenma/ichiba.yml`

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

# Specify java sdk version if needed. Default: 8
java_version: 11
```

#### 4. :runner: Run command

Run following command, if you want to create and provision remote-build instance.
```
bundle exec tenma ichiba --create-instance --provision-instance
```

Run following command, if you want to delete remote-build instance.
```
bundle exec tenma ichiba --delete-instance
```

#### 5. :helicopter: Finish!

Execute the `tenma help ichiba` command, If you want more information.

Ex)
```
 $ bundle exec tenma help ichiba
Usage:
  tenma ichiba --instance-disk-size=N --instance-machine-type=INSTANCE-MACHINE-TYPE --instance-name=INSTANCE-NAME --instance-project=INSTANCE-PROJECT --instance-zone=INSTANCE-ZONE --node-yaml=NODE-YAML --ssh-key-file=SSH-KEY-FILE

Options:
  [--create-instance], [--no-create-instance]
  [--provision-instance], [--no-provision-instance]
  [--delete-instance], [--no-delete-instance]
  [--restart-instance], [--no-restart-instance]
  --instance-name=INSTANCE-NAME
                                                     # Default: remote-build
  --instance-zone=INSTANCE-ZONE
                                                     # Default: asia-northeast1-c
  --instance-project=INSTANCE-PROJECT
  --instance-machine-type=INSTANCE-MACHINE-TYPE
                                                     # Default: n1-highcpu-16
  --instance-disk-size=N
                                                     # Default: 20
  --ssh-key-file=SSH-KEY-FILE
                                                     # Default: ~/.ssh/id_rsa
  --node-yaml=NODE-YAML
                                                     # Default: ./tenma/ichiba.yml
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tenma'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tenma

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hisaichi5518/tenma.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## :eyes::eyes: See also :eyes::eyes:

- [モバイルアプリのリリース作業自動化への取り組み - ペパボテックブログ](https://tech.pepabo.com/2017/10/06/improve-application-release-flow/)
- [minne Androidアプリのビルドをリモートビルドで高速化！ - ペパボテックブログ](https://tech.pepabo.com/2018/05/01/remote-build-for-android/)
