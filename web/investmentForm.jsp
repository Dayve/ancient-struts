<%-- 
    Document   : login
    Created on : 2017-11-18, 20:43:05
    Author     : dayve
--%>

<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style.css">
        <title>Lokaty</title>
    </head>
    <body>
        <html:form action="/investment">
            <bean:write name="InvestmentChoiceForm" property="error" filter="false"/>&nbsp;
            <div>
                <label for="name-input">Imię, nazwisko:</label>
                <html:text property="clientNameAndSurname" styleClass="right-side" styleId="name-input" />
            </div>
            <br/>

            <div>
                <label for="investment-name-input">Nazwa lokaty:</label> 
                <html:text property="investmentName" styleClass="right-side" styleId="investment-name-input" />
                <div class="suggestions-div" id="name-suggestions"></div>
            </div>
            <br/>

            <div>
                <label for="investment-time-input">Czas lokaty:</label>
                <html:text property="periodChoice"  styleClass="right-side" styleId="investment-time-input" />
                <div class="suggestions-div" id="period-suggestions"></div>
            </div>
            <br/>

            <div>
                <label for="priceInput">Wpłata:</label> 
                <html:text property="price" styleClass="right-side" styleId="priceInput" />
            </div>
            <br/>

            <html:submit value="Prześlij" styleClass="right-side" styleId="send-button" />
        </html:form>
    </body>
</html>
