class ErrorSerializer 
  def self.errors(errors)
    {
      message: "your query could not be completed",
      errors: errors.to_s
    }
  end
end