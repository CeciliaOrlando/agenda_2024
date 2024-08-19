class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource) # Redirige al índice de contactos
    contacts_path
  end
end
