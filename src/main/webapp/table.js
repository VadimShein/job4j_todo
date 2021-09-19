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

function getTasks(userId) {
    let allTasks = false

    if (document.querySelector("input[name=select]:checked")) {
        allTasks = true
    }
    $.ajax({
        type: 'GET',
        crossDomain : true,
        url: 'http://localhost:8080/job4j_todo/task.do?allTasks=' + allTasks + "&userId=" + userId,
        dataType: 'text',
    }).done(function(data) {
        let dt = JSON.parse(data)
        for (const [key, value] of Object.entries(dt)) {
            if (key === 'categories') {
                let select = $('select[name=cIds]')
                select.text("")
                for (let i = 0; i < value.length; i++) {
                    let option = $('<option>', {
                        value: value[i].id,
                        text: value[i].name
                    })
                    select.append(option)
                }
            }
            if (key === 'tasks') {
                let tbody = $('tbody').text("")
                for (let i = 0; i < value.length; i++) {
                    let tr = $('<tr>')
                    let numb = $('<td>', {
                        text: `${i + 1}`
                    })
                    let desc = $('<td>', {
                        text: `${value[i].description}`
                    })
                    let date = $('<td>', {
                        text: `${value[i].created}`
                    })
                    let checked
                    if (value[i].done) {
                        checked = "checked"
                    }
                    let done = $('<td>').append($('<div>', {
                        style: "text-align: center"
                    }).append($('<input>', {
                        id: `${value[i].id}`,
                        type: "checkbox",
                        checked: checked,
                    }).on({'click': function() {
                                let url = 'http://localhost:8080/job4j_todo/task.do?action=update&taskId=' + value[i].id + '&done=' + value[i].done
                                $.ajax({
                                    type: 'POST',
                                    crossDomain : true,
                                    url: url,
                                    dataType: 'text',
                                }).done(function() {
                                    getTasks(userId)
                                    }
                                )
                    }})))
                    tr.append(numb)
                    tr.append(desc)
                    tr.append(date)
                    tr.append(done)
                    tbody.append(tr)
                }
            }
        }
    });
}
