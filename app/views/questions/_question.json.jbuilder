json.(question, :title, :slug, :body, :created_at, :updated_at, :tag_list, :favorites_count)
json.author question.user, partial: 'profiles/profile', as: :user