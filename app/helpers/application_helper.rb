module ApplicationHelper
  def facebook_meta_tags
    tags = []
    tags << tag('meta', :property => 'og:url', :content => url)
    tags << tag('meta', :property => 'og:title', :content => title)
    tags << tag('meta', :property => 'og:type', :content => type)
    tags << tag('meta', :property => 'og:description', :content => description)
    tags << tag('meta', :property => 'og:image', :content => image)
    tags.join.html_safe
  end

  def url
    @meta_tags_data.try(:[], :url) || root_url(host: Global.config.domain)
  end

  def title
    @meta_tags_data.try(:[], :title) || "Mensajería directa"
  end

  def type
    @meta_tags_data.try(:[], :type) || "website"
  end

  def description
    @meta_tags_data.try(:[], :description) || "Comunicate con tus funcionarios públicos de manera rápida y efectiva."
  end

  def image
    asset_url("assets/images/site/att_logo.png", host: Global.config.domain)
  end

end
