    <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>Classes</title>
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
                            "INSERT INTO Class VALUES (?, ?, ?, ?, ?, ?, ?)");
 
                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("sectionid")));
                        pstmt.setString(2, request.getParameter("coursetitle"));
                        pstmt.setString(3, request.getParameter("term"));
                        pstmt.setString(4, request.getParameter("instructor"));
                        pstmt.setInt(
                            5, Integer.parseInt(request.getParameter("enrolled")));
                        pstmt.setInt(
                            6, Integer.parseInt(request.getParameter("seats")));
                        pstmt.setInt(
                            7, Integer.parseInt(request.getParameter("waitlist")));
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
                            "UPDATE Class SET course_title = ?, term = ?, instructor = ?, " +
                            "enrolled = ?, seats = ?, waitlist = ? WHERE SECTION_ID = ?");
                        pstmt.setString(1, request.getParameter("coursetitle"));
                        pstmt.setString(2, request.getParameter("term"));
                        pstmt.setString(3, request.getParameter("instructor"));
                        pstmt.setInt(
                            4, Integer.parseInt(request.getParameter("enrolled")));
                        pstmt.setInt(
                            5, Integer.parseInt(request.getParameter("seats")));
                        pstmt.setInt(
                            6, Integer.parseInt(request.getParameter("waitlist")));
                        pstmt.setInt(
                            7, Integer.parseInt(request.getParameter("sectionid")));
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
                            "DELETE FROM Class WHERE SECTION_ID = ?");
                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("sectionid")));
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
                        ("SELECT * FROM Class");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Section ID</th>
                        <th>Course Number</th>
                        <th>Term</th>
                        <th>Instructor</th>
                        <th>Enrolled</th>
                        <th>Limit</th>
                        <th>Waitlist</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="sectionid" size="10"></th>
                            <th><input value="" name="coursetitle" size="20"></th>
                            <th><input value="" name="term" size="5"></th>
                            <th><input value="" name="instructor" size="15"></th>
                            <th><input value="" name="enrolled" size="5"></th>
                            <th><input value="" name="seats" size="5"></th>
                            <th><input value="" name="waitlist" size="5"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("section_id") %>"
                                    name="sectionid" size="10">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("course_title") %>"
                                    name="coursetitle" size="20">
                            </td>
                            
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("term") %>"
                                    name="term" size="5">
                            </td>
                            
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("instructor") %>"
                                    name="instructor" size="15">
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getInt("enrolled") %>"
                                    name="enrolled" size="5">
                            </td>
    
                            <%-- Get the MIDDLENAME --%>
                            <td>
                                <input value="<%= rs.getInt("seats") %>"
                                    name="seats" size="5">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getInt("waitlist") %>"
                                    name="waitlist" size="5">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("section_id") %>" name="sectionid">
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