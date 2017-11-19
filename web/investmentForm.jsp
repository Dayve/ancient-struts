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
        <link rel="stylesheet" type="text/css" href="stylesheet.css">
        <title>Lokaty</title>
    </head>
    <body>
        <html:form action="/investment">
            <table border="0">
                <tbody>
                    <tr>
                        <td colspan="2">
                            <bean:write name="InvestmentChoiceForm" property="error" filter="false"/>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>Twoje imię i nazwisko:</td>
                        <td><html:text property="clientNameAndSurname" /></td>
                    </tr>
                    <tr>
                        <td>Nazwa lokaty:</td>
                        <td><html:text property="investmentName" /></td>
                    </tr>
                    <tr>
                        <td>Okres lokaty:</td>
                        <td><html:text property="periodChoice" /></td>
                    </tr>
                    <tr>
                        <td>Kwota:</td>
                        <td><html:text property="price" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><html:submit value="Prześlij" /></td>
                    </tr>
                </tbody>
            </table>
        </html:form>
    </body>
</html>
