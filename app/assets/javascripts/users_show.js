// グローバル変数
let tags, selectDeleteBtn, blankTag, editTextArea, editTextField;
let tag;


// function registerDOM(){
  tags = document.querySelectorAll(".show-btn")
//   selectDeleteBtn = document.getElementById("select-delete")
//   blankTag = document.getElementById("blank-tag")
// }

// // イベント発火管理
// // クリックされたタグの取得
// function bindEvent() {
//   tags.forEach(tag => {
//     tag.addEventListener("click", function (e) {
//       tag = [].slice.call(tags).indexOf(tag);
//     });
//   });

// };

// // DOM読み込み後にイニシャライズ
// document.addEventListener("turbolinks:load", initialize.bind(this));

// // イニシャライズ
// function initialize() {
//   registerDOM();
//   bindEvent();
// };

$(function(){
  tags.forEach(tag => {
    tag.addEventListener("click", function (e) {
      tag = [].slice.call(tags).indexOf(tag);
      console.log(tags[tag])
    });
  });
})