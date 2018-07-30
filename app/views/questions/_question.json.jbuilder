json.(question, :title, :slug, :body, :created_at, :updated_at)
json.author question.user, partial: 'profiles/profile', as: :user