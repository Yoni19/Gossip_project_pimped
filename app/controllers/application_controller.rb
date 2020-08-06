class ApplicationController < ActionController::Base
    include SessionsHelper

    def authenticate_user
      unless current_user
        flash[:danger] = "Eh ouais, tu ne peux rien faire si t'as pas de compte chez nous... C'est la dure loi de la data"
        redirect_to new_session_path
      end
    end
end
