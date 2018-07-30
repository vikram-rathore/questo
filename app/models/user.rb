class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: { case_sensitive: false }, presence: true, allow_blank: false, format: { with: /\A[a-zA-Z0-9]+\z/ }

  has_many :questions, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :answers, dependent: :destroy

  acts_as_follower
  acts_as_followable

  def generate_jwt
    JWT.encode({ id: id,
              exp: 60.days.from_now.to_i },
             Rails.application.secrets.secret_key_base)
  end

  def favorite(question)
    favorites.find_or_create_by(question: question)
  end

  def unfavorite(question)
    favorites.where(question: question).destroy_all
    question.reload
  end

  def favorited?(question)
    favorites.find_by(question_id: question.id).present?
  end
  
end
