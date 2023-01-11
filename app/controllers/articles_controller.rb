class ArticlesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = "Article created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.page(params[:page])
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

    def article_params
      params.require(:article).permit(:content, :title)
    end
end

