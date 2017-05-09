class SettingsController < ApplicationController

#Changing password
  def change
    #Checks that a username and password have been inputted into form
    if params[:user] and params[:password]
      #Connects to DropboxApi to upload a new file, credentials.csv, with user and password written in
      client = DropboxApi::Client.new
      file_content = "#{params[:user]},#{params[:password]}"
      client.upload "/credentials.csv", file_content, :mode => :overwrite
      redirect_to settings_path, notice: 'Password settings were successfully updated.'
    end
  end

end
