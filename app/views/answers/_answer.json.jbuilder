json.(answer, :id, :created_at, :updated_at, :body, :is_accepted)
json.author answer.user, partial: 'profiles/profile', as: :user