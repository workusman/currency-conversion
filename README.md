# Currency Converter
https://euclid-power.notion.site/Backend-Engineering-Challenge-8f6a038a5b6442c480ab3532a51a15c2

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Assumptions
As the **Fixer** free API Plan retruning only the `EUR` currency results as `base_currency`, so i'm computing by own for `USD`
### Prerequisites
What things you need to install the software and how to install them
```
postgres sql-12
ruby 2.6.5
```
install bundler gem
```
gem install bundler 2.1.2
```
### Installing
clone the repository and install required gems
```
git clone https://github.com/workusman/currency-conversion.git
cd currency-conversion
bundle install
```
### Setup
Copy the `.env.sample` to `.env`

```
cp .env.sample .env
```
Update the `DB_USER`, `DB_PASSWORD` and `FIXER_API_KEY` in `.env` file with your credentials.

Create database and run migrations
```

bundle exec rails db:create
bundle exec rails db:migrate
```
Start the Rails server
```
bundle exec rails server
```
And now you can visit the site with the URL http://localhost:3000
And now you can visit the Sidekiq Dashboard with the URL http://localhost:3000/sidekiq and view the recurring_jobs Tab to see the Hourly Scehduled Job

## Running the tests
To run test suits use the following commands
```
rspec
```
