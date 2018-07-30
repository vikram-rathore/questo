json.(question, :title, :slug, :body, :created_at, :updated_at, :tag_list)
json.author question.user, partial: 'profiles/profile', as: :user
json.favorited signed_in? ? current_user.favorited?(question) : false
json.favorites_count question.favorites_count || 0