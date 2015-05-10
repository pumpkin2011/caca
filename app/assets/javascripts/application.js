// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require semantic-ui
//= require 'china_city/jquery.china_city'
//= require qiniu
//= require plupload.full.min
//= require plupload.zh_CN
//= require qiniu_uploader
//= require jquery.themepunch.revolution
//= require jquery.themepunch.tools.min
//= require revo-slider-init


$(function(){
  $('.ui.dropdown').dropdown();
  $('.ui.checkbox').checkbox();
})
