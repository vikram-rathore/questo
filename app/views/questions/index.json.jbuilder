json.questions do |json|
  json.array! @questions, partial: 'questions/question', as: :question
end

json.questions_count @questions_count