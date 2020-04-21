<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>

<title>RSVP App!</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="/bootstrap.min.css">
<link rel="icon" href="${LOGO}" type="image/png" sizes="16x16">
<script type="text/javascript" src= "/jquery.min.js"></script>
<script type="text/javascript" src= "/bootstrap.min.js"></script>
<body>
<div class="jumbotron">
    <div class="container">
        <div align="center">
            <h2><a href="${LINK}">${TEXT1}<img src="${LOGO}"/>${TEXT2}</a></h2>
            <h3><font color="maroon"> Serving from Host: ${hostname} </font>
                <font size="8" >
                </font> </h3>
            <link rel="stylesheet" type="text/css" href="/style.css">
            <form action="/new" method='POST'>
                <div  class="form-group">
                    <label for="name">Name:</label>
                    <input  type="text" name="name"  id="name" placeholder="Enter your name" >
                </div>
                <div  class="form-group">
                    <label for="email">Email:</label>
                    <input  type="text" name="mail"  id="email" placeholder="Enter your email">
                </div>
                <button type="Submit" onclick="alert('RSVP Succeeded!')" align="center" name="submit" class="btn btn-danger">Submit</button>
            </form>
            <h3> RSVP Count : ${count}</h3>
            <table  style="width:40%" class="table">
                <thead>
                <tr >
                    <th class="text-center">Name</th>
                    <th class="text-center">Email</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="topic" items="${data.keySet()}">
                    <tr class="danger">

                        <td class="text-center">${topic}</td>
                        <td class="text-center">${data.get(topic)}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<footer class="footer text-center">
    <div class="container">
        <ul class="list-inline">
            <li class="text-muted">${COMPANY}</li>
        </ul>
    </div>
</footer>
</body>
</html>