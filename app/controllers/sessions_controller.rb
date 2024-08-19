class SessionsController < ApplicationController
  def new
      end

      def create
        email = params[:email]
        password = params[:password]
        # Lógica para autenticar al usuario
        # Por ejemplo, usando Devise:
        user = User.find_for_database_authentication(email: email)
        if user&.valid_password?(password)
          sign_in(user)
          redirect_to root_path, notice: 'Inicio de sesión exitoso'
        else
          flash.now[:alert] = 'Correo electrónico o contraseña inválidos'
          render :new
        end
      end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Has cerrado sesión.'
  end
end
