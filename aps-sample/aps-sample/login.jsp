<%@page import="java.io.BufferedWriter"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Properties"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import="java.io.OutputStreamWriter"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.net.URL"%>
<%@page import="javax.servlet.http.Cookie"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="java.net.HttpURLConnection"%>

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%!
	public static String getAttributes(String token, String agentId) {
	
		try {
			final String REST_USERNAME = "d5721eb2-da14-4b4e-a668-1bec8f3123f9";
			final String REST_API_KEY = "REST_API_KEY";
		
   		    String tokenResolutionUrl = String.format("https://sso.connect.pingidentity.com/sso/TXS/2.0/2/%s", token);
			URL url = new URL(tokenResolutionUrl);
			HttpURLConnection urlConnection = (HttpURLConnection)url.openConnection();
   	     	String authValue = REST_USERNAME + ":" +  REST_API_KEY;
   	     	String basicAuthHeader = "Basic " + new String(Base64.encodeBase64((authValue).getBytes()));
   	     	urlConnection.setRequestProperty("Authorization", basicAuthHeader);
   	     	String agentidCookie = "agentid=" + agentId;
   	     	urlConnection.setRequestProperty("Cookie", agentidCookie);
   	     	InputStream is = urlConnection.getInputStream();
   	     	Properties properties = new Properties();
   	     	properties.load(is);
   	     	
			StringBuilder returnString = new StringBuilder();
   	     	String username = properties.getProperty("pingone.subject");
   	     	String idpId = properties.getProperty("pingone.idp.id");

			returnString.append("<p>Authenticated user: " + username + " from " + idpId + "</p>");
			returnString.append("<p>Token contents:<br/>");
			for(String attrKey : properties.stringPropertyNames()) {
				returnString.append("<br/>" + attrKey + " = " + properties.getProperty(attrKey));
			}
			returnString.append("</p>");

			return returnString.toString();

		} catch (Exception ex) {
			return "<p>Error: <br/>" + ex.toString() + "</p><p>Return to <a href='index.jsp'>landing page</a></p>";
		}
    }
%>

<html>
<head><title>PingOne APS Sample Application</title>
<link rel='stylesheet' id='pm-css' href='pm-default.css' type='text/css' media='all' />
</head>
<body>
<div class="header"><h1>PingOne APS Sample Application</h1></div>
<h2>Page Description</h2>
<p>This is the page the user returns to after logging in to their IDP and after PingOne has processed the SAML.  Here you would create the application session and render the application as normal.</p>
<h2>Authentication Results</h2>
<p>
<%
	if (request.getParameter("userid") != null) {
%>
		<p>Authenticated user manually: <%=request.getParameter("userid") %></p>

<%
	} else { 
	    String token = request.getParameter("tokenid");
    	String agentId = request.getParameter("agentid");
%>
<%=getAttributes(token, agentId)%>

<%
	}
%>


</p>
</body>
</html>
