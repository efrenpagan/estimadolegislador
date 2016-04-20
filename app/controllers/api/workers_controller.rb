class Api::WorkersController < ApplicationController
  def show
    result = MailerWorker.status(params[:id])
    if result.nil?
      render json: result, status: :unprocessable_entity
    else
      render json: result, status: :ok
    end
  end
end
