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
    # @contact is already set by set_contact
    # @flat = contact_address.find_by(contact_id: @contact.id)
    @flat = @contact.contact_address
    # The `geocoded` scope filters only flats with coordinates
    @markers = [
      {
        lat: @flat.latitude,
        lng: @flat.longitude
      }
    ]
  end

  def new
    @contact = current_user.contacts.build
    @contact.build_contact_address
  end

  def create
    @contact = current_user.contacts.build(contact_params)

    puts contact_params.inspect

    # Verifica que contact_address_attributes sea un Hash
    if contact_params[:contact_address_attributes].is_a?(Hash)
      contact_address = ContactAddress.new(contact_params[:contact_address_attributes])
    else
      # Maneja el error de manera apropiada, por ejemplo, estableciendo un mensaje de error
      flash[:error] = "Dirección de contacto no válida."
      render :new and return
    end

    if @contact.save && contact_address.save
      # Redirige o muestra un mensaje de éxito
    else
      # Maneja los errores, por ejemplo, renderizando el formulario de nuevo
      render :new
    end
  end


  def edit
    # @contact is already set by set_contact
  end

  def update
    if @contact.update(contact_params)
      redirect_to @contact, notice: 'Contacto actualizado con éxito.'
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contacto eliminado correctamente.' }
      format.json { head :no_content }
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to contacts_path, alert: 'Hubo un problema al eliminar el contacto. Inténtalo de nuevo.'
  end

  private

  def set_contact
    @contact = current_user.contacts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to contacts_path, alert: 'Contacto no encontrado.'
  end

  def contact_params
    params.require(:contact).permit(:full_name,
      :nickname,
      :email,
      :birthday,
      :contact_phone,
      contact_address_attributes: [:street, :city, :state, :country, :postal_code]
    )
  end

end
