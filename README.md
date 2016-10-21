# Testor Server
This is the server component of the testing software Testor. It includes the API and teacher panel. Student access is provided by Testor Client.

## Setup
Clone the repo, then run:
```shell
# Setup git flow (If you use a GUI git client you may need to do this there)
git flow init
# Install gems
bundle install
# Setup the database
rails db:migrate
```

## Contributing
Before pushing please run:
```shell
# Run tests
rspec
# Find security issues
brakeman -A
# Find bad gems
bundle-audit check --update
# Check style
rubocop
```
