class TagsController < ApplicationController
  def index
    render json: { tags: Question.tag_counts.most_used.map(&:name) }
  end
end