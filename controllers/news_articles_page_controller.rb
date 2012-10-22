require_relative('../mixin/cacheable.rb')
require_relative 'news_page_controller.rb'

class NewsArticlesPageController < NewsPageController

  include Cacheable

  def run!
    article = cache(@id) { 
      article = Article.new(article_uri)
      @builder.build_news_article(article)

      article
    }
    page(:article,article)
  end

  private
  def article_uri
    Application.config['article_base_path'] + @id.to_s
  end

end
