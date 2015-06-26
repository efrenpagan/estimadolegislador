#atentamente.org

## Development setup

### Dependencies

* [Bower](http://bower.io/)
* [Redis](http://redis.io/)
* [Elasticsearch](https://www.elastic.co/)
* [PostgreSQL](http://www.postgresql.org/)

After installing the dependencies, start Elasticsearch and Redis:

### App setup

* `bundle install`
* `bower install`
* `rake db:setup`

### Run the app

* `rails s`
* `bundle exec sidekiq`
