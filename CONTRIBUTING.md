# Contributing

## First Setup
Clone the repo, then run:
```bash
# Install gems
bundle install
# Setup the database
rails db:migrate
```
You also should setup [Git Flow](http://nvie.com/posts/a-successful-git-branching-model/). Some GUI clients have an option to do this, or there is [an extension](https://github.com/nvie/gitflow) for the Git CLI.

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
Please remember, **all code pushed to the develop branch is considered production ready.** If aren't ready to put it on a production server *right now*, then don't push it to develop.

Furthermore, ***NEVER EVER COMMIT DIRECTLY TO MASTER***. The master branch should only ever be touched by releases.

Atom has a [plugin to add rubocop to the linter plugin](https://atom.io/packages/linter-rubocop). You'll need the [linter plugin](https://atom.io/packages/linter) as well.
