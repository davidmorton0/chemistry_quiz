module ApplicationHelper

  def full_title(page_title = '')
    base_title = "Chemistry Quiz"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  def question_data(question_number)
    data = {
      1 => {
        question: 'What is the chemical symbol for Hydrogen?',
        answers: {A: 'C', B: 'Y', C: 'D', D: 'H' },
        correct_answer: 'H'
      },
      2 => {
        question: 'What is the chemical symbol for Carbon?',
        answers: {A: 'C', B: 'Y', C: 'D', D: 'H' },
        correct_answer: 'C'
      },
      3 => {
        question: 'What is the chemical symbol for Sodium?',
        answers: {A: 'Na', B: 'Y', C: 'D', D: 'H' },
        correct_answer: 'Na'
      },
      4 => {
        question: 'What is the chemical symbol for Magnesium?',
        answers: {A: 'C', B: 'Y', C: 'Mg', D: 'H' },
        correct_answer: 'Mg'
      }
    }
    data[question_number]
  end 
  
end
