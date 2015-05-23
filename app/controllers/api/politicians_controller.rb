class Api::PoliticiansController < ApplicationController
	before_action :set_politician, only: [:show, :edit, :update, :destroy]

	def index
		@politicians = Politician.all
	end

  def show
  end

  def new
    @politician = Politician.new
  end

  def create
    @politician = Politician.new(politician_params)
    if @politician.save
      render :show, status: :created
    else
      render json: @politician.errors, status: :unprocessable_entity 
    end
  end

  def update
    if @politician.update(politician_params)
      render :show, status: :ok
    else
      render json: @politician.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @politician.destroy
    head :no_content
  end

  def search
    politicians = Politician::FilterLogic.search(
      query: { query_string: {
        query: "*#{params['query']}*"
      }}
    )
    render json: politicians, status: :ok
  end

  private
    def set_politician
      @politician = Politician.find(params[:id])
    end

    def politician_params
      params.require(:politician).permit(:name, :email, :position, :description, :role, :political_party, :image)
    end

end
