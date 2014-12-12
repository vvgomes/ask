module ApplicationHelper
  def popular_tags
    @popular_tags ||= ActsAsTaggableOn::Tag.most_used(10)
  end
end
