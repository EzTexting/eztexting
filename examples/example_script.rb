#!/usr/bin/env ruby
require 'eztexting'

# Cache your credentials for all subsequent requests, this is required, you must do this so that all of 
# your requests can have the right parameters. All requests to the api require the userame and password.
Eztexting.connect!(username,password)

# Now you ready to make full use of the api. The api calls are implemented as subclasses of a base class. This
# class has the posting method that merges in the username and password each time that you initialized in the 
# connect method. 
#
# All you have to do is pass in the call specific parameters, the username and password will be injected,
# here cheeck the availablity of the money keyword
Eztexting::Availability.check("money")


# Now lets make an acutal text message. Make a hash with the parameters for the api call
msg = {:phonenumber=>"5555555555", :message=>"My First Text Message", :subject=>"This is an awesome service. I love eztexting"}
Eztexting::Sms.single(msg)
