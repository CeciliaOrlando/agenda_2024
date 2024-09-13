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
  end

  def new
    @contact = current_user.contacts.build
  end

  def create
    @contact = current_user.contacts.build(contact_params)
    if @contact.save
      redirect_to @contact, notice: 'Contacto creado correctamente.'
    else
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
    params.require(:contact).permit(:full_name, :nickname, :birthday, :email, photos: [],
      phone_numbers_attributes: [:id, :number, :emergency_number, :_destroy],
      address_attributes: [:id, :street, :city, :state, :country, :postal_code, :latitude, :longitude],
      category_attributes: [:id, :family, :friend, :customer, :supplier]
    )
  end
end
