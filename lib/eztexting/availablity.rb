module Eztexting
  class Availability < Base
    
    # Check the availablity of a keyword 
    # @param [String] This is the keyword that you would like to check the status of.
    # @return [Array] The first element will be weather the keyword is free or a status message , the second element is the raw response
    def self.check(keyword)
      location = "/keyword/check/"
      options  = {:keyword => keyword}
      
      response = self.do_post(location,options)
      response_result = self.process(response)
      
      return self.processed_reponse(response_result,response)
    end
    
    
    private
    
    def self.process(response)
      api_result = case response
      when "1"
        "The keyword is available"
      when "0"
        "The keyword is not available"
      when "-1" 
        "Invalid user and/or password or API access is not allowed for your account"
      when "-10"
        "error"
      else
        "error"
      end
      
      return api_result
    end
    
  end
end