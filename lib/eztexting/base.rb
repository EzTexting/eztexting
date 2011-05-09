module Eztexting
  class Base
    
    # This method never is really called by itself it is called from the classses do the work of the actual 
    # interaction with the api itself. 
    def self.do_post(uri,options)
      options  = options || {}
      options  = options.merge!(Eztexting.credentials)
      location = uri
      
      response = Eztexting.post(location, :body => options)
      return response.body
    end
    
    # This is a default result mapping. The response from the API is usually a coded number (except for the balance call which returns
    # the acutal number of credits). Here we map over those values to a response. This is sometimes overidden by the subclasses as thses
    # mappings to not apply the same way to all commands
    def self.process(response)
      api_result = case response
      when "-1"
        "Invalid user and/or password or API access is not allowed for your account"
      when "-10"
        "Unknown error (please contact our support dept.)"
      else
        "successful"
      end
    end
    
    # This just assembles the data to be returned from do_post in a nice clean way 
    def self.processed_reponse(response_result,response_body)
      [response_result,response_body]
    end
    
  end
end