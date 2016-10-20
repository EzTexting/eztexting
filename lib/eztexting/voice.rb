module Eztexting
  class Voice < Base
    
    # Use the Voicebroadcast feature of the API
    # @param [Hash] This has needs the following keys, phonenumbers to call, the recording src and the caller_id value
    # @return  [Array] The return is an array of two elements, the mapped error code according to the extexting and the raw response
    def self.broadcast(opts={})
      location = "/voicemessages/"
      
      options = {
        :phonenumbers => phone_numbers,
        :soundsource => opts[:recording],
        :callerid => opts[:called_id]
      }
      response = self.do_post(location,options)
      response_result = self.process(response)

      return self.processed_reponse(response_result,response)
    end
    
    
    private
    
    def self.process(response)
      api_result = case response
      when "1"
        "Campaign Sent"
      when "-1"
        "Invalid user and/or password or API access is not allowed for your account"
      when "-2" 
        "Credit limit reached"
      when "-3"
        "Invalid callerid"
      when "-4"
        "Invalid array of phone numbers"
      when "-5"
        "Invalid soundfile (make sure you provided the correct file name with the extension)"
      when "-6"
        "Invalid soundsource (make sure you provided the correct path to the file with the extension)"
      when "-7"
        "Invalid request (make sure you use the correct names of variables)"
      else
        "Unknown error (please contact our support dept.)"
      end
      
      return api_result
    end
  end
end