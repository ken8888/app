<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Graduates</title>
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
                            "INSERT INTO graduate VALUES (?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("STUDENTID"));
                        pstmt.setString(2, request.getParameter("DEPTNAME"));
                        pstmt.setString(3, request.getParameter("CLASSIFICATION"));
                        pstmt.setString(4, request.getParameter("IS_PRECANDIDATE"));
                        pstmt.setString(5, request.getParameter("IS_CANDIDATE")); 
                        pstmt.setString(6, request.getParameter("CANDIDATE_ADVISOR")); 
                        pstmt.setString(7, request.getParameter("COMMITTEEID")); 
                        
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
                            "UPDATE graduate SET DEPTNAME = ?, CLASSIFICATION = ?, " +
                            "IS_PRECANDIDATE = ?, IS_CANDIDATE = ?, CANDIDATE_ADVISOR = ?, " +
                            "COMMITTEEID = ? WHERE STUDENTID = ?");
                        
                        pstmt.setString(1, request.getParameter("DEPTNAME"));
                        pstmt.setString(2, request.getParameter("CLASSIFICATION"));
                        pstmt.setString(3, request.getParameter("IS_PRECANDIDATE"));
                        pstmt.setString(4, request.getParameter("IS_CANDIDATE"));
                        pstmt.setString(5, request.getParameter("CANDIDATE_ADVISOR"));
                        pstmt.setString(6, request.getParameter("COMMITTEEID")); 
                        pstmt.setString(7, request.getParameter("STUDENTID")); 

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
                            "DELETE FROM graduate WHERE STUDENTID = ?");
                        
                        pstmt.setString(1, request.getParameter("STUDENTID"));
                        
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
                        ("SELECT * FROM graduate");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Student ID</th>
                        <th>Dept Name</th>
                        <th>Classification</th>
                        <th>Is Precandidate</th>
                        <th>Is Candidate</th>
                        <th>Candidate Advisor</th>
                        <th>Committee ID</th>
                    </tr>
                    <tr>
                        <form action="graduates.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="STUDENTID" size="15"></th>
                            <th><input value="" name="DEPTNAME" size="15"></th>
                            <th><input value="" name="CLASSIFICATION" size="15"></th>
                            <th><input value="" name="IS_PRECANDIDATE" size="15"></th>
                            <th><input value="" name="IS_CANDIDATE" size="15"></th>
                            <th><input value="" name="CANDIDATE_ADVISOR" size="15"></th>
                            <th><input value="" name="COMMITTEEID" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="graduates.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("STUDENTID") %>" 
                                    name="STUDENTID" size="15">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("DEPTNAME") %>" 
                                    name="DEPTNAME" size="15">
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("CLASSIFICATION") %>"
                                    name="CLASSIFICATION" size="15">
                            </td>
    
                            <%-- Get the MIDDLENAME --%>
                            <td>
                                <input value="<%= rs.getString("IS_PRECANDIDATE") %>" 
                                    name="IS_PRECANDIDATE" size="15">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("IS_CANDIDATE") %>" 
                                    name="IS_CANDIDATE" size="15">
                            </td>
                            
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("CANDIDATE_ADVISOR") %>" 
                                    name="CANDIDATE_ADVISOR" size="15">
                            </td>
                            
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("COMMITTEEID") %>" 
                                    name="COMMITTEEID" size="15">
                            </td>
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        
                        <form action="graduates.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("STUDENTID") %>" name="STUDENTID">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Delete">
                            </td>
                        </form>
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