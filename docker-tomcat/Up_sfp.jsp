<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>  
<%@ page  
    import="java.util.*,org.springframework.context.ApplicationContext"%>  
<%@ page  
    import="org.springframework.web.context.support.WebApplicationContextUtils"%>  
<%@page import="com.hdsm.xxcj.tnbhzsfb.*;"%>  
<%@ include file="../../public/jsp_top.jsp"%>  
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
            + request.getServerName() + ":" + request.getServerPort()  
            + path + "/";  
    TnbsfbMain main = (TnbsfbMain) ctx.getBean("tnbsfbmain");  
    String str = request.getParameter("id").toString();  
    Iterator it = main.find_onesfb(str);  
%>  
  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">  
<html>  
    <head>  
        <base href="<%=basePath%>">  
  
        <title>编辑随访记录</title>  
  
        <meta http-equiv="pragma" content="no-cache">  
        <meta http-equiv="cache-control" content="no-cache">  
        <meta http-equiv="expires" content="0">  
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">  
        <meta http-equiv="description" content="This is my page">  
        <!--  
    <link rel="stylesheet" type="text/css" href="styles.css">  
        </head>  
  
    <body>  
        <form name="form1" action="" target="middleFrame" method="post">  
        <%  
                    while (it.hasNext()) {  
                    Map map = (Map) it.next();  
            %>  
            <table class="table_info2" border="1">  
                <tr style="border: thin">  
                    <td colspan="5" align="center">  
                        <h3>  
                            <strong>修改糖尿病患者随访记录</strong>  
                        </h3>  
                        <input type="hidden" name="id" id="id" value="<%=str%>">  
                        <input type="hidden" name="CV5101_27_ALL" id="CV5101_27_ALL"  
                            value="">  
                    </td>  
                </tr>  
                <tr>  
                                <tr>  
                <td >  
                        体质指数:                   </td>  
                    <td>  
                        <input type="text" name="PWNUM" id="PWNUM" class="text_2"onBlur="checkPrecent('PWNUM');"  
                        value="<%=map.get("PWNUM") == null ? "" : map  
                        .get("PWNUM").toString()%>">  
                  </td>  
                    <td >  
                        足背动脉搏动:  
                    </td>  
                    <td>  
                        <input type="radio" name="FOOTWAVE" id="FOOTWAVE" value="1"  
                            <% if ("1".equals(map.get("FOOTWAVE"))){%> checked="checked" <%}%>>  
                        未触及  
                        <input type="radio" name="FOOTWAVE" id="FOOTWAVE"   
                        <% if ("2".equals(map.get("FOOTWAVE"))){%> checked="checked" <%}%>>  
                        触及</td>         
                </tr>  
                                <tr>  
                    <td >  
                        医生签名:                   </td>  
                    <td colspan="4">  
                        <input type="text" name="DECTORNAME" id="DECTORNAME" class="text_2" value="<%=map.get("DECTORNAME")==null?"":map.get("DECTORNAME").toString()%>">  
                    </td>  
                </tr>  
                <tr>  
                    <td >  
                        下次随访日期:                 </td>  
                    <td colspan="4">  
                        <input type="text" name="NEXT_V_TIME_YEAR" size="5" onBlur="checkYear('NEXT_V_TIME_YEAR');"  
                        value="<%=map.get("NEXT_V_TIME")==null?"":map.get("NEXT_V_TIME").toString().substring(0, 10).split("-")[0]%>">  
                        年  
                        <input type="text" name="NEXT_V_TIME_MONTH" size="3" onBlur="checkMonth('NEXT_V_TIME_MONTH');"  
                        value="<%=map.get("NEXT_V_TIME")==null? "":map.get("NEXT_V_TIME").toString().substring(0, 10).split("-")[1]%>">  
                        月  
                        <input type="text" name="NEXT_V_TIME_DAY" size="3" onBlur="checkDay('NEXT_V_TIME_DAY');"  
                        value="<%=map.get("NEXT_V_TIME")==null? "":map.get("NEXT_V_TIME").toString().substring(0, 10).split("-")[2]%>">                          
                        日  
                    </td>  
                </tr>  
                <tr>  
                    <td colspan="5" height="5"></td>  
                </tr>  
                <tr>  
                    <td align="center" class="coolbutton" style="cursor: hand"  
                        colspan="5">  
                        <img src="<%=basePath%>images/queding.gif" width="51" height="20"  
                            onClick="find_dq();">  
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                        <img src="<%=basePath%>images/quxiao.gif" width="51" height="20"  
                            onClick="window.close();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                        <img src="<%=basePath%>images/dayin.gif" width="51" height="20"  
                            onClick="print_yl()">                              
                    </td>  
                </tr>  
            </table>  
            <%} %>  
        </form>  
    </body>  
</html>  
