class AnsweredWithYes
  def self.call(answer)
    answer.downcase == 'yes'
  end
end