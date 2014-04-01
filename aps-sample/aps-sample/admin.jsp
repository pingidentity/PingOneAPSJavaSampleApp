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
<%@page import="com.pingidentity.opentoken.Agent"%>
<%@page import="com.pingidentity.opentoken.AgentConfiguration"%>
<%@page import="com.pingidentity.opentoken.Token"%>
<%@page import="com.pingidentity.opentoken.TokenException"%>

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%!
    private static final int DEFAULT_NOT_BEFORE_TOLERANCE = 300; // 5 minutes
    private static final int DEFAULT_RENEW_UNTIL = 1800; // 30 minutes
    private static final int DEFAULT_TOKEN_LIFETIME = 1800; // 30 minutes
    private static final int DEFAULT_CIPHER_SUITE = Token.CIPHER_SUITE_AES128CBC;
    private static final String OPENTOKEN_KEY = "yXbuwWRA2E4ieme4IzTKXPfdRRkrriN1";

    public static String writeToken(String idpId, String email) throws TokenException
    {
        Map attributes = new HashMap();
        attributes.put("subject", idpId);
        attributes.put("email", email);
        
        AgentConfiguration agentConfiguration = new AgentConfiguration();
        agentConfiguration.setCipherSuite(DEFAULT_CIPHER_SUITE);
        agentConfiguration.setNotBeforeTolerance(DEFAULT_NOT_BEFORE_TOLERANCE);
        agentConfiguration.setPassword(OPENTOKEN_KEY);
        agentConfiguration.setRenewUntilLifetime(DEFAULT_RENEW_UNTIL);
        agentConfiguration.setTokenLifetime(DEFAULT_TOKEN_LIFETIME);
        
        Agent agent = new Agent(agentConfiguration);
        return agent.writeToken(attributes);
    }
    
%>

<html>
<head><title>PingOne APS Sample Application</title>
<link rel='stylesheet' id='pm-css' href='pm-default.css' type='text/css' media='all' />
</head><body>
<div class="header"><h1>PingOne APS Sample Application</h1></div>
<h2>Page Description</h2>
<p>This is an admin page inside the application that provides a shortcut for the application administrator to configure SSO to your application without having to engage your resources.</p>
<h2>Actions</h2>
<p>Administrator email:  pmeyer+cas@pingidentity.com<br/>
Organisation identifier:  pm-test-sso</p>
<div id="pingWidget">Auto-configure SSO! Loading...</div>
</body>

<script type="text/javascript">
    var pingOneParams = {
        ssoDivId : 'pingWidget',
        // Replace me! See the sample code README in your download
        openToken : '<%=writeToken("pm-test-sso", "pmeyer+cas@pingidentity.com")%>',
        saasId : 'c95b5a2a-ebef-4be3-b70a-8a10d925470a',
        accountId : '450c9d23-6b97-4edb-b969-1346f3a46c71',
        useDefaultCss: false
    };
    (function() {
        var insertScript = document.createElement('script');
        insertScript.type = 'text/javascript'; insertScript.async = true; insertScript.id = 'insertScript';
        insertScript.src = 'https://admin.pingone.com/web-portal/integrate.js';
        var firstScript = document.getElementsByTagName('script')[0];
        firstScript.parentNode.insertBefore(insertScript, firstScript);
    })();
</script>

</html>
