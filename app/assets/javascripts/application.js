// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require bootstrap
//= require_tree .

let navObj
let sections

// ナビのクラス変更 バックグラウンド色変更
function navColorChange() {
	let navbg = document.getElementById("bg-chenge");

	if (navObj.offsetHeight + window.pageYOffset < sections[0].offsetHeight){
		navbg.classList.add("bg-transparent");
		navbg.classList.remove("bg-black");
	}else{
		navbg.classList.add("bg-black");
		navbg.classList.remove("bg-transparent");
	}
};

// イベント発火管理
function bindEvent(){
	window.addEventListener("scroll", event => navColorChange());
};

// DOMを変数に格納
function registerDOM() {
	navObj = document.getElementById('nav');
	sections = document.getElementsByTagName("section");
};

// イニシャライズ
function initialize() {
	registerDOM();
	bindEvent();
};

// DOM読み込み後にイニシャライズ
document.addEventListener("DOMContentLoaded", initialize.bind(this));