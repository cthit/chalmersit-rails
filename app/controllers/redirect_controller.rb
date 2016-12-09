class RedirectController < ApplicationController
  def findit
    redirect_to "https://findit.chalmers.it"
  end
  def courses
    redirect_to "https://wikit.chalmers.it/wiki/Kurser"
  end
end
