class ErrorSerializer 
  def self.errors(errors)
    {
      message: "your query could not be completed",
      errors: errors.to_s
    }
  end

  def self.bad_request
    {
      data: []
    }
  end

  def self.not_found(params)
    {
      error: "#{params} not found",
      data: {}
    }
  end

  def self.update_fail(errors)
    {
      errors: errors.full_messages.to_sentence
    }
  end
end