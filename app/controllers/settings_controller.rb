class SettingsController < ApplicationController


  def index
    puts "index method"

  end

  def downloadPRC
  send_file("PRCcall_stats.csv", type: "text/csv", disposition: "attachment")

    # redirect_to "/"
  end

end
