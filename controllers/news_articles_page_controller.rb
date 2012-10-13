require_relative 'news_page_controller.rb'

class NewsArticlesPageController < NewsPageController

  def run!
    article = Article.new(article_uri)
    @builder.build_news_article(article)
    page(:article,article)
  end

  private
  def article_uri
    Application.config['article_base_path'] + @id.to_s
  end

end
