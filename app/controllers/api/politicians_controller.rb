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

    respond_to do |format|
      if @politician.save
        format.html { redirect_to @politician, notice: 'Politician was successfully created.' }
        format.json { render :show, status: :created, location: @politician }
      else
        format.html { render :new }
        format.json { render json: @politician.errors, status: :unprocessable_entity }
      end
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
    respond_to do |format|
      format.html { redirect_to politicians_url, notice: 'Politician was successfully destroyed.' }
      format.json { head :no_content }
    end
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
      params.require(:politician).permit(:name, :email, :position, :district, :political_party, :branch, :image)
    end

end
