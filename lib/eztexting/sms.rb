module Eztexting
  class Sms < Base
    
    # Send out a singular SMS
    # @param [Hash] opts is a hash with keys/value pairs of subject, message and phone number. The phonenumber, subject and message are required by the API
    # @return [Array] The return is an array of two elements, the mapped error code according to the extexting and the raw response
    def self.single(opts={})
      location = "/sending"
      
      response = self.do_post(location,opts)
      response_result = self.process(response)

      return self.processed_reponse(response_result,response)  
    end
    
    # Send Out Multiple Messages
    # @param [Array] messages is an array of hashes which are hashes that are identical to the hash passed into the single SMS method. This requires the same keys as the single method
    # @return [Array] The return is an array of two elements, the mapped error code according to the extexting and the raw response
    def self.multi(messages)
      location = "/sending"
      results = []
        
      messages.each_with_index do |msg, i|
        opts = msg
        response = self.do_post(location,opts)
        response_result = self.process(response)
        results << {:message => i, :result => response_result}
      end
      
      return results
    end
    
    private
    
    def self.process(response)
      api_result = case response
      when "1"
        "Message sent"
      when "-1"
        "Invalid user and/or password or API access is not allowed for your account"
      when "-2" 
        "Credit limit reached"
      when "-5"
        "Local opt out (the recipient/number is on your opt-out list.)"
      when "-7"
        "Invalid message or subject"
      when "-104"
        "Globally opted out phone number (the phone number has been opted out from all messages sent from our short code)"
      when "-106"
        "Incorrectly formatted phone number (number must be 10 digits)"
      else
        "Unknown error (please contact our support dept.)"
      end
      
      return api_result
    end
    
  end
end