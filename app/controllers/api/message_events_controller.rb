class Api::MessageEventsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    MessageEvent.create(message_event_params)
    render :nothing => true
  end

  private

    def message_event_params
      params.permit(_json: [:recipient_id, :event])[:_json]
    end
end
