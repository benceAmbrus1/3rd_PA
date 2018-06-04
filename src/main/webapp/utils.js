function onLogoutButtonClicked(){
    const xhr = new XMLHttpRequest();
    xhr.open('POST', 'logoutServlet');
    xhr.send();
}

function showContents(ids) {
    const contentEls = document.getElementsByClassName('content');
    for (let i = 0; i < contentEls.length; i++) {
        const contentEl = contentEls[i];
        if (ids.includes(contentEl.id)) {
            contentEl.classList.remove('hidden');
        } else {
            contentEl.classList.add('hidden');
        }
    }
}

function onGoBackClicked(){
    showContents(["terr-button-content","sub-button-content", "employee-content", "logout-content"]);
}
