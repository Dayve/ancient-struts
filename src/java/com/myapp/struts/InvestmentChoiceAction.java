/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myapp.struts;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author dayve
 */
public class InvestmentChoiceAction extends org.apache.struts.action.Action {

    private static final String SUCCESS = "success";
    private final static String FAILURE = "failure";

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        InvestmentChoiceForm formBean = (InvestmentChoiceForm) form;
        
        String clientPersonalData = formBean.getClientNameAndSurname();
        String investmentName = formBean.getInvestmentName();
        String periodChoice = formBean.getPeriodChoice();
        String price = formBean.getPrice();

        if (clientPersonalData != null && (clientPersonalData.equals("") || clientPersonalData.indexOf(" ") == -1 )) {
            formBean.setError("Proszę podać imię oraz nazwisko (powinny być oddzielone spacją)");
            return mapping.findForward(FAILURE);
        }
        if (investmentName != null && investmentName.equals("")) {
            formBean.setError("Proszę określić lokatę");
            return mapping.findForward(FAILURE);
        }
        if (periodChoice != null && periodChoice.equals("")) {
            formBean.setError("Proszę określić czas");
            return mapping.findForward(FAILURE);
        }
        
        if(price != null) {
            Pattern pattern = Pattern.compile("\\d+.\\d{2}$");
            Matcher matcher = pattern.matcher(price);

            if (!matcher.matches()) {
                formBean.setError("Proszę podać kwotę z dwoma miejscami po kropce, np. 100.00");
                return mapping.findForward(FAILURE);
            }
        }
        return mapping.findForward(SUCCESS);
    }
}
