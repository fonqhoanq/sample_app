class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @pagy, @feed_items = pagy current_user.feed, items: Settings.paginate.limit
  end

  def help; end

  def contact; end

  def about; end
end
