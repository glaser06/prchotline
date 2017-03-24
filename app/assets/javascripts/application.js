// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require_tree .
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require jquery_nested_form

// $(function(){ $(document).foundation(); });
// $(document).foundation();

$(function(){

  $(document).foundation();

  $(document).ready(function(){

      var _scroll = true, _timer = false, _floatbox = $("#contact_form"), _floatbox_opener = $(".contact-opener") ;
      _floatbox.css("right", "0px"); //initial contact form position

      //Contact form Opener button
      _floatbox_opener.click(function(){
          if (_floatbox.hasClass('visiable')){
              _floatbox.animate({"right":"0px"}, {duration: 300}).removeClass('visiable');
          } else{
             _floatbox.animate({"right":"-300px"},  {duration: 300}).addClass('visiable');
          }
      });

      //Effect on Scroll
      $(window).scroll(function(){
          if(_scroll){
              _floatbox.animate({"top": "0px"},{duration: 300});
              _scroll = false;
          }
          if(_timer !== false){ clearTimeout(_timer); }
              _timer = setTimeout(function(){_scroll = true;
              _floatbox.animate({"top": "3rem"},{easing: "linear"}, {duration: 500});}, 400);
      });
  });
});
