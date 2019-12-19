class NamesSelector
  attr_accessor :correct_answer, :answers

  def initialize(answers, correct_answer)
    @correct_answer = correct_answer
    @answers = (answers.uniq - [@correct_answer]).uniq
  end
  
  def names_starting(word)
    @answers.select {|s| s[0] == word[0]}
  end
  
  def names_not_starting(word)
    @answers.select {|s| s[0] != word[0]}
  end
  
  def same_start_letter(same_start_letter_pct)
    rand(100) < same_start_letter_pct
  end
  
  def answers(number, same_start_letter_pct)
    n = 0
    (number - 1).times do
      n += 1 if same_start_letter(same_start_letter_pct)
    end
    (names_starting(@correct_answer).take(n) +
    names_not_starting(@correct_answer).take(number - n - 1) + 
    [@correct_answer]).shuffle
  end

end