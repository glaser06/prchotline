require 'csv'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #Connect to DropBox to download and retrieve password from the file credentials.csv
  client = DropboxApi::Client.new
  results = client.search("credentials.csv")
  if results.matches.count > 0
    path = results.matches.first.resource.path_lower
    file_contents = ""
    #Content is downloaded in chunks (Refer to the DropboxApi for more info)
    file = client.download(path) do |chunk|
      file_contents << chunk
    end
    #Content of this file is in the string format user,password
    contentArr = file_contents.split(',')
    user = contentArr[0]
    pass = contentArr[1]
    #Built-in Rails method for authentication
    http_basic_authenticate_with :name => user, :password => pass
  end

end
