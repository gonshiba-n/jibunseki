// グローバル 変数として定義
let tagContainer,
    tags,
    blankTag,
    blankTagContainer,
    editTextArea,
    editTextField,
    hidden_field,
    editSubmit,
    selectBtn


// 選択タグを編集項目へ反映する
function selectTagChange(tag) {
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
// 更新後のタグに編集部分のタグの表示を合わせる
function ConvertNewTag () {
  let tag = blankTagContainer.childNodes[0].id
  let targetTag = tags.namedItem(tag);
  if (tag === targetTag.id){
    blankTagContainer.innerHTML = `<button type="button" class="${targetTag.className}" id="${targetTag.id}">${targetTag.value}</button>`
  }
}

// チェックボックスとボタンをリンクしてトグル化
function checkBoxLink(tag) {
  let checkBox = document.getElementById(`checkbox${tag.id}`)
  if (checkBox.checked) {
    checkBox.checked = false
  }else{
    checkBox.checked = true
  }
}

// data属性によるメソッドの分岐と削除ボタンのトグル
function deleteBtnToggle() {
  tags = document.querySelectorAll(".show-btn")

  tags.forEach(function (t) {
    if (selectBtn.dataset.display === "true") {
      t.dataset.branch = "select-display"
    } else {
      t.dataset.branch = "select-tag-change"
    }
  })
}

function deleteToggle() {
  let deleteTagsBtn = document.getElementById("deleteTagsBtn")

  if (selectBtn.dataset.display === "true") {
    deleteTagsBtn.classList.remove("d-none")
  } else {
    deleteTagsBtn.classList.add("d-none")
    }
}

function checkBoxToggle() {
  let checkBox = document.querySelectorAll(".checkbox-select")
  checkBox.forEach(function(t){
    if (selectBtn.dataset.display === "true"){
      t.classList.remove("d-none")
    }else{
      t.classList.add("d-none")
    }
  })
}

// イベント発火ここから

// タグを条件分岐でイベント変更 data-branchをフラグとする
window.bindEvent = function () {
  let tag = event.target
  initialize()
  if (tag.dataset.branch === "select-tag-change") {
    return selectTagChange(tag)
  }else{
    return checkBoxLink(tag)
  }
}

// data-branch変更

window.selectDisplay = function () {
  target = event.target
  if(target.dataset.display === "false"){
    target.dataset.display = "true"
  }else{
    target.dataset.display = "false"
  }
  initialize()
  deleteBtnToggle()
  deleteToggle()
  checkBoxToggle()
}
// タグのajax更新完了後に編集タグの置き換えを行うために時間遅延させた。別途仕様を考える
window.editEnter = function () {
  setTimeout('delayedConversion();', 300);
}
delayedConversion = function() {
  initialize()
  ConvertNewTag()
}
// イベント発火ここまで




// DOM要素を変数に格納
function registerDOM() {
  tagContainer = document.getElementById("tagContainer")
  tags = tagContainer.children
  blankTag = document.getElementById("blank-tag");
  blankTagContainer = document.getElementById("blank-tag-container")
  editTextArea = document.getElementById("edit-textarea")
  editTextField = document.getElementById("edit-textfield")
  hidden_field = document.getElementById("tag_id")
  editSubmit = document.getElementById("edit-submit")
  selectBtn = document.getElementById("select-delete")
}

// 初期化
function initialize() {
  registerDOM()
}
