// グローバル変数定義
let tagContainer,
    tags,
    blankTagContainer,
    selectBtn,
    deleteBtn,
    blankTag,
    editTextArea,
    editTextField,
    hidden_field,
    editSubmit

// ==========表示タグセクションここから==========

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
// 選択ボタンの削除ボタン表示トグル
function deleteToggle() {
  if (selectBtn.dataset.display === "true") {
    deleteBtn.classList.remove("d-none")
  } else {
    deleteBtn.classList.add("d-none")
  }
}

// 削除後のリセット
function resetEdit() {
  blankTagContainer.innerHTML = '<button type="button" class="btn btn-secondary modal-btn" id="blank-tag">none</button>'
  editTextArea.value = ""
  editTextField.value = ""
  hidden_field.removeAttribute("value")
  editSubmit.disabled = true
  deleteBtn.classList.add("d-none")
  selectBtn.value = "選択"
}

// チェックボックスの表示トグル
function checkBoxToggle() {
  let checkBox = document.querySelectorAll(".checkbox-select")

  checkBox.forEach(function(t){
    if (selectBtn.dataset.display === "true"){
      t.classList.remove("d-none")
    }else{
      t.classList.add("d-none")
      t.checked = false
    }
  })
}
// ==========表示タグセクションここまで==========

// ==========編集セクションここから==========

// 選択タグを編集項目へ反映する
function tagChange(tag) {
  if (tag.dataset.flag === "true") {
    blankTagContainer.innerHTML = '<button type="button" class="btn btn-secondary modal-btn" id="blank-tag">none</button>'
    editTextArea.value = ""
    editTextField.value = ""
    tag.removeAttribute("data-flag")
    hidden_field.removeAttribute("value")
    editSubmit.disabled = true
  } else {
    hidden_field.value = `${Number(tag.id)}`
    blankTagContainer.innerHTML = `<button type="button" class="${tag.className}" id="${tag.id}">${tag.value}</button>`
    editTextArea.value = `${tag.dataset.question}`
    editTextField.value = `${tag.value}`
    tag.setAttribute("data-flag", true)
    editSubmit.disabled = false
  }
}

// 更新後のタグに編集部分のタグの表示を合わせる
function ConvertNewTag() {
  let noUpdatedTag = blankTagContainer.childNodes[0].id
  let updateTag = tags.namedItem(noUpdatedTag)
  if (noUpdatedTag === updateTag.id) {
    blankTagContainer.innerHTML = `<button type="button" class="${updateTag.className}" id="${updateTag.id}">${updateTag.value}</button>`
  }
}

// ==========編集セクションここまで==========

// ==========イベント発火ここから==========

// 表示セクション タグを条件分岐でイベント変更 data-branchをフラグとする
window.bindEvent = function () {
  let target = event.target
  initialize()
  if (target.dataset.branch === "select-tag-change") {
    return tagChange(target)
  }else{
    return checkBoxLink(target)
  }
}

// 選択ボタン トグル関連
window.selectDisplay = function () {
  let displayTarget = event.target
  if (displayTarget.dataset.display === "false"){
    displayTarget.dataset.display = "true"
    displayTarget.value = "解除"
  }else{
    displayTarget.dataset.display = "false"
    displayTarget.value = "選択"
  }
  initialize()
  deleteBtnToggle()
  deleteToggle()
  checkBoxToggle()
}

// 削除ボタン
window.deleteEnter = function () {
  initialize()
  resetEdit()
}

// 編集セクション タグのajax更新完了後に編集タグの置き換えを行うために時間遅延させた。別途仕様を考える
window.editEnter = function () {
  setTimeout('delayedConversion()', 300);
}
delayedConversion = function() {
  initialize()
  ConvertNewTag()
}

window.activeLink = function(wcm) {
  let will = document.getElementById("will-active")
  let can = document.getElementById("can-active")
  let must = document.getElementById("must-active")
  if (wcm === "will") {
    will.classList.add("active")
    can.classList.remove("active")
    must.classList.remove("active")
  }else if(wcm === "can"){
    will.classList.remove("active")
    can.classList.add("active")
    must.classList.remove("active")

  }else if(wcm === "must"){
    will.classList.remove("active")
    can.classList.remove("active")
    must.classList.add("active")
  }else{
    will.classList.add("active")
    can.classList.remove("active")
    must.classList.remove("active")
  }
}

// チェックボックスをラジオボタンのような振る舞いにした
window.checkJude = function () {
  let target = event.target
  let wcm = target.dataset.wcm
  let checkBoxs = document.querySelectorAll(`.${wcm}-check`)
  if (target.checked = true){
    checkBoxs.forEach(function (e){
      if (target != e){
      e.checked = false
      }
    })
  } else if (target.checked = false) {
    target.checked = true
  }
}

window.areaClear = function () {
  let area = document.getElementById("guideline-area")
  area.value = ""
}


// ==========イベント発火ここまで==========

// ==========初期化ここから==========

function initialize() {
  tagContainer = document.getElementById("tagContainer")
  tags = tagContainer.children
  selectBtn = document.getElementById("select-btn")
  deleteBtn = document.getElementById("delete-btn")
  blankTagContainer = document.getElementById("blank-tag-container")
  blankTag = document.getElementById("blank-tag")
  editTextArea = document.getElementById("edit-textarea")
  editTextField = document.getElementById("edit-textfield")
  hidden_field = document.getElementById("tag_id")
  editSubmit = document.getElementById("edit-submit")
}

// ==========初期化ここまで==========