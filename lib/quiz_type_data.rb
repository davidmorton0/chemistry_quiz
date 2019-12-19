class QuizTypeData
  include ElementData
  
  QUIZTYPE = {
    name: "Chemical Symbol Quiz",
    num_questions: 10,
    LEVEL: {
      1 => [0, 1, 2, 5, 6, 7, 8, 9, 10, 11],
      2 => (0..29).to_a,
      3 => (0..ELEMENT.length - 1).to_a },
    difficulty: 1,
    description: "Identify the chemical symbols for
    Hydrogen, Helium, Lithium, Carbon, Nitrogen, Oxygen, Fluorine,
    Neon, Sodium and Magnesium."
  }
  QuizType.create!()

quiz2 = QuizType.create!(name: "Chemical Symbol Quiz",
                level: 2,
                num_questions: 10,
                difficulty: 2,
                description: "Identify the chemical symbols for the elements
                in the first three periods.")

quiz3 = QuizType.create!(name: "Chemical Symbol Quiz",
                level: 3,
                num_questions: 10,
                difficulty: 4,
                description: "Identify the chemical symbols for all elements.")
end