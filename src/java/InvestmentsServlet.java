
import java.io.IOException;
import java.io.PrintWriter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;
import javax.xml.xpath.XPathExpression;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;


public class InvestmentsServlet extends HttpServlet {

    private String invTimeFromTextField, invNameFromTextField;
    private Map<String, ArrayList<String>> investmentsWithPeriods;

    @Override
    public void init() {
        try {
            String rootPath = getServletConfig().getServletContext().getRealPath("/");
            investmentsWithPeriods = getInvestmentDataFromXML(rootPath + "investments.xml");
        } catch (Exception exception) {
            exception.printStackTrace();
        }
    }

    public static Map<String, ArrayList<String>> getInvestmentDataFromXML(String path) throws Exception {
        DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
        Document doc = builder.parse(new java.io.File(path));

        XPathFactory factory = XPathFactory.newInstance();
        XPath xpath = factory.newXPath();
        XPathExpression expr = xpath.compile("//" + "investments" + "/*");
        Object result = expr.evaluate(doc, XPathConstants.NODESET);
        NodeList nodes = (NodeList) result;

        // Mapping: investment name => list of its period choices
        Map<String, ArrayList<String>> dataFromXML = new HashMap<String, ArrayList<String>>();

        for (int i = 0; i < nodes.getLength(); i++) {
            String investmentName = "";
            ArrayList<String> investmentPeriods = new ArrayList<String>();

            NodeList children = nodes.item(i).getChildNodes();
            for (int k = 0; k < children.getLength(); k++) {
                Node child = children.item(k);

                if (child.getNodeName().equals("name")) {
                    investmentName = child.getTextContent();
                }
                else if (child.getNodeName().equals("periods")) {
                    NodeList periodNodes = child.getChildNodes();

                    for (int c = 0; c < periodNodes.getLength(); c++) {
                        Node periodChoice = periodNodes.item(c);
                        if (periodChoice.getNodeType() != Node.TEXT_NODE && periodChoice.getFirstChild().getNodeType() == Node.TEXT_NODE) {
                            investmentPeriods.add(periodChoice.getFirstChild().getNodeValue());
                        }
                    }
                }
            }

            dataFromXML.put(investmentName, investmentPeriods);
        }

        return dataFromXML;
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        
        invTimeFromTextField = request.getParameter("investmentTime");
        invNameFromTextField = request.getParameter("investmentName");

        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!invTimeFromTextField.isEmpty() && !invNameFromTextField.isEmpty()) {
            ArrayList<String> allPeriods = investmentsWithPeriods.get(invNameFromTextField),
                              matchingPeriods = new ArrayList<String>();
            
            for(String periodChoice : allPeriods) {
                if(periodChoice.toLowerCase().startsWith(invTimeFromTextField.toLowerCase())) {
                    matchingPeriods.add(periodChoice);
                }
            }

            PrintWriter out = response.getWriter();
            try {
                out.println(String.join(",", matchingPeriods));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
