Readme v2.0, last update 02/08/16

# Romp

Creators: @jappleba, @kaylee42, & @eaud

Romp is a social app built in Ruby on Rails that helps its users find activity partners for the activities that interest them. Each user inputs their "Bookit List" of activities they'd like to host.  The hosted activities on each users list are compiled, sorted and pushed to guest users based on a simple scoring algorithm. Guest users are presented with potential activities one at a time and swipe each activity (right for like and left for dislike) similar to Tinder. Once a guest user likes an activity, that guest is user is presented to the host user for approval. Upon guest approval, a chat is opened between the two users. Any additional approved guest users are added to the chat upon approval as well. Once the chat is opened, the users themselves are responsible for ultimately planning and executing the activity.

## System & Configuration
* Ruby version: 2.2.3
* Rails version: 4.2.5


## System dependencies: running bundle install should give you most of the Gems you need to make this app work. The two main external dependencies are listed below:
* Facebook authentication - Romp utilizes facebook login and email login. In order to have functional facebook login capabilities, you will need to register as a developer with Facebook.
* Faye and Private_pub - Romp utilizes Faye in order to seamlessly and instantly publish private messages between users. Faye allows for real-time updates through an open socket without tying up a Rails process. In order to implement Faye, a separate Faye server needs to be initiated. You can find sample code and instructions for setting this up in [this repo](https://github.com/kaylee42/priv-pub-connection). In the development environment, a separate server can be racked up on another localhost. However in production, a separate application may need to be deployed to stand in for the second server we were running locally in our development environment. Romp utilizes the private_pub gem for deployment with Heroku. For instructions on how to deploy Faye with private_pub on Heroku please reference http://www.thegreatcodeadventure.com/deploying-private-pub-on-heroku/.

* **Database creation:** This project uses a PostGRES database, meaning the following steps will need to be taken to create a database to run this project:
  * rake db:create
  * rake db:migrate
  * rake db:seed


<hr>

Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
