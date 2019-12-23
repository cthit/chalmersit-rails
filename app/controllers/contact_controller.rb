class ContactController < ApplicationController
  def index
    @contact_committees = Committee.where slug: ["styrIT","NollKIT","DPO","snIT","Valberedningen","digIT"]
  end
end
