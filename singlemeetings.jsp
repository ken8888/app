<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Single Meetings</title>
</head>

<body>


    <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu_classes.html" />
            </td>
            <td>

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
    
            <%-- -------- Open Connection Code -------- --%>
            <%
                try {
                    // Load PostGreSQL Driver class file
                    DriverManager
						.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());

                    // Make a connection to the datasource "cse132b"
                    Connection conn = DriverManager.getConnection(

                        "jdbc:sqlserver://MR_HE\\SQLEXPRESS;databaseName=cse132b",

                        "sahmed123", "sahmed123");
            %>

            <%-- -------- INSERT Code -------- --%>
            <%
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO SingleMeeting VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
 
                        pstmt.setInt(
                                1, Integer.parseInt(request.getParameter("meetingid")));
                        pstmt.setString(2, request.getParameter("meeting_type"));
                        pstmt.setString(3, request.getParameter("building_name"));
                        pstmt.setString(4, request.getParameter("room_number"));
                        pstmt.setString(5, request.getParameter("start_time"));
                        pstmt.setString(6, request.getParameter("end_time"));
                        pstmt.setString(7, request.getParameter("attendance"));
                        pstmt.setString(8, request.getParameter("_date"));
                        pstmt.setString(9, request.getParameter("day"));


                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPdate Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPdate the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPdate WeeklyMeeting SET meeting_type = ?, building_name = ?, room_number = ?, " + 
                            "start_time = ?, end_time = ?, attendance = ?, _date = ?, day = ? " +
                            " WHERE meetingid = ?");

                        pstmt.setString(1, request.getParameter("meeting_type"));
                        pstmt.setString(2, request.getParameter("building_name"));
                        pstmt.setString(3, request.getParameter("room_number"));
                        pstmt.setString(4, request.getParameter("start_time"));
                        pstmt.setString(5, request.getParameter("end_time"));
                        pstmt.setString(6, request.getParameter("attendance"));
                        pstmt.setString(7, request.getParameter("_date"));
                        pstmt.setString(8, request.getParameter("day"));
                        pstmt.setInt(
                                9, Integer.parseInt(request.getParameter("meetingid")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM SingleMeeting WHERE meetingid = ?");

                        pstmt.setInt(
                                1, Integer.parseInt(request.getParameter("meetingid")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM SingleMeeting");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Meeting ID</th>
                        <th>Type</th>
                        <th>Building</th>
                        <th>Room</th>
                        <th>Start Time</th>
                        <th>End Time</th>
                        <th>Attendance</th>
                        <th>Date</th>
                        <th>Day</th>
                    </tr>
                    <tr>
                        <form action="singlemeetings.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="meetingid" size="10"></th>
                            <th><input value="" name="meeting_type" size="5"></th>
                            <th><input value="" name="building_name" size="5"></th>
                            <th><input value="" name="room_number" size="5"></th>
                            <th><input value="" name="start_time" size="10"></th>
                            <th><input value="" name="end_time" size="10"></th>
                            <th><input value="" name="attendance" size="10"></th>
                            <th><input value="" name="_date" size="10"></th>
                            <th><input value="" name="day" size="10"></th>
                            
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="singlemeetings.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("meetingid") %>" 
                                    name="meetingid" size="10">
                            </td>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("meeting_type") %>" 
                                    name="meeting_type" size="5">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("building_name") %>" 
                                    name="building_name" size="5">
                            </td>
                            
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("room_number") %>" 
                                    name="room_number" size="5">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("start_time") %>" 
                                    name="start_time" size="10">
                            </td>
                            
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("end_time") %>" 
                                    name="end_time" size="10">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("attendance") %>" 
                                    name="attendance" size="10">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("_date") %>"
                                    name="_date" size="10">
                            </td>
                            <td>
                                <input value="<%= rs.getString("day") %>"
                                    name="day" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="singlemeetings.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("meetingid") %>" name="meetingid">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Delete">
                            </td>
                        </form>
                    </tr>
            <%
                    }
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
    
                    // Close the Statement
                    statement.close();
    
                    // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
                </table>
            </td>
        </tr>
    </table>




</body>

</html>