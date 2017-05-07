

# PRC Hotline Web App

This is the Pennsylvania Resources Council hotline web app, made with Ruby on Rails.



## Prerequisites

To run this application, you need a Dropbox API key. The easiest way to obtain an access token is to get it from the Dropbox website. Visit https://www.dropbox.com/developers

After you log in, go to My Apps and select your application, or create one if you haven't done so yet.
DO NOT SHARE THIS KEY WITH ANYONE ELSE


## Installing

To install, download and unzip the repository onto a local folder.

In terminal, do

```
cd path/to/local/folder
```
And run
```
bundle install
```

Before running the application, you need to set the Dropbox API key. In the same window/tab, run

```
export DROPBOX_OAUTH_BEARER="YOUR_API_KEY_HERE"
```
and then optionally, run

```
source ~/.bashrc
```

To run the server, do
```
rails server
```

## Built With

* [Foundation](http://foundation.zurb.com/sites/docs/) - The design framework used
* [Datatables](https://datatables.net/) - Used for displaying Rails ActiveRecord tables



## Authors

* **Rebecca Kern** - [RebeccaKern](https://github.com/RebeccaKern)
* **Sai Dhulipalla** - [dsai96](https://github.com/dsai96)
* **Gerry Zhou** - [glaser06](https://github.com/glaser06)


## Acknowledgments

* Something here?
