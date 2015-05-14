class ActiveSupport::TimeWithZone
  def to_short
    self.strftime("%F")
  end

  def to_minute
    self.strftime("%F %H:%M")
  end
end
