<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="table.js"></script>

    <title>ToDoList</title>
</head>

<body onload="getTasks('<c:out value="${user.id}"/>')">
<div class="container">
    <div class="row">
        <ul class="nav">
            <c:if test="${user.name == null}">
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/login.jsp">Войти</a>
                </li>
            </c:if>
            <c:if test="${user.name != null}">
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/login.jsp"> <c:out value="${user.name}"/> | Выйти</a>
                </li>
            </c:if>
        </ul>
    </div>
    <br>
    <div class="card" style="width: 100%">
        <div class="card-header">
            <h2>Список заданий</h2>
        </div>
        <br>
        <div>
            <form class="form-inline" action="http://localhost:8080/job4j_todo/task.do" method="post">
                <div>
                    <input type="text" class="form-control" name="desc" id="desc" placeholder="Описание" title="Заполните поле описание">
                    <input type="hidden" class="form-control" name="userEmail" id="userEmail" value="<c:out value="${user.email}"/>">
                    <button type="submit" class="btn btn-success" onclick="return validate()">Добавить задание</button>
                </div>
            </form>
        </div>
        <br><br>
        <div class="card-body">
            <input type="checkbox" name="select" onclick="getTasks('<c:out value="${user.id}"/>')"><label>&nbsp Показать все задания</label>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th style="width: 80px;">№</th>
                        <th style="width: 600px;">Задание</th>
                        <th style="width: 200px;">Автор</th>
                        <th style="width: 100px;">Выполнено</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>