let tags
let blankTag

// イベント管理
function bindEvent() {
  tags.forEach(function(tag) {
    tag.addEventListener("click", event => selectTagChange(tag));
  });
};

function selectTagChange(tag) {
  // 要素の取得
  let blankTagContainer = document.getElementById("blank-tag-container")
  let editTextArea = document.getElementById("edit-textarea")
  let editTextField = document.getElementById("edit-textfield")

  // 選択タグを編集項目へ反映
  if (tag.dataset.flag === "true") {
    blankTagContainer.innerHTML = '<button type="button" class="btn btn-secondary modal-btn" id="blank-tag">none</button>'
    editTextArea.value = ""
    editTextField.value = ""
    tag.removeAttribute("data-flag");
  }else{
    blankTagContainer.innerHTML = `<button type="button" class="${tag.className}" id="${tag.id}">${tag.value}</button>`
    editTextArea.value = `${tag.dataset.question}`
    editTextField.value = `${tag.value}`
    tag.setAttribute("data-flag", true);
  }
}


// DOM要素を変数に格納
function registerDOM() {
  tags = document.querySelectorAll(".show-btn");
  blankTag = document.getElementById("blank-tag");
}

// 初期化
function initialize() {
  registerDOM()
  bindEvent()
}

// DOM読み込み後にイニシャライズ
document.addEventListener("DOMContentLoaded", initialize.bind(this));

// 要素にデータ属性（カウント）を付与
// カウントが１以上ならnoneに変更