require 'capybara'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist_debug do |app|
  Capybara::Poltergeist::Driver.new(app, :inspector => true, :js_errors => false)
end

class StudentUnionCardBalance
  include Capybara::DSL

  CARD_BALANCE_URL = "http://kortladdning3.chalmerskonferens.se/"

  def initialize
    Capybara.default_driver = :poltergeist_debug
  end

  def student_union_card_balance(number)
    visit CARD_BALANCE_URL
    begin
      fill_in 'txtCardNumber', with: "#{number}"
      click_button('btnNext')
    rescue Capybara::ElementNotFound
      raise "Failed to submit number."
    end

    sleep 0.5
    begin
      [find(:id, 'txtPTMCardValue').text, find(:id, 'txtPTMCardName').text]
    rescue Capybara::ElementNotFound => e
      raise "error, saved page to app root, #{e.message}"
    end
  end

end
