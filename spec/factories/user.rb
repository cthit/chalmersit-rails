FactoryGirl.define do
  factory :user do
    uid "smurf"
    full_name "Smurf Smursson"
    nickname "Smurfen"
    mail "smurf@chalmers.it"
    acceptedUserAgreement true
    preferredLanguage "sv"
    admissionYear "2001"
    display_name "Smurf 'Smurfen' Smursson"
    admin false

    factory :admin_user do
      admin true
    end
  end
end
