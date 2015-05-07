DASHTAG FACTORY
---------------

The Dashtag Factory is an application that eases the process for users to setup [Dashtag](https://github.com/anirudh-eka/dashtag) Pages on Heroku. 

Tech Stack
----------
Ruby (2.1.3)
Rails (4.*)


Run/Contribute
--------------

Clone the repo:

	$ git clone https://github.com/anirudh-eka/dashtag_factory.git

create/migrate the test database:

	$ cd dashtag_factory
	$ rake db:migrate

run the tests (make sure they are passing before doing anything else):

	$ rspec

run the app
	$ rails s

Checkout the app in a browser, default url is `http://localhost:3000/`