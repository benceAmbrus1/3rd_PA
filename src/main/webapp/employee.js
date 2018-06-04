function createSubList(resp){
    const ulEL = document.createElement("ul");

    for(let i=0; resp.length > i; i++){
        const sub = resp[i];
        const liEl = document.createElement("li");
        liEl.textContent = sub.fName + " " + sub.lName

        ulEL.appendChild(liEl);
    }

    return ulEL;
}

function onSubordinatesResponse(){
    showContents(["subordinates-content", "goBack-content"]);
    const subDivEl = document.getElementById("subordinates-content");
    const resp = JSON.parse(this.responseText);
    while(subDivEl.firstChild){
        subDivEl.removeChild(subDivEl.firstChild);
    }
    subDivEl.appendChild(createSubList(resp));
}

function onSubordinatesButtonClicked(){
    const xhr = new XMLHttpRequest();
    xhr.addEventListener("load", onSubordinatesResponse)
    xhr.open('POST', 'subordinatesServlet');
    xhr.send();
}

function createTerrTable(resp){
    tableEL = document.createElement('table');

    headerEl = document.createElement("tr");

    terr1thEL = document.createElement("th");
    terr1thEL.textContent = "Territories ID"
    terr2thEL = document.createElement("th");
    terr2thEL.textContent = "Territories Desc";
    terr3thEL = document.createElement("th");
    terr3thEL.textContent = "Region ID"
    terr4thEL = document.createElement("th");
    terr4thEL.textContent = "Region Desc";

    headerEl.appendChild(terr1thEL);
    headerEl.appendChild(terr2thEL);
    headerEl.appendChild(terr3thEL);
    headerEl.appendChild(terr4thEL);

    tableEL.appendChild(headerEl);

    for(let i=0; resp.length > i; i++){
        rowEl = document.createElement("tr");
        const response = resp[i];

        const tdTerrIdEl = document.createElement("td");
        tdTerrIdEl.textContent = response.id;
        const tdTerrDescEl = document.createElement("td");
        tdTerrDescEl.textContent = response.terrDesc;
        const tdRegIdEl = document.createElement("td");
        tdRegIdEl.textContent = response.regId;
        const tdRegDescEl = document.createElement("td");
        tdRegDescEl.textContent = response.regDesc;

        rowEl.appendChild(tdTerrIdEl);
        rowEl.appendChild(tdTerrDescEl);
        rowEl.appendChild(tdRegIdEl);
        rowEl.appendChild(tdRegDescEl);

        tableEL.appendChild(rowEl)
    }
    return tableEL;
}

function onTerritoriesResponse(){
    showContents(["territories-content", "goBack-content"]);
    const terrTableEl = document.getElementById("territories-content");
    const resp = JSON.parse(this.responseText);
    while(terrTableEl.firstChild){
        terrTableEl.removeChild(terrTableEl.firstChild);
    }
    terrTableEl.appendChild(createTerrTable(resp));
}

function onTerritoriesButtonClicked (){
    const xhr = new XMLHttpRequest();
    xhr.addEventListener("load", onTerritoriesResponse)
    xhr.open('POST', 'territoriesServlet');
    xhr.send();
}

function onLoad() {
    showContents(["terr-button-content","sub-button-content", "employee-content", "logout-content"]);

    const terrButtonEl = document.getElementById('territories-button');
    terrButtonEl.addEventListener('click', onTerritoriesButtonClicked);

    const subButtonEl = document.getElementById('subordinates-button');
    subButtonEl.addEventListener('click', onSubordinatesButtonClicked);

    const goBackButtonEl = document.getElementById('goBack-button');
    goBackButtonEl.addEventListener('click', onGoBackClicked);

    const logoutButtonEl = document.getElementById('logout-button');
    logoutButtonEl.addEventListener('click', onLogoutButtonClicked);
}

document.addEventListener('DOMContentLoaded', onLoad);
