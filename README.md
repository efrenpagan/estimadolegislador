<p  style="text-align: center">
<img src="/public/assets/images/site/att_logo.png" width="80">
</p>

# [atentamente.org](http://atentamente.org)

## Development setup

### Dependencies

* [node.js](https://nodejs.org/en/)

* [Bower](http://bower.io/)

* [Redis](http://redis.io/)
    * [Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-redis)

    * OSX
        * [Download Redis](http://redis.io/download)
        * [Guide to install Redis](http://jasdeep.ca/2012/05/installing-redis-on-mac-os-x/)
* [OpenJDK](http://openjdk.java.net/install/)

* [Elasticsearch](https://www.elastic.co/)

* [PostgreSQL](http://www.postgresql.org/)
    * **After installing postgres**
        * `sudo su postgres`
        * `createuser --interactive username `
        * Shall the new role be a superuser? (y/n) `y`
        * `exit`

* After installing the dependencies, start Redis and Elasticsearch

    * `sudo service redis_**port** start`
    * `sudo service elasticsearch start`

### App Setup

* `bundle install`
* `bower install`
* `rake db:setup`

### Run the app

* `rails s`
* `bundle exec sidekiq`
