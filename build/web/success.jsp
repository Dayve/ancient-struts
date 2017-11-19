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
        <title>Potwierdzenie</title>
    </head>
    <body>
        <h1>Dziękujemy!</h1>
        <p>Przesłano dane dotyczące lokaty</p>
        
        <p>Dane klienta: <bean:write name="InvestmentChoiceForm" property="clientNameAndSurname" />.</p>
        <p>Wybrana lokata: <bean:write name="InvestmentChoiceForm" property="investmentName" />.</p>
        <p>Wybrany okres lokaty: <bean:write name="InvestmentChoiceForm" property="periodChoice" />.</p>
        <p>Deklarowana kwota: <bean:write name="InvestmentChoiceForm" property="price" />.</p>
    </body>
</html>
