let tags
let blankTag
let blankTagContainer
let editTextArea
let editTextField
let hidden_field
let editSubmit
let count = 0

// イベント管理
function bindEvent() {
  tags.forEach(function(tag) {
    tag.addEventListener("click", event => selectTagChange(tag));
  });
};

function selectTagChange(tag) {
  // 選択タグを編集項目へ反映
  if (tag.dataset.flag === "true") {
    blankTagContainer.innerHTML = '<button type="button" class="btn btn-secondary modal-btn" id="blank-tag">none</button>'
    editTextArea.value = ""
    editTextField.value = ""
    tag.removeAttribute("data-flag")
    hidden_field.removeAttribute("value")
    editSubmit.disabled = true
  }else{
    hidden_field.value = `${Number(tag.id)}`
    blankTagContainer.innerHTML = `<button type="button" class="${tag.className}" id="${tag.id}">${tag.value}</button>`
    editTextArea.value = `${tag.dataset.question}`
    editTextField.value = `${tag.value}`
    tag.setAttribute("data-flag", true)
    editSubmit.disabled = false
  }
}

// DOM要素を変数に格納
function registerDOM() {
  tags = document.querySelectorAll(".show-btn");
  blankTag = document.getElementById("blank-tag");
  blankTagContainer = document.getElementById("blank-tag-container")
  editTextArea = document.getElementById("edit-textarea")
  editTextField = document.getElementById("edit-textfield")
  hidden_field = document.getElementById("tag_id")
  editSubmit = document.getElementById("edit-submit")
}

// 初期化
function initialize() {
  registerDOM()
  bindEvent()
}

// DOM読み込み後にイニシャライズ
document.addEventListener('turbolinks:load', function () {
  initialize()
  console.log("a")
})