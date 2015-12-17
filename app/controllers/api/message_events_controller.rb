class Api::MessageEventsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    MessageEvent.create(message_event_params)
    render :nothing => true
  end

  private

    def message_event_params
      params.permit(:recipient_id, :event)
    end
end
