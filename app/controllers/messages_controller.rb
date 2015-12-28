class MessagesController < ApplicationController
  def show
    @meta_tags_data = MessageLogic.meta_tags_data(Message.find(params[:id]))
    render 'layouts/application.html.erb'
  end
end
