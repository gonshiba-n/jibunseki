let navObj
let sections

// ナビのクラス変更 バックグラウンド色変更
function navColorChange() {
  let navbg = document.getElementById("bg-chenge");

  if (navObj.offsetHeight + window.pageYOffset < sections[0].offsetHeight) {
    navbg.classList.add("bg-transparent");
    navbg.classList.remove("bg-black");
  } else {
    navbg.classList.add("bg-black");
    navbg.classList.remove("bg-transparent");
  }
};

// イベント発火管理
function bindEvent() {
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