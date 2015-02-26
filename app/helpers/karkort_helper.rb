module KarkortHelper

  def balance(card)
    doc = Nokogiri::XML(open("http://kortladdning.chalmerskonferens.se/bgw.aspx?type=getCardAndArticles&card=#{card.card_number}"))
    id = doc.xpath('//CardInfo')[0]['id']
    card_value = doc.xpath('//ExtendedInfo[@Name="Kortvarde"]').text
    balance = card_value.split('_').map{ |v| (v.include?('x00') && "0#{v}".to_i(16).chr) || v }.join.sub(',', '.').to_f
    {"#{id}" => { balance: balance } }
  end
end
