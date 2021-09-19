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
                    <a class="nav-link" href="<c:url value="login.jsp"/>">Войти</a>
                </li>
            </c:if>
            <c:if test="${user.name != null}">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="logout.do"/>"> <c:out value="${user.name}"/> | Выйти</a>
                </li>
            </c:if>
        </ul>
    </div>
    <div class="card" style="width: 100%">
        <div class="card-header">
            <h3>Список заданий</h3>
        </div>
        <div class="card-body">
            <form action="http://localhost:8080/job4j_todo/task.do?action=add" method="post">
                <div class="row" style="margin-bottom: 20px">
                    <div class="col">
                        <label for="cIds">Список категорий</label>
                        <select class="form-control" name="cIds" id="cIds" title="Выберите категорию" multiple>
                        </select>
                    </div>
                    <div class= "col">
                        <label>Описание</label>
                        <textarea rows="3" class="form-control" name="desc" id="desc" title="Заполните поле описание" style="height: 113px">
                        </textarea>
                        <input type="hidden" class="form-control" name="userEmail" id="userEmail" value="<c:out value="${user.email}"/>">
                    </div>
                </div>
                <div style="float: bottom">
                    <button type="submit" class="btn btn-success" onclick="return validate()">Добавить задание</button>
                </div>
            </form>
            <br>
            <input type="checkbox" name="select" onclick="getTasks('<c:out value="${user.id}"/>')"><label>&nbsp Показать все задания</label>
            <table class="table table-bordered" style="table-layout: fixed">
                <thead>
                    <tr>
                        <th style="width: 40px; text-align: center">№</th>
                        <th style="width: 50%; text-align: center;">Задание</th>
                        <th style=" text-align: center">Дата</th>
                        <th style="text-align: center">Выполнено</th>
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