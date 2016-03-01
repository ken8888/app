<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Course Prerequisites</title>
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
                    // Load PostGreSQL Driver class file
                    DriverManager
						.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());

                    // Make a connection to the datasource "cse132b"
                    Connection conn = DriverManager.getConnection(
                        "jdbc:sqlserver://SHAMIM-PC\\SQLEXPRESS;databaseName=cse132b",
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
                            "INSERT INTO CoursePrerequisite VALUES (?, ?)");
 
                        pstmt.setString(1, request.getParameter("coursenumber"));
                        pstmt.setString(2, request.getParameter("pre_course_number"));

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
                            "UPDATE CoursePrerequisite SET pre_course_number = ? WHERE coursenumber = ?");

                        pstmt.setString(1, request.getParameter("pre_course_number"));
                        pstmt.setString(2, request.getParameter("coursenumber"));

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
                            "DELETE FROM CoursePrerequisite WHERE coursenumber = ? AND pre_course_number = ?");

                        pstmt.setString(1, request.getParameter("coursenumber"));
                        pstmt.setString(2, request.getParameter("pre_course_number"));
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
                        ("SELECT * FROM CoursePrerequisite");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Course</th>
                        <th>Prerequisite</th>
                    </tr>
                    <tr>
                        <form action="course_prerequisites.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="coursenumber" size="20"></th>
                            <th><input value="" name="pre_course_number" size="20"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="course_prerequisites.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("coursenumber") %>" 
                                    name="coursenumber" size="20">
                            </td>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("pre_course_number") %>" 
                                    name="pre_course_number" size="20">
                            </td>

                            <%-- Button --%>
                            <td>
                            <input type="submit" value="Update">
                            </td>
    
                        </form>
    <form action="course_prerequisites.jsp" method="get">
    <input type="hidden" value="delete" name="action">
    <input type="hidden"
    value="<%= rs.getString("coursenumber") %>" name="coursenumber">
    <input type="hidden"
    value="<%= rs.getString("pre_course_number") %>" name="pre_course_number">
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