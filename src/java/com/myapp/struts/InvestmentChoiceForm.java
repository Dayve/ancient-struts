/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myapp.struts;

import java.io.UnsupportedEncodingException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

/**
 *
 * @author dayve
 */
public class InvestmentChoiceForm extends org.apache.struts.action.ActionForm {

    private String clientNameAndSurname;
    private String investmentName;
    private String periodChoice;
    private String price;

    public String getClientNameAndSurname() {
        return clientNameAndSurname;
    }

    public void setClientNameAndSurname(String clientNameAndSurname) {
        this.clientNameAndSurname = clientNameAndSurname;
    }

    public String getInvestmentName() {
        return investmentName;
    }

    public void setInvestmentName(String investmentName) {
        this.investmentName = investmentName;
    }

    public String getPeriodChoice() {
        return periodChoice;
    }

    public void setPeriodChoice(String periodChoice) {
        this.periodChoice = periodChoice;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    private String error;

    public void setError(String errorMessage) {
        this.error = "<p style='color:red'>" + errorMessage + "</p>";
    }

    public String getError() {
        return error;
    }

    public InvestmentChoiceForm() {
        super();
    }

    @Override
    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        try {
            request.setCharacterEncoding("UTF8");
        } catch (UnsupportedEncodingException ex) {
            ex.printStackTrace();
        }
        ActionErrors errors = new ActionErrors();

        if (getClientNameAndSurname() == null || getPrice().length() < 1) {
            //errors.add("clientNameAndSurname", new ActionMessage("error.name.required"));
        }
        return errors;
    }
}
