module ApplicationHelper
  def facebook_meta_tags
    tags = []
    tags << tag('meta', :property => 'og:url', :content => url)
    tags << tag('meta', :property => 'og:title', :content => title)
    tags << tag('meta', :property => 'og:type', :content => type("facebook"))
    tags << tag('meta', :property => 'og:description', :content => description)
    tags << tag('meta', :property => 'og:image', :content => image)
    tags << tag('meta', :property => 'og:site_name', :content => title)
    tags.join.html_safe
  end

  def twitter_meta_tags
    tags = []
    tags << tag('meta', :name => 'twitter:card', :content => type("twitter"))
    tags << tag('meta', :name => 'twitter:site', :content => ENV['twitter_id'])
    tags << tag('meta', :name => 'twitter:title', :content => title)
    tags << tag('meta', :name => 'twitter:description', :content => description)
    tags << tag('meta', :name => 'twitter:image', :content => image)
    tags.join.html_safe
  end

  def url
    @meta_tags_data.try(:[], :url) || root_url(host: Global.config.domain)
  end

  def title
    @meta_tags_data.try(:[], :title) || "atentamente.org"
  end

  def type(social_platform)
    case social_platform
    when "facebook"
      @meta_tags_data.try(:[], :type) || "website"
    when "twitter"
      "summary"
    end
  end

  def description
    @meta_tags_data.try(:[], :description) || "Comunicate con tus funcionarios públicos de manera rápida y efectiva."
  end

  def image
    asset_url("assets/images/site/att_logo.png", host: Global.config.domain)
  end

end
