module Eztexting
  class Credits < Base
    
    # Check the balance of credits left on your account
    # @return [Array] The return is an array of two elements, if the call was sucessfull the you should get the success and the second element will be the number of credits available.
    def self.balance
      location = "/credits/check/"
      
      response = self.do_post(location,{})  
      response_result = if response.to_i > 0
        "The amount of plan and additional credits available"
      elsif response == -1
        "Invalid user and/or password or API is not allowed for your account"
      else
        "Unknown error (please contact our support dept.)"
      end
      
      return self.processed_reponse(response_result,response)
    end
    
    # Purchase more credits for your account
    # @param [Hash] This takes alot of keys that are all required, you need a full billing address and a full credit card
    # @return [Array] The return is an array of two elements, the mapped error code according to the extexting and the raw response
    def self.purchase(opts={})
      location = "/credits/buy/"
      options = {
        :credits => opts[:credits],
        :firstname => opts[:first_name],
        :lastname => opts[:last_name],
        :address => opts[:address], 
        :city => opts[:city], 
        :state => opts[:state], 
        :zip => opts[:zip], 
        :country => opts[:country], 
        :type => opts[:cc_type], 
        :ccnumber => opts[:cc_number],
        :cccode => opts[:cc_verification_code], 
        :expm => opts[:cc_expiration_month], 
        :expy => opts[:cc_expiration_year]
      }
      
      response = self.do_post(location,options)
      response_result = self.process(response)

      return self.processed_reponse(response_result,response)
    end
    
    private
    def self.process(response)
      api_result = case response
      when "1"
        "Purchase Was Sucessful"
      when "0"
        "The Purchase Was Declined"
      when "-1" 
        "Invalid user and/or password or API access is not allowed for your account"
      when "-2"
        "Request declined because it is less than $5.00 minimum purchase."
      when "-10"
        "Unknown error (please contact our support dept.)"
      else
        "Unknown error (please contact our support dept.)"
      end
      
      return api_result
    end
    
  end
end