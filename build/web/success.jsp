<%-- 
    Document   : success
    Created on : 2017-11-18, 20:46:00
    Author     : dayve
--%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="stylesheet.css">
        <title>Login Success</title>
    </head>
    <body>
        <h1>Congratulations!</h1>

        <p>You have successfully logged in.</p>

        <p>Your name is: <bean:write name="InvestmentChoiceForm" property="name" />.</p>

        <p>Your email address is: <bean:write name="InvestmentChoiceForm" property="email" />.</p>
    </body>
</html>
