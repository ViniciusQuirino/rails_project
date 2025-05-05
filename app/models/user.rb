class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and
  #
  # :omniauthable fazer autenticação usando facebook, google, etc
  #
  has_many :articles, dependent: :destroy # Se apagar o usuario todos os articles dele tbm será apagado
  has_many :comments, dependent: :destroy # Se apagar o usuario todos os comments dele tbm será apagado

  devise :database_authenticatable, # Autenticação via banco de dados (email/senha)
         :registerable,             # Permite cadastro de novos usuários (sign up)
         :recoverable,              # Recuperação de senha via email (esqueci minha senha)
         :rememberable,             # Mantém usuário logado com cookie (lembrar-me)
         :validatable,              # Validações padrão para email e senha (formato, length)
         :confirmable,              # Confirmação de conta por email (confirma seu email)
         :trackable                 # Rastreia info de login (IP, hora, quantos logins)

  validate :password_complexity

  private

  def password_complexity
    return if password.nil?

    errors.add :password, :complexity unless ChechPasswordComplexityService.call(password)
  end
end
