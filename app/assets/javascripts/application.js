// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.jcrop
//= require jquery_ujs
//= require foundation/foundation
//= require foundation/foundation.tooltip
//= require foundation/foundation.alert
//= require foundation/foundation.reveal
//= require foundation/foundation.tab
//= require jquery-fileupload/basic
//= require chosen-jquery
//= require moment
//= require moment/sv.js
//= require_tree .
//= require clipboard.js

$(function() {
  $(document).foundation();

  var $menu = $("#site-menu");

  $("#main-nav-toggle").on("click", function() {
    $menu.toggle();
  });
});
