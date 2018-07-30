json.answers do |json|
  json.array! @answers, partial: 'answers/answer', as: :answer
end