# -*- encoding : utf-8 -*-
class PeopleController < ApplicationController
  
  # delete metoda, odpoveda len na javascript a javascriptom, AJAX
  def destroy
    @sro = Sro.find(params[:sro_id])
    @person = Person.find(params[:id])
    case @person.typ
      when 1
        @all_asso = @sro.people.where(:typ => 1)
      when 2
        @all_mdir = @sro.people.where(:typ => 2)
      when 3
        @all_sup = @sro.people.where(:typ => 2)
    end
    @person.destroy
    respond_to do |format|
      format.js
    end
  end

  # create metoda, podobna ako delete
  def create
    @sro = Sro.find(params[:person][:sro_id])
    case params[:person][:typ].to_i
      when 1
        @all_asso = @sro.people.where(:typ => 1)
      when 2
        @all_mdir = @sro.people.where(:typ => 2)
      when 3
        @all_sup = @sro.people.where(:typ => 2)
    end
    @person = Person.new(person_params)
    case params[:person][:typ].to_i
      when 1
        @person.typ = 1
      when 2
        @person.typ = 2
      when 3
        @person.typ = 3
    end
    @person.sro_id = @sro.id
    @person.funkcia_od = Time.now
    @person.save
    respond_to do |format|
      format.js
    end
  end
  
  def person_params
    params.require(:person).permit(:id, :ulica, :cislo, :obec, :psc, :stat, :t_pred, :meno, :priez, :t_za, :vklad, :splatene, :sro_id, :sposob, :rc, :dat_nar, :typ)
  end
  
end
