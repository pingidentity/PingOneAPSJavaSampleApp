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

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%!

%>

<html>
<head><title>PingOne APS Sample Application</title>
<link rel='stylesheet' id='pm-css' href='pm-default.css' type='text/css' media='all' />
</head><body>
<div class="header"><h1>PingOne APS Sample Application</h1></div>
<h2>Page Description</h2>
<p>This is the initial landing page.  This page needs to trigger the SSO transaction for the user.  For example you could read the hostname of the url to redirect to a specific IDP or ask the user to select their organisation from a drop down.</p>
<h2>Manual Login Form</h2>
<p>Display the manual login form here for organisations that haven't enabled SSO</p>
<p><a href="login.jsp?userid=jsmith">Manually login</a> as jsmith</p>
<h2>SP-Initiated SSO URL</h2>
<p>Click the <a href="https://sso.connect.pingidentity.com/sso/sp/initsso?saasid=c95b5a2a-ebef-4be3-b70a-8a10d925470a&idpid=pm-test-sso">SSO Initiation link</a> to begin an SSO transaction</p>
</html>
