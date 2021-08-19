function validate() {
    let rsl = true
    let atr = $('.form-control')
    for (let node of atr) {
        if (node.value === '' || node.value === null) {
            alert(node.getAttribute('title'));
            rsl = false
            break
        }
    }
    return rsl
}

function getTasks(userId, taskId) {
    let url
    let allTasks = false

    if (document.querySelector("input[name=select]:checked")) {
        allTasks = true
    }
    if (typeof taskId != "undefined") {
        url = 'http://localhost:8080/job4j_todo/task.do?allTasks=' + allTasks  + "&userId=" + userId + "&taskId=" + taskId
    } else {
        url = 'http://localhost:8080/job4j_todo/task.do?allTasks=' + allTasks  + "&userId=" + userId
    }

    $.ajax({
        type: 'GET',
        crossDomain : true,
        url: url,
        dataType: 'text',
    }).done(function(data) {
        let dt = JSON.parse(data)
        for (const [key, value] of Object.entries(dt)) {
            let tbody = document.querySelector('tbody')
            tbody.textContent = ''
            for (let i = 0; i < value.length; i++) {
                let tr = document.createElement('tr')
                let numb = document.createElement('td')
                numb.innerHTML = `${i + 1}`
                let desc = document.createElement('td')
                desc.innerHTML = `${value[i].description}`
                let author = document.createElement('td')
                author.innerHTML = `${value[i].user.name}`
                let done = document.createElement('td')
                let doneDiv = document.createElement('div')
                doneDiv.style.textAlign = "center"
                let doneInput = document.createElement('input')
                doneInput.type = "checkbox"
                doneInput.onclick = function() {getTasks(userId, this.id)}
                doneInput.id = value[i].id
                if (value[i].done) {
                    doneInput.setAttribute("checked", "checked")
                }
                doneDiv.appendChild(doneInput)
                done.appendChild(doneDiv)
                tr.appendChild(numb)
                tr.appendChild(desc)
                tr.appendChild(author)
                tr.appendChild(done)
                tbody.appendChild(tr)
            }
        }
    });
}
