<%-- 
    Document   : investmentForm
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
    <div id="suggestionsList"></div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script type='text/javascript'>
        function init() {
            investmentNameInput = document.getElementById('investment-name-input');
            investmentTimeInput = document.getElementById('investment-time-input');

            investmentNameInput.oninput = getInvestmentNameChoices;
            investmentTimeInput.oninput = getInvestmentPeriodChoices;

            nameSuggestions = [];
            disablePeriodInputOnWrongName();

            $.get('investments.xml').then(function (XMLelements) {
                investmentNames = [];

                $.each(XMLelements.getElementsByTagName('investment'), function (n, investment) {
                    var investmentName = investment.getElementsByTagName('name')[0].innerHTML;
                    investmentNames.push(investmentName);
                });
            });
        }

        function getInvestmentPeriodChoices() {
            const investmentNameValue = encodeURIComponent(investmentNameInput.value);
            const investmentTimeValue = encodeURIComponent(investmentTimeInput.value);

            var queryParams = {
                method: 'get',
                url: 'InvestmentsServlet',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                data: 'investmentName=' + investmentNameValue + '&investmentTime=' + investmentTimeValue
            };
            
            $.ajax(queryParams).done(function (received) {
                console.log(received);
                var suggestions = received.trim().split(',');

                var timeSuggestionsElement = document.getElementById('period-suggestions');
                timeSuggestionsElement.innerHTML = '';

                suggestions.forEach(function (matchingName) {
                    var suggestionsDiv = document.createElement('div');

                    suggestionsDiv.innerText = matchingName;
                    suggestionsDiv.className = 'suggestions-div-item';
                    timeSuggestionsElement.appendChild(suggestionsDiv);

                    suggestionsDiv.onclick = function (event) {
                        investmentTimeInput.value = event.target.innerText;
                        timeSuggestionsElement.innerHTML = '';
                        timeSuggestionsElement.style.border = 'none';
                    };
                });
            });
        }

        function getInvestmentNameChoices() {
            nameSuggestions = investmentNames.filter(name => event.target.value && name.toLowerCase().startsWith(event.target.value.toLowerCase()));

            disablePeriodInputOnWrongName();
            var nameSuggestionsElement = document.getElementById('name-suggestions');
            nameSuggestionsElement.innerHTML = '';

            nameSuggestions.forEach(function (matchingName) {
                var suggestionsDiv = document.createElement('div');
                suggestionsDiv.innerText = matchingName;
                suggestionsDiv.className = 'suggestions-div-item';
                nameSuggestionsElement.appendChild(suggestionsDiv);
                suggestionsDiv.onclick = function (event) {
                    investmentNameInput.value = event.target.innerText;
                    nameSuggestionsElement.innerHTML = '';
                    nameSuggestionsElement.style.border = 'none';
                    disablePeriodInputOnWrongName();
                };
            });
        }

        function disablePeriodInputOnWrongName() {
            investmentTimeInput.disabled = true;
            if (nameSuggestions) {
                nameSuggestions.forEach(function (suggestedName) {
                    if (suggestedName === investmentNameInput.value) {
                        investmentTimeInput.disabled = false;
                        return;
                    }
                });
            }
        }

        init();
    </script>
</body>
</html>
