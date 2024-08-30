class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = current_user.contacts

    if params[:query].present?
      sql_subquery = <<~SQL
        contacts.full_name ILIKE :query
        OR contacts.email ILIKE :query
        OR contacts.nickname ILIKE :query
      SQL

      @contacts = @contacts.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def show
    @contact = current_user.contacts.find_by(id: params[:id])
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = current_user.contacts.new(contact_params)

    if @contact.save
      # Redirige a la página de show del nuevo contacto
      redirect_to contact_path(@contact), notice: 'Contacto creado con éxito.'
    else
      # Si el contacto no se guarda, renderiza el formulario de nuevo contacto
      flash.now[:alert] = 'No se pudo crear el contacto. Por favor, corrige los errores.'
      render :new
    end
  end

  def edit
    @contact = current_user.contacts.find(params[:id])
  end

  def update
    @contact = current_user.contacts.find(params[:id])
  if @contact.update(contact_params)
    redirect_to @contact, notice: 'Contacto actualizado con éxito.'
  else
    render :edit
  end
  end

  def destroy
    @contact = current_user.contacts.find_by(id: params[:id])

    if @contact
      @contact.destroy
      redirect_to contacts_url, notice: 'Contacto eliminado exitosamente.'
    else
      redirect_to contacts_url, alert: 'Contacto no encontrado o no tienes permiso para eliminarlo.'
    end
  rescue ActiveRecord::RecordNotDestroyed
    redirect_to contacts_url, alert: 'Hubo un problema al eliminar el contacto. Inténtalo de nuevo.'
  end

  private

  def set_contact
    @contact = current_user.contacts.find_by(id: params[:id])
  end

  def contact_params
    params.require(:contact).permit(:full_name, :nickname, :birthday, :photo,
                                    phone_numbers_attributes: [:id, :number, :emergency_number, :_destroy],
                                    address_attributes: [:id, :street, :city, :state, :country, :postal_code, :latitude, :longitude],
                                    category_attributes: [:id, :family, :friend, :customer, :supplier])
  end
end
