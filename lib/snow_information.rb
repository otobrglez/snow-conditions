SnowInformation = Struct.new(:date, :level, :details) do

  def date
    @date ||= Date.parse(self[:date])
  end

  def sha
    @sha ||= Digest::SHA1.hexdigest (values * "-")
  end

end
