# README

FBSapp is a Ruby on Rails web application that allows admin users to create, update, delete rooms/bookings/users. Users are allowed to book facilities and manage bookings.

Login into the application for the first time with the following credentials:

Username    => admin

Password    => password

Web Application Information:
* Ruby 2.5.3p105
* Rails 5.2.2.1
* Database: MySQL2 0.5.2

How to deploy on Heroku: 
  Source: https://devcenter.heroku.com/articles/getting-started-with-rails5
  1) To deploy, a heroku account is needed and can be created for free
  2) After creating an account, download the heroku CLI tools
  3) Next, get the ClearDB MySQL add on in the site dashboard and select the free 'ignite' plan
  4) Go to settings on the app dashboard in the site and click 'Reveal Config Vars' to get the DB URL
  5) Insert the DB URL into your database.yml file under production
  
          production:
            url: <%= CLEARDB_URL %>
  6) Open up your console and change the directory to the folder containing all files in your application
  7) Login into Heroku using: 
  
          "heroku login"
  8) Create a new app on your account with the following command: 
  
          "heroku create"
  9) Run the following command to ensure project is inside a git directory and the following information will be displayed :
   
          "git config --list | grep heroku"
          
          remote.heroku.url=https://git.heroku.com/<Project Name>.git
          remote.heroku.fetch=+refs/heads/*:refs/remotes/heroku/*
  10) Deploy your code with the following command: 
  
          "git push heroku master"
  11) Next, run the following command to migrate database tables into your database: 
  
          "rake db:migrate RAILS_ENV=production"
