# -*- encoding : utf-8 -*-
module SroHelper
  def print_status(sro)
    puts sro.schvalene
    if !sro.schvalene
      return "Očakáva schválenie (je možné upraviť kroky a odstrániť spoločnosť)"
    else
      return "Schválené, spoločnosť registrovaná"
    end
  end
end
