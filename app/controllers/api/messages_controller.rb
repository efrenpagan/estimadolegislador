class Api::MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def index
    @messages = Message.order('created_at DESC')
  end

  def show
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def create
    message = Message.new(message_params)
    if message.valid?
      task_key = MessageLogic.send_message(message_params)
      render json: { task_key: task_key }, status: :ok
    else
      render json: message.errors, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:from_name, :from_email, :subject, :message_html, :is_public, :short_url, contact_ids: [])
    end
end
