class SettingsController < ApplicationController

<<<<<<< e57fc59f082d63c6cd41106aba9376f818b263ef

=======
>>>>>>> password changes, needs DropBox Auth
  def change
    puts "change"
    client = DropboxApi::Client.new
    file_content = params[:user], params[:password]
    client.upload "credentials.csv", file_content, :mode => :overwrite
    redirect_to settings_path
  end

  def downloadPRC
  send_file("PRCcall_stats.csv", type: "text/csv", disposition: "attachment")
  end

end
