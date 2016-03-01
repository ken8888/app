<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>Courses</title>
</head>

<body>
    <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu_courses.html" />
            </td>
            <td>

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
    
            <%-- -------- Open Connection Code -------- --%>
            <%
                try {
                    DriverManager
						.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());

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
                            "INSERT INTO Course VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
 
                        pstmt.setString(1, request.getParameter("title"));
                        pstmt.setString(2, request.getParameter("department"));
                        pstmt.setString(3, request.getParameter("coursenumber"));
                        pstmt.setString(4, request.getParameter("units"));
                        pstmt.setString(5, request.getParameter("gradetype"));
                        pstmt.setString(6, request.getParameter("division"));
                        pstmt.setString(7, request.getParameter("consent"));
                        pstmt.setString(8, request.getParameter("lab"));

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
                            "UPDATE Course SET title = ?, department = ?, " +
                            "coursenumber = ?, units = ?,gradetype = ?,division = ?,consent = ?,lab = ? WHERE coursenumber = ?");
                        pstmt.setString(1, request.getParameter("title"));
                        pstmt.setString(2, request.getParameter("department"));
                        pstmt.setString(3, request.getParameter("coursenumber"));
                        pstmt.setString(4, request.getParameter("units"));
                        pstmt.setString(5, request.getParameter("gradetype"));
                        pstmt.setString(6, request.getParameter("division"));
                        pstmt.setString(7, request.getParameter("consent"));
                        pstmt.setString(8, request.getParameter("lab"));
                        pstmt.setString(9, request.getParameter("coursenumber"));


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
                            "DELETE FROM Course WHERE coursenumber = ?");
                        pstmt.setString(1, request.getParameter("coursenumber"));
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
                        ("SELECT * FROM Course");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Title</th>
                        <th>Department</th>
                        <th>Course Number</th>
                        <th>Units</th>
                        <th>Grade Type</th>
                        <th>Division</th>
                        <th>Consent by Instructor</th>
                        <th>Lab</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="courses.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="title" size="20"></th>
                            <th><input value="" name="department" size="5"></th>
                            <th><input value="" name="coursenumber" size="5"></th>
                            <th><input value="" name="units" size="5"></th>
                            <th><input value="" name="gradetype" size="5"></th>
                            <th><input value="" name="division" size="5"></th>
                            <th><input value="" name="consent" size="5"></th>
                            <th><input value="" name="lab" size="5"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>
                    <tr>
                        <form action="courses.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("title") %>" 
                                    name="title" size="20">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("department") %>" 
                                    name="department" size="5">
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("coursenumber") %>"
                                    name="coursenumber" size="5">
                            </td>
    
                            <%-- Get the MIDDLENAME --%>
                            <td>
                                <input value="<%= rs.getString("units") %>"
                                    name="units" size="5">
                            </td>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("gradetype") %>"
                                name="gradetype" size="5">
                            </td>

                            <%-- Get the ID --%>
                            <td>
                            <input value="<%= rs.getString("division") %>"
                            name="division" size="5">
                            </td>

                            <%-- Get the FIRSTNAME --%>
                            <td>
                            <input value="<%= rs.getString("consent") %>"
                            name="consent" size="5">
                            </td>

                            <%-- Get the MIDDLENAME --%>
                            <td>
                            <input value="<%= rs.getString("lab") %>"
                            name="lab" size="5">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="courses.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("coursenumber") %>" name="coursenumber">
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