class String
  def as_date
    Date.parse(self)
  end
end
