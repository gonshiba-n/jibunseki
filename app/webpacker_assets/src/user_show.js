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
    editSubmit,
    targetDeleteSubmit

// ==========wcm表示タグここから==========

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
// ==========wcm表示タグここまで==========

// ==========wcm編集セクションここから==========

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

// ==========wcm編集セクションここまで==========

// ==========wcmイベント発火ここから==========

// 表示セクション タグを条件分岐でイベント変更 data-branchをフラグとする
window.bindEvent = function () {
  let target = event.target
  wcmInitialize()
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
  wcmInitialize()
  deleteBtnToggle()
  deleteToggle()
  checkBoxToggle()
}

// 削除ボタン
window.deleteEnter = function () {
  wcmInitialize()
  resetEdit()
}

// 編集セクション タグのajax更新完了後に編集タグの置き換えを行うために時間遅延させた。別途仕様を考える
window.editEnter = function () {
  setTimeout('delayedConversion()', 300);
}
delayedConversion = function() {
  wcmInitialize()
  ConvertNewTag()
}

// modalのタブ表示
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

// ==========wcmイベント発火ここまで==========

// ==========target編集セクションここから==========

// 選択目標を編集項目へ反映する
function editTargetChange(editTarget) {
  if(editTarget.achieve === "goal"){
    goalInput.checked = true
  }else{
    unGoalInput.checked = true
  }
  targetId.value = editTarget.id
  targetTextField.value = editTarget.target_body
  deadlineDateField.value = editTarget.deadline.substr(0, 16)
  Array.from(periodOptions).filter(ele => ele.value === editTarget.period)[0].selected = true
  targetEditSubmit.disabled = false
}
// フォームのブランク化
function formBlank(){
  goalInput.checked = false
  unGoalInput.checked = false
  targetId.value = ""
  targetTextField.value = ""
  deadlineDateField.value = ""
  Array.from(periodOptions).filter(ele => ele.value === "long")[0].selected = true
  targetEditSubmit.disabled = true
}

// チェックボックのトグル
function targetCheckBoxToggle(displayTarget) {
  let checkBox = document.querySelectorAll(".target-checkbox-select")

  checkBox.forEach(function (t) {
    if (displayTarget.dataset.selector === "true") {
      t.classList.remove("d-none")
      t.checked = false
    } else {
      t.classList.add("d-none")
      t.checked = false
    }
  })
}

// ==========target編集セクションここまで==========

// ==========targetイベント発火ここから==========
// target編集発火
window.targetEvent = function() {
  let t = event.target
  console.log(t)
  let target = JSON.parse(document.getElementById(`${t.id}`).dataset.json)

  if (t.dataset.flag === "true"){
    targetInitialize()
    formBlank()
    t.dataset.flag = false
  }else{
    targetInitialize()
    editTargetChange(target)
    t.dataset.flag = true
  }
}

// 選択ボタントグル
window.targetSelect = function () {
  targetInitialize()
  let displayTarget = event.target

  if (displayTarget.dataset.selector === "false") {
    displayTarget.dataset.selector = "true"
    displayTarget.value = "解除"
    targetDeleteSubmit.classList.remove("d-none")
  } else {
    displayTarget.dataset.selector = "false"
    displayTarget.value = "選択"
    targetDeleteSubmit.classList.add("d-none")
  }

  targetCheckBoxToggle(displayTarget)
}
// ==========targetイベント発火ここまで==========

// ==========初期化ここから==========

function wcmInitialize() {
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

function targetInitialize() {
  targetId = document.getElementById("target_id")
  goalInput = document.getElementById("target_achieve_goal")
  unGoalInput = document.getElementById("target_achieve_un_goal")
  targetTextField = document.getElementById("target_target_body")
  startDateField = document.getElementById("target_start")
  deadlineDateField = document.getElementById("target_deadline")
  periodSelectBox = document.getElementById("target_period")
  periodOptions = document.querySelectorAll('#target_period option')
  targetEditSubmit = document.getElementById("target-edit-submit")
  targetDeleteSubmit = document.getElementById("target-delete-submit")
}

// ==========初期化ここまで==========