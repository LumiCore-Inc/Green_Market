<%@ page
        import="java.io.BufferedReader, java.io.InputStreamReader, java.io.OutputStream, java.net.HttpURLConnection, java.net.URL, java.nio.charset.StandardCharsets" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Process</title>
</head>
<body>
<%
    //  String username = request.getParameter("username");
//  String password = request.getParameter("password");

    String apiUrl = "http://localhost:8080/Green_Market_war_exploded/user?action=login";
    String username = "ushan";
    String password = "1234";

    try {
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        String jsonInputString = "{\"username\": \"" + username + "\", \"password\": \"" + password + "\"}";

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = jsonInputString.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        int responseCode = conn.getResponseCode();

        String recv;
        String recvbuff = null;
        BufferedReader buffread = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        while ((recv = buffread.readLine()) != null)
            recvbuff += recv;
        buffread.close();
        System.out.println(recvbuff);


        if (responseCode == HttpURLConnection.HTTP_OK) {
            // API call successful
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuffer res = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                res.append(inputLine);
            }
            in.close();

            // Print the raw response received
            out.println("<h2>Raw Response:</h2>");
            out.println("<pre>" + res.toString() + "</pre>");

        } else {
            // API call failed
            out.println("<h2>API Call Failed</h2>");
        }

        conn.disconnect();

    } catch (Exception e) {
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
    }
%>
</body>
</html>
