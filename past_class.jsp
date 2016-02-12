<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Class Enrollment</title>
</head>

<body>


    <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />
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
                            "INSERT INTO pastclass VALUES (?, ?, ?, ?, ?, ?, ?);" );
 


                        pstmt.setString(1, request.getParameter("student_id"));
                        pstmt.setInt(
                                2, Integer.parseInt(request.getParameter("section_id")));
                        pstmt.setString(3, request.getParameter("term"));
                        pstmt.setString(4, request.getParameter("grade_type"));
                        pstmt.setString(
                                5,request.getParameter("units"));
                        pstmt.setString(6, request.getParameter("grade_received"));
                        pstmt.setString(7, request.getParameter("course_number"));
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
                            "UPDATE pastclass SET student_id = ?, section_id = ?," +
                            "term = ?, grade_type = ?, units = ?, grade_received = ?, course_number = ? WHERE student_id = ?;");
                        pstmt.setString(1, request.getParameter("student_id"));
                        pstmt.setInt(
                                2, Integer.parseInt(request.getParameter("section_id")));
                        pstmt.setString(3, request.getParameter("term"));                        
                        pstmt.setString(4, request.getParameter("grade_type"));
                        pstmt.setString(
                                5, request.getParameter("units"));
                        pstmt.setString(6, request.getParameter("grade_received"));
                        pstmt.setString(7, request.getParameter("course_number"));
                         pstmt.setString(8, request.getParameter("student_id"));
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
                            "DELETE FROM pastclass WHERE student_id = ?;");

                         pstmt.setString(1, request.getParameter("student_id"));
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
                        ("SELECT * FROM pastclass");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>

                        <th>Student ID</th>
                         <th>Course Number</th>
                        <th>Section ID</th>
                        <th>Term</th>
                        <th>Grade Type</th>
                        <th>Units</th>
                        <th>Grade Received</th>
                    </tr>
                    <tr>
                        <form action="past_class.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="student_id" size="10"></th>
    <th><input value="" name="course_number" size="10"></th>
                            <th><input value="" name="section_id" size="10"></th>
                            <th><input value="" name="term" size="5"></th>
                            <th><input value="" name="grade_type" size="5"></th>
                            <th><input value="" name="units" size="5"></th>
                            <th><input value="" name="grade_received" size="5"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="past_class.jsp" method="get">
                            <input type="hidden" value="update" name="action">



                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("student_id") %>" 
                                    name="student_id" size="10">
                            </td>

    <td>
    <input value="<%= rs.getString("course_number") %>"
    name="course_number" size="10">
    </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getInt("section_id") %>" 
                                    name="section_id" size="10">
                            </td>
                            
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("term") %>" 
                                    name="term" size="5">
                            </td>
                            
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("grade_type") %>" 
                                    name="grade_type" size="5">
                            </td>
                            
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("units") %>" 
                                    name="units" size="5">
                            </td>
                            
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("grade_received") %>" 
                                    name="grade_received" size="5">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="past_class.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("student_id") %>" name="student_id">
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