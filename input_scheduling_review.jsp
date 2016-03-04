<%@page language="java" import="java.sql.*" %>
<% DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver()); %>
<%
   String URL = "jdbc:sqlserver://SHAMIM-PC\\SQLEXPRESS;databaseName=cse132b";
   String USERNAME = "sahmed123";
   String PASSWORD = "sahmed123";
   Connection connection = null;
   PreparedStatement pstmt = null;
   ResultSet resultset = null;
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Scheduling a review session</title>
        <script type="text/JavaScript"> 
            function handleSelect(form_classes_by_student){
                var selIndex = form_classes_by_student.selected.selectedIndex;
                var selName = form_classes_by_student.selected.options[selIndex].text;
                document.getElementById("ID").value = selName;
            }
        </script> 
    </head>
    <body>

        <%
        try{
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            pstmt = connection.prepareStatement(
            "SELECT DISTINCT x.section_id"
            + " FROM class x"
            + " WHERE"
            + " x.term = 'WI2016'"
            );
        } catch (SQLException e){
            e.printStackTrace();
        }

        try{
            resultset = pstmt.executeQuery();
        } catch (SQLException e){
            e.printStackTrace();
        }

        %>

        <h1>Scheduling a review session for a class</h1>
        <div style = "width:100%">
        
            <div style = "float:left; width:20%;">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />
            </div>
        
            <div style = "float:left; width:80%;">
                <form name="form_classes_by_student" action="display_scheduling_review.jsp" method="POST">
                        <table border="1">
                        <tbody>
                          <%--  <tr>   
                                <td>Student ID :</td>
                                <td><input value="" name="ID" size="0"></td>
                            </tr>
                            --%>  
                            <tr>   
                                <td>Section ID of current quarter</td>
                                <td><select name="selected" onchange="handleSelect(this.form)"> 
                                    <% while (resultset.next()){ %>
                                    <option>
                                        <%= resultset.getInt("section_id") %>
                                    </option>
                                    <% } %>
                                </select></td>
                                <td><input value="" id="ID" name="ID" size="10"></td>
                                <%--   <td><input id="ID" size="10"></td> --%>
                                <td><input type="reset" value="Clear" name="clear">
                                    <input type="submit" value="Submit" name="submit">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        
        </div>
        
    </body>
</html>
