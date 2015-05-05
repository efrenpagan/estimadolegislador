class Api::LegislatorsController < ApplicationController
	before_action :set_legislator, only: [:show, :edit, :update, :destroy]

	def index
		@legislators = Legislator.all
	end

  def show
  end

  def new
    @legislator = Legislator.new
  end

  def create
    @legislator = Legislator.new(legislator_params)

    respond_to do |format|
      if @legislator.save
        format.html { redirect_to @legislator, notice: 'Legislator was successfully created.' }
        format.json { render :show, status: :created, location: @legislator }
      else
        format.html { render :new }
        format.json { render json: @legislator.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @legislator.update(legislator_params)
      render :show, status: :ok
    else
      render json: @legislator.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @legislator.destroy
    respond_to do |format|
      format.html { redirect_to yolos_url, notice: 'Legislator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    render json: Legislator.all, status: :ok
  end

  private
    def set_legislator
      @legislator = Legislator.find(params[:id])
    end

    def legislator_params
      params.require(:legislator).permit(:name, :email, :position, :district, :political_party, :branch, :image)
    end

end
