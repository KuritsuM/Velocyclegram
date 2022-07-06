class PostMediaPresenter
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::AssetTagHelper

  def initialize(post)
    @post = post
  end

  def make_tag
    if @post.image.video?
      video_tag(rails_blob_path(@post.image, only_path: true), controls: true)
    elsif @post.image.image?
      image_tag(rails_blob_path(@post.image, only_path: true))
    else
      "<span>Error happens...</span>"
    end
  end

  def make_presentation
    #binding.pry
    if @post.image.previewable?
      image_tag(rails_representation_url(@post.image.preview(resize: "100%").processed,  only_path: true))
    else
      image_tag(rails_blob_path(@post.image, only_path: true))
    end
  end
end