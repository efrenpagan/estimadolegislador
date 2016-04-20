class MessagesController < ApplicationController
  before_action :set_message, only: [:show]

  def index
    render_view
  end

  def new
    render_view
  end

  def show
    @meta_tags_data = MessageLogic.meta_tags_data(@message)
    render_view
  end

  private
  def set_message
    @message ||= Message.find(params[:id])
  end

  def render_view
    render 'layouts/application.html.erb'
  end
end
