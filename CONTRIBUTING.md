# Contributing

## Setup
You need to already have Ruby, RubyGems, Rails, and Bundler already setup. Here are their respective versions we are currently using:
```
$ ruby -v
ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-linux]
$ gem -v
2.6.7
$ rails -v
Rails 5.0.0.1
$ bundle -v
Bundler version 1.13.6
```
In addition, you will need to have a recent version of FireFox installed and GeckoDriver in your path. Most users can download it using:
```bash
mkdir -p $HOME/bin && curl -L https://github.com/mozilla/geckodriver/releases/download/v0.11.1/geckodriver-v0.11.1-linux64.tar.gz | tar -xz -C $HOME/bin
```
**Be warned, this assumes `~/bin` (`$HOME/bin`) is in your path. If it is not, you will need to add it.**

## Cloning
Clone the repo, then run:
```bash
# Install gems
bundle install
# Setup the database
rails db:migrate
```
Some gems may fail to install because you are missing dependencies. If that is the case then install them and rerun `bundle install`. Keep doing this until every gem is installed.

You also should setup [Git Flow](http://nvie.com/posts/a-successful-git-branching-model/). Some GUI clients have an option to do this, or there is an [extension](https://github.com/nvie/gitflow) for the Git CLI.

## Coding
### New Members
If you are new to the project, then you'll probably want to have your code reviewed before it is put on the develop branch. The best way to do this is with a feature branch. Create a feature branch to code on, and push that to the repository. Then ask one of the more experienced team members to look at it for you.
### Tools
Please run the following tools before pushing (especially to develop):

Run the old tests to confirm nothing breaks, and run your new tests to make sure your code works.
```bash
rspec
```
Bundler-Audit will check the Gemfile for vulnerable gems. Brakeman will check the application for security vulnerabilities.
```bash
bundle-audit check --update
brakeman -A
```
Rubocop will check the code for styling issues. It uses the [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide) and [Rails Style Guide](https://github.com/bbatsov/rails-style-guide).
```bash
rubocop
```
## Useful Tips
### General Tips
Please remember, **all code pushed to the develop branch is considered production ready.** If aren't ready to put it on a production server *right now*, then don't push it to develop. You can commit it locally, but don't share unfinished work on develop.

Furthermore, ***NEVER EVER COMMIT DIRECTLY TO MASTER***. The master branch should only ever be touched by releases.

Atom has a [plugin](https://atom.io/packages/linter-rubocop) to add rubocop to the linter plugin. You'll need the [linter plugin](https://atom.io/packages/linter) as well.

### Testing
Use FactoryGirl for *everything*. If you need a model use `FactoryGirl.create` and if you need data use `FactoryGirl.build`. Data is guaranteed to be unique where that counts.

Remember that you don't need to deal with authorization outside of the ability and user model spec. Don't test authorization and don't write authorization. Also, don't waste time testing/dealing with 404 errors that CanCanCan already does (which should be all of them).

Only test what the controller does in a controller spec. Don't waste time testing CanCanCan or Devise functionality.

Use the Devise and Capybara macros to login automatically as a student or teacher. The user object is accessible as `user` if you need it (for example, to add a member).

Remember to add `js: true` to Capybara tests that will run JavaScript, but don't slow down the tests by adding it where it's not needed.

Use path helpers instead of hard-coded values in Capybara tests (e.g. `new_group_path` instead of `'/groups/new'`)

You can run just one file with RSpec so you don't have to sit through unrelated tests (`rspec spec/controllers/groups_controller_spec.rb`)

### Coding/Style ("The Rails Way")
Use the _id forms for RSpec tests (as that's what real users will be need to pass). However, if you already have an object, don't use _id in the actual app.

**Test *everything*.** While tests might seem useless, they are our only tool against technical debt and regression. Testing safeguards your code while still allowing others to edit it and add on to it.

Spread out logic. Don't put logic in the controller that should be in the view or model.

### Security
Mass assignment is *really bad*. Use `create_params` and `update_params` to whitelist parameters.

Be careful what you globally put in read views. Check authorization before displaying data. For example, student/teacher tokens should only be shown when `can? :manage, @group` is true.

Remember anybody can call an API function or register a teacher account. Trust nothing you don't know for certain.

You should almost never be directly calling the database using SQL. If you have to then make sure you are sanitizing input.

**Do not commit a production secret to the repo.** Use environment variables instead.

You don't need to deal with HTTPS/HSTS/etc. The SSL termination on the production server will do this.
