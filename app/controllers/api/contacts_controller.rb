class Api::ContactsController < ApplicationController
	before_action :set_contact, only: [:show, :edit, :update, :destroy]

	def index
    if params['ids'].present?
			ids = JSON.parse(params['ids'])
			if params['include_ids'] == "true" # Recipients
				@contacts = Contact.find(ids).index_by(&:id).slice(*ids).values
			else # Non Recipients
				@contacts = Contact.where.not(id: ids)
			end
    else
      @contacts = Contact.all
    end
	end

  def show
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render :show, status: :created
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def update
    if @contact.update(contact_params)
      render :show, status: :ok
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy
    head :no_content
  end

  def search
    @contacts = Contact::FilterLogic.search(params['query'], params['filtered_ids'])
    render :index, status: :ok
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:name, :email, :position, :description, :role, :political_party, :image)
    end

end
