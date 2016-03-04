<%@page language="java" import="java.sql.*" %>
        <% DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver()); %>

<%
 String URL = "jdbc:sqlserver://MR_HE\\SQLEXPRESS;databaseName=cse132b";
            String USERNAME = "sahmed123";
            String PASSWORD = "sahmed123";
   Connection connection = null;
   PreparedStatement pstmt = null;
   ResultSet resultset = null;
      PreparedStatement pstmt1 = null;
   ResultSet resultset1 = null;
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Undergraduate Student's Remaining Requirements</title>
        <script type="text/JavaScript"> 
            function handleSelect(form_classes_by_student){
                var selIndex = form_classes_by_student.selected.selectedIndex;
                var selName = form_classes_by_student.selected.options[selIndex].text;
                document.getElementById("ID").value = selName;

    var selIndex1 = form_classes_by_student.selected.selectedIndex;
    var selName1 = form_classes_by_student.selected.options[selIndex1].text;
    document.getElementById("title").value = selName1;
            }
        </script> 
    </head>
    <body>

        <%
        try{
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            pstmt = connection.prepareStatement(
            "SELECT DISTINCT x.studentid"
            + " FROM undergraduate x, studentenrollment y"
            + " WHERE y.term = 'WI2016'"
            + " AND y.studentid = x.studentid");

            pstmt1 = connection.prepareStatement(
            "select title from degree"
            );
        } catch (SQLException e){
            e.printStackTrace();
        }

        try{
            resultset = pstmt.executeQuery();
            resultset1 = pstmt1.executeQuery();
        } catch (SQLException e){
            e.printStackTrace();
        }

        %>

        <h1>Display degree requirements for Undergraduate Students</h1>
        
        <div style = "width:100%">
        
            <div style = "float:left; width:20%;">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />
            </div>
        
            <div style = "float:left; width:80%;">
                <form name="form_classes_by_student" action="display_undergrad_requirements.jsp" method="POST">
                        <table border="1">
                        <tbody>
                          <%--  <tr>   
                                <td>Student ID :</td>
                                <td><input value="" name="ID" size="0"></td>
                            </tr>
                            --%>  
                            <tr>   
                                <td>Students enrolled</td>
                                <td><select name="selected" onchange="handleSelect(this.form)"> 
                                    <% while (resultset.next()){ %>
                                    <option>
                                        <%= resultset.getString("studentid") %>
                                    </option>
                                    <% } %>
                                </select></td>
                                <td><input value="" id="ID" name="ID" size="10"></td>
    <td><select value="" name="title" >
        <% while (resultset1.next()){ %>
    <option>
        <%= resultset1.getString("title") %>
    </option>
        <% } %>
    </select></td>
                                   <%--<td><input value="" id="title" name="title" size="10"></td>--%>
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
