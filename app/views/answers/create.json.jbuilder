json.answer do |json|
  json.partial! 'answers/answer', answer: @answer
end