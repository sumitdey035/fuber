# FUBER

FUBER taxi service.

* Ruby and Rails version
    * Ruby version: 2.2.1
    * Rails version: 4.2.7

* Setting up development
    * Clone the project from github
        ````
        git clone https://github.com/sumitdey035/fuber.git
        ````
    * Go to the project folder
        ````
        cd fuber
        ````
    * Run bundler
        ````
        bundle install
        ````
    * Setup database
        ````
        rake db:setup
        ````
        
* Running development env:
    * Start rails server
        ````
        rails s
        ````
* Run specs
    ````
    rake db:setup RAILS_ENV=test
    bin/rspec spec
    ````