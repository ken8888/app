<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Course Grade Distribution</title>
    </head>
    <body>

        <h1>Display information on the distribution of grades in particular courses and by particular professors</h1>
        
        <div style = "width:100%">
        
            <div style = "float:left; width:20%;">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />                
            </div>
        
            <div style = "float:left; width:80%;">
                <form name="form_course_gradedistribution" action="display_course_gradedistribution.jsp" method="POST">
                        <table border="1">
                        <tbody>
                            <tr>   
                                <td>Course Title :</td>
                                <td><input value="" name="title" size="20"></td>
                                <td>Professor :</td>
                                <td><input value="" name="instructor" size="20"></td>
                                <td>Term :</td>
                                <td><input value="" name="term" size="5"></td>

    <td>

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
