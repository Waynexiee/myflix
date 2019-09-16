# MyFlix
A website used to see movies and shows(like Netflix).
I have rewritten this website using Rails API mode and React/Redux(https://github.com/Waynexiee/Myflix2).

## Demo 
https://aqueous-spire-83196.herokuapp.com/ 

You could use Credit Card number 4242424242424242 to pay for sign-on fee.

## Goal
1. Practice user authentication, password reset, elastic search and payment using Ruby on Rails.  
2. Study how to deploy an application on Heroku with add-ons and communicate with AWS S3.  
3. Study how to develop using TDD. 

## environment   
Ruby 2.2.9  
Rails 4.4.1  
Rspec 2.99

## Design
Admin could add videos and pictures on the websites.
User could see videos after logging in and paying for fees. 
Users could add their favorite videos to queue. 
Users could review videos.
Users could follow other users and could see their reviews and video queue.

## Architecture

* Payment with [Stripe](https://stripe.com/ "Stripe")
* Pictures and videos stored on [AWS S3](https://aws.amazon.com/s3/ "AWS")
* Hosted on [Heroku](https://www.heroku.com/ "Heroku")
* Built on [Ruby on Rails](http://rubyonrails.org/ "Rails")
* [Bootstrap](https://getbootstrap.com/ "Bootstrap") for CSS
* Mail sent with [Mailgun](https://www.mailgun.com/)
* Background jobs processed with [Sidekiq](https://github.com/mperham/sidekiq)
* Advanced Search implemented with [ElasticSearch](https://www.elastic.co/)


## License
Copyright (C) 2018 Wayne Xie
