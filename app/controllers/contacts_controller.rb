class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact.all
    @contacts = if params[:search].present?
      Contact.where('name LIKE ?', "%#{params[:search]}%")
    else
      Contact.all
    end
  end

  def show
    @contact = Contact.find(contact_params[:id]) if @contact.nil?
  end

  def new
    @contact = current_user.contacts.new
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
    if @contact.update(contact_params)
      redirect_to @contact, notice: 'Contacto actualizado exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_url, notice: 'Contacto eliminado exitosamente.'
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:full_name, :nickname, :birthday, :photo,
                                    phone_numbers_attributes: [:id, :number, :emergency_number, :_destroy],
                                    address_attributes: [:id, :street, :city, :state, :country, :postal_code, :latitude, :longitude],
                                    category_attributes: [:id, :family, :friend, :customer, :supplier])
  end
end
