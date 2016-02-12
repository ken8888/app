<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Probations</title>
</head>

<body>


    <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu_students.html" />
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
						"ken", "ken");
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
                            "INSERT INTO Probation VALUES (?, ?, ?, ?, ?)");
 
                        pstmt.setString(1, request.getParameter("ID"));
                        pstmt.setString(2, request.getParameter("STUDENTID"));
                        pstmt.setString(3, request.getParameter("STARTDATE"));
                        pstmt.setString(4, request.getParameter("ENDDATE"));
                        pstmt.setString(5, request.getParameter("REASON"));

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Probation SET STUDENTID = ?, STARTDATE = ?, " + 
                            "ENDDATE = ?, REASON = ? WHERE ID = ?");

                        pstmt.setString(1, request.getParameter("STUDENTID"));
                        pstmt.setString(2, request.getParameter("STARTDATE"));
                        pstmt.setString(3, request.getParameter("ENDDATE"));
                        pstmt.setString(4, request.getParameter("REASON"));
                        pstmt.setString(5, request.getParameter("ID"));
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
                            "DELETE FROM Probation WHERE ID = ?");

                        pstmt.setString(1, request.getParameter("ID"));
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
                        ("SELECT * FROM Probation");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Probation ID</th>
                        <th>Student ID</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Reason</th>
                    </tr>
                    <tr>
                        <form action="probations.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="ID" size="10"></th>
                            <th><input value="" name="STUDENTID" size="10"></th>
                            <th><input value="" name="STARTDATE" size="15"></th>
                            <th><input value="" name="ENDDATE" size="15"></th>
                            <th><input value="" name="REASON" size="20"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="probations.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("ID") %>" 
                                    name="ID" size="10">
                            </td>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("STUDENTID") %>" 
                                    name="STUDENTID" size="10">
                            </td>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("STARTDATE") %>" 
                                    name="STARTDATE" size="15">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("ENDDATE") %>" 
                                    name="ENDDATE" size="15">
                            </td>
                            
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("REASON") %>" 
                                    name="REASON" size="20">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="probations.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("ID") %>" name="ID">
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