class ErrorSerializer 
  def self.errors(errors)
    {
      message: "your query could not be completed",
      error: errors.to_s
    }
  end

  def self.bad_request
    {
      data: [

      ]
    }
  end

  def self.not_found(params)
    {
      error: "#{params} not found",
      data: {
        
      }
    }
  end

  def self.valid_fail(errors)
    {
      error: errors.full_messages.to_sentence
    }
  end

  def self.incorrect_price 
    {
      error: "price must be positive"
    }
  end
end