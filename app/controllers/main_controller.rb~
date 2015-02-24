# -*- encoding : utf-8 -*-
require 'digest/sha1'

class MainController < ApplicationController
  
  before_filter :logged_in, :only => [:index, :show_prof, :edit_prof, :cr_prof, :del_prof, :logout]
  before_filter :not_logged, :only => [:welcome, :login, :register]
  
  def index
    # uvodna domovska stranka render
  end
  
  def welcome
    @sidebar = "<li>Pred používaním sa prihláste</li>"
    # uvodna stranka
  end
  
  def show_prof
    @sidebar = "<li>Vyplnený profil bude použitý na autodopĺňanie osobných údajov</li>"
    @profil = Profil.find_by_user_id session[:user_id]
  end

  def edit_prof
    @profil = Profil.find_by_user_id session[:user_id]
  end

  def cr_prof
    @profil = Profil.new 
  end
  
  # vytvorenie profilu, post metoda
  def create_profile
    @profil = Profil.new(profil_params)
    @profil.user_id = session[:user_id]
    if @profil.save
      flash[:notice] = "Profil vytvorený."
      flash[:cr_prof]= "valid"
    else
      flash[:notice] = "Nevytvorený. Formulár nie je validný, prosím opravte chyby."
      flash[:cr_prof]= "invalid"
    end
    render "cr_prof"
  end

  # vymazanie profilu, post metoda
  def delete_prof
    profil = Profil.find_by_user_id session[:user_id]
    if profil.destroy
      flash[:notice] = "Profil vymazaný."
      flash[:edited]= "valid"
    end
    redirect_to(:action => 'show_prof')
  end
  
  #zmena profilu, patch metoda
  def action_edit_prof
    profil = Profil.find_by_user_id session[:user_id]
    if profil.update_attributes(profil_params)
      flash[:notice] = "Profil zmenený."
      flash[:edited]= "valid"
    else
      flash[:notice] = "Chyba formulára. Profil nezmenený."
      flash[:edited]= "invalid"
    end
    redirect_to(:action => 'show_prof')
  end

  # vyrenderovanie noveho pouzivatela, aj formular
  def register
    @sidebar = "<li>minimálny počet znakov hesla je 6</li>" +
               "<li>minimálny počet znakov používateľského mena je 3</li>" +
               "<li>meno aj email musia byť unikátne</li>"
    @user = User.new
  end
  
  # vytvorenie uzivatela, formularova post metoda
  def cr_acc
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Úspešne ste sa zaregistrovali."
      flash[:register]= "valid"
    else
      flash[:notice] = "Formulár nie je validný. Prosím opravte chyby na základe kontroly."
      flash[:register]= "invalid"
    end
    render "register"
  end
  
  # editovanie emailu pouzivatela, post metoda
  def edit_user_email
    user = User.find(session[:user_id])
    if user.update(email: params[:user][:email])
      flash[:notice] = "E-mail zmenený na " + params[:user][:email]
      flash[:edited]= "valid"
    else
      flash[:notice] = "Email nie je validný."
      flash[:edited]= "invalid"
    end
    redirect_to(:action => 'show_prof')
  end

  # editovanie hesla pouzivatela, post metoda
  def edit_user_pass
    user = User.find(session[:user_id])
    auth_user = User.auth(user.login,params[:user][:old_pass])
    if user.update(pass: params[:user][:pass]) && auth_user
      flash[:notice] = "Heslo zmenené."
      flash[:edited]= "valid"
    else
      flash[:notice] = "Nesprávne zadané heslo."
      flash[:edited]= "invalid"
    end
    redirect_to(:action => 'show_prof')
  end

  # renderovanie prihlasenia
  def login
    @sidebar = "<li>skontrolujte si malé a veľké písmena</li>"
    # formular prihlasenia
  end
  
  # prihlasenie, post metoda formulara
  def action_login
    auth_user = User.auth(params[:user_or_email],params[:prov_pass])
    if auth_user
      session[:user_id] = auth_user.id
      flash[:notice] = "Boli ste úspešne prihlásený ako #{auth_user.login}."
      flash[:logged]= "valid"
      redirect_to(:action => 'index')
    else
      flash[:notice] = "Nesprávne meno alebo heslo."
      flash[:logged]= "invalid"
      render "login"
    end
  end
  
  # odhlasenie
  def logout
    session[:user_id] = nil
    redirect_to(:action => 'welcome')
  end
  
  # zapuzdrenie parametrov, nepripustnost ziadnych inych, bezpecnostna polozka znama v Rails4
  private
  def user_params    
    params.require(:user).permit(:login, :pass, :pass_confirmation, :email)
  end
  def profil_params
    params.require(:profil).permit(:t_pred, :t_za, :meno, :priez, :ulica, :cislo, :obec, :psc, :stat)
  end
end
