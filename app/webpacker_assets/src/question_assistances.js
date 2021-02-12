let flashClose,
    validateRefresh

// 次ページへ送る際のフラッシュクローズ
function closeFlash(){
  if (flashClose != null) {
    flashClose.click()
  }
}

function replaceValidatesMsg(){
  if (validateRefresh != null){
    Array.prototype.forEach.call(validateRefresh, function (elem) {
      elem.innerHTML = '<div class="create-js-message-errors"></div>'
    })
  }
}


//イベント発火

// ページ遷移(次)
window.nextDecision = function (e) {
  assistancesInitialize()
  closeFlash()
  replaceValidatesMsg()
}
// ページ遷移(前)
window.prevDecision = function (e) {
  assistancesInitialize()
  closeFlash()
  replaceValidatesMsg()
}

function assistancesInitialize(){
  flashClose = document.getElementById("close")
  validateRefresh = document.getElementsByClassName("validates")
}