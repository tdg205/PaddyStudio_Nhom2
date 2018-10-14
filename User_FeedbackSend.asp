<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/cn.asp" -->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="False"
MM_authFailedURL="Login.asp"
MM_grantAccess=false
If Session("MM_Username") <> "" Then
  If (false Or CStr(Session("MM_UserAuthorization"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("MM_UserAuthorization"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  MM_qsChar = "?"
  If (InStr(1,MM_authFailedURL,"?") >= 1) Then MM_qsChar = "&"
  MM_referrer = Request.ServerVariables("URL")
  if (Len(Request.QueryString()) > 0) Then MM_referrer = MM_referrer & "?" & Request.QueryString()
  MM_authFailedURL = MM_authFailedURL & MM_qsChar & "accessdenied=" & Server.URLEncode(MM_referrer)
  Response.Redirect(MM_authFailedURL)
End If
%>
<%
Dim MM_editAction
MM_editAction = CStr(Request.ServerVariables("SCRIPT_NAME"))
If (Request.QueryString <> "") Then
  MM_editAction = MM_editAction & "?" & Server.HTMLEncode(Request.QueryString)
End If

' boolean to abort record edit
Dim MM_abortEdit
MM_abortEdit = false
%>
<%
If (CStr(Request("MM_insert")) = "form1") Then
  If (Not MM_abortEdit) Then
    ' execute the insert
    Dim MM_editCmd

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_cn_STRING
    MM_editCmd.CommandText = "INSERT INTO dbo.tbFeedback (FeedbackSubject, FeedbackContent, FeedbackMemberID) VALUES (?, ?, ?)" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 20, Request.Form("Summary")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 500, Request.Form("Content")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 201, 1, 20, Request.Form("Member")) ' adLongVarChar
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "User_FeedbackSendSuccess.asp"
    If (Request.QueryString <> "") Then
      If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0) Then
        MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
      Else
        MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
      End If
    End If
    Response.Redirect(MM_editRedirectUrl)
  End If
End If
%>
<%
Dim rsBrands
Dim rsBrands_cmd
Dim rsBrands_numRows

Set rsBrands_cmd = Server.CreateObject ("ADODB.Command")
rsBrands_cmd.ActiveConnection = MM_cn_STRING
rsBrands_cmd.CommandText = "SELECT a. BrandName, count(*) as ProCount  FROM dbo.tbProduct a join dbo.tbBrand b on a.BrandName = b.BrandName group by a. BrandName" 
rsBrands_cmd.Prepared = true

Set rsBrands = rsBrands_cmd.Execute
rsBrands_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
rsBrands_numRows = rsBrands_numRows + Repeat1__numRows
%>
<%
Dim MM_paramName 
%>
<%
' *** Go To Record and Move To Record: create strings for maintaining URL and Form parameters

Dim MM_keepNone
Dim MM_keepURL
Dim MM_keepForm
Dim MM_keepBoth

Dim MM_removeList
Dim MM_item
Dim MM_nextItem

' create the list of parameters which should not be maintained
MM_removeList = "&index="
If (MM_paramName <> "") Then
  MM_removeList = MM_removeList & "&" & MM_paramName & "="
End If

MM_keepURL=""
MM_keepForm=""
MM_keepBoth=""
MM_keepNone=""

' add the URL parameters to the MM_keepURL string
For Each MM_item In Request.QueryString
  MM_nextItem = "&" & MM_item & "="
  If (InStr(1,MM_removeList,MM_nextItem,1) = 0) Then
    MM_keepURL = MM_keepURL & MM_nextItem & Server.URLencode(Request.QueryString(MM_item))
  End If
Next

' add the Form variables to the MM_keepForm string
For Each MM_item In Request.Form
  MM_nextItem = "&" & MM_item & "="
  If (InStr(1,MM_removeList,MM_nextItem,1) = 0) Then
    MM_keepForm = MM_keepForm & MM_nextItem & Server.URLencode(Request.Form(MM_item))
  End If
Next

' create the Form + URL string and remove the intial '&' from each of the strings
MM_keepBoth = MM_keepURL & MM_keepForm
If (MM_keepBoth <> "") Then 
  MM_keepBoth = Right(MM_keepBoth, Len(MM_keepBoth) - 1)
End If
If (MM_keepURL <> "")  Then
  MM_keepURL  = Right(MM_keepURL, Len(MM_keepURL) - 1)
End If
If (MM_keepForm <> "") Then
  MM_keepForm = Right(MM_keepForm, Len(MM_keepForm) - 1)
End If

' a utility function used for adding additional parameters to these strings
Function MM_joinChar(firstItem)
  If (firstItem <> "") Then
    MM_joinChar = "&"
  Else
    MM_joinChar = ""
  End If
End Function
%>
<!doctype html>
<html><!-- InstanceBegin template="/Templates/temp.dwt.asp" codeOutsideHTMLIsLocked="false" -->
<head>
<%
Dim rsFeedbackID
Dim rsFeedbackID_cmd
Dim rsFeedbackID_numRows

Set rsFeedbackID_cmd = Server.CreateObject ("ADODB.Command")
rsFeedbackID_cmd.ActiveConnection = MM_cn_STRING
rsFeedbackID_cmd.CommandText = "SELECT * FROM dbo.tbFeedback" 
rsFeedbackID_cmd.Prepared = true

Set rsFeedbackID = rsFeedbackID_cmd.Execute
rsFeedbackID_numRows = 0
%>
<%
Dim rsUserID
Dim rsUserID_cmd
Dim rsUserID_numRows

Set rsUserID_cmd = Server.CreateObject ("ADODB.Command")
rsUserID_cmd.ActiveConnection = MM_cn_STRING
rsUserID_cmd.CommandText = "SELECT * FROM dbo.tbUser" 
rsUserID_cmd.Prepared = true

Set rsUserID = rsUserID_cmd.Execute
rsUserID_numRows = 0
%>
<%
' *** Logout the current user.
MM_Logout = CStr(Request.ServerVariables("URL")) & "?MM_Logoutnow=1"
If (CStr(Request("MM_Logoutnow")) = "1") Then
  Session.Contents.Remove("MM_Username")
  Session.Contents.Remove("MM_UserRole")
  Session.Contents.Remove("MM_UserAuthorization")
  MM_logoutRedirectPage = "Home.asp"
  ' redirect with URL parameters (remove the "MM_Logoutnow" query param).
  if (MM_logoutRedirectPage = "") Then MM_logoutRedirectPage = CStr(Request.ServerVariables("URL"))
  If (InStr(1, UC_redirectPage, "?", vbTextCompare) = 0 And Request.QueryString <> "") Then
    MM_newQS = "?"
    For Each Item In Request.QueryString
      If (Item <> "MM_Logoutnow") Then
        If (Len(MM_newQS) > 1) Then MM_newQS = MM_newQS & "&"
        MM_newQS = MM_newQS & Item & "=" & Server.URLencode(Request.QueryString(Item))
      End If
    Next
    if (Len(MM_newQS) > 1) Then MM_logoutRedirectPage = MM_logoutRedirectPage & MM_newQS
  End If
  Response.Redirect(MM_logoutRedirectPage)
End If
%>

	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
	<meta name="author" content="">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/prettyPhoto.css" rel="stylesheet">
    <link href="css/price-range.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
	<link href="css/main.css" rel="stylesheet">
	<link href="css/responsive.css" rel="stylesheet">
	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.scrollUp.min.js"></script>
	<script src="js/price-range.js"></script>
	<script src="js/jquery.prettyPhoto.js"></script>
	<script src="js/main.js"></script>
<!-- InstanceBeginEditable name="doctitle" -->
<title>Gửi Phản Hồi</title>
<script>
function check()
{
	var Summary = document.getElementById("Summary").value;
	var Content = document.getElementById("Content").value;
	
	if(Summary == "")
	{
		alert("Chủ Đề không được để trống!");
		document.getElementById("Summary").focus();
		return false;
	}
	
	if(Summary.length > 20)
	{
		alert("Chủ Đề không được quá 20 ký tự!");
		document.getElementById("Summary").focus();
		document.getElementById("Summary").value = "";
		return false;
	}
	
	if(Content == "")
	{
		alert("Nội Dung không được để trống!");
		document.getElementById("Content").focus();
		return false;
	}
	
	if(Content.length > 500)
	{
		alert("Nội Dung không được quá 500 ký tự!");
		document.getElementById("Content").focus();
		document.getElementById("Content").value = "";
		return false;
	}

	
	return true;
}
</script>
<!-- InstanceEndEditable -->
<!-- InstanceBeginEditable name="head" -->
<!-- InstanceEndEditable -->
</head>
<!-- InstanceBeginEditable name="body" -->
<body>
<!-- InstanceEndEditable -->
	<header id="header"><!--header-->
		<div class="header-middle"><!--header-middle-->
			<div class="container">
				<div class="row">
					<div class="col-sm-2">
							<span style="color:#FE980F;">Paddy </span> Studio
					</div>
                    <div class="col-sm-6">
						<div class="navbar-header">
						</div>
						<div class="mainmenu pull-left">
							<ul class="nav navbar-nav collapse navbar-collapse">
							  	<li><a href="Home.asp">Trang Chủ</a></li>
								<li><a href="Introduction.asp">Giới Thiệu</a></li> 
								<li><a href="Product.asp">Sản Phẩm</a></li>
								<li><a href="EventAndNews.asp">Tin Tức & Sự Kiện</a></li>
                                <li><a href="Contact.asp">Liên Hệ</a></li>
							</ul>
						</div>
					</div>
					<div class="col-sm-4">
						<div class="shop-menu pull-right">
							<ul class="nav navbar-nav">
                                <% 	If(Session("MM_Username") <> "") Then %>
										<li><a> Xin chào, <%=Session("MM_Username")%></a></li>
                                        <% 	If(Session("MM_UserRole") = "1") Then %>
                                        	<li><a href="Admin_Account.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "UserID=" & Session("MM_Username") %>"> Tài Khoản</a></li>
                                        <% 	Else If(Session("MM_UserRole") = "0") Then %>
                                        	<li><a href="User_Account.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "UserID=" & Session("MM_Username") %>"> Tài Khoản</a></li>
                                        	<li><a href="User_Feedback.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "FeedbackMemberID=" & Session("MM_Username") %>"> Phản Hồi</a></li>
                                     	<%	End If %>
                                        <%	End If %>
                                        <li><a href="<%= MM_Logout %>"> Đăng Xuất</a></li>
								<%	Else %>
							  			<li><a href="Register.asp"> Đăng Ký</a></li>
										<li><a href="Login.asp"> Đăng Nhập</a></li>
								<%	End If %>   
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div><!--/header-middle-->
	
		<div class="header-bottom"><!--header-bottom-->
			<div class="container">
				<div class="row">
					<div class="col-sm-9">
						<div class="navbar-header">
						</div>
						<div class="mainmenu pull-left">
							<ul class="nav navbar-nav collapse navbar-collapse">
							  	<li><a href="Home.asp">Trang Chủ</a></li>
								<li><a href="Introduction.asp">Giới Thiệu</a></li> 
								<li><a href="Product.asp">Sản Phẩm</a></li>
								<li><a href="EventAndNews.asp">Tin Tức & Sự Kiện</a></li>
                                <li><a href="Contact.asp">Liên Hệ</a></li>
							</ul>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="search_box pull-right">
                            <form id="form1" name="form1" method="get" action="Result_Search.asp">
                            	<table border="0" cellpadding="0" cellpadding="0">
  										<tr>
    										<td><input type="text" name="txtSearch" id="txtSearch" placeholder="Tìm sản phẩm"/></td>
    										<td><button type="submit" name="btnSearch" id="btnSearch" class="btn search" value="Tìm">Tìm</button></td>
  										</tr>
								</table>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div><!--/header-bottom-->
	</header><!--/header-->
    <!-- InstanceBeginEditable name="Slider" -->
    
    
	<!-- InstanceEndEditable -->
	<section><!--section-->
		<div class="container">
			<div class="row">
				<div class="col-sm-3">
					<div class="left-sidebar">
                        <% 	If(Session("MM_UserRole") = "1") Then %>
                            <div class="brands_products"><!--brands_products-->
								<h2>Ban Quản Trị</h2>
								<div class="brands-name">
									<ul class="nav nav-pills nav-stacked">
                                   		<li>
                                        	<a href="Admin_Home.asp">Trang Chủ Admin</a>
                                            <a href="Admin_ManageBrand.asp">Quản Lý Thương Hiệu</a>
                                            <a href="Admin_ManageProduct.asp">Quản Lý Sản Phẩm</a>
                                          <!--  <a href="#">Quản Lý Bình Luận</a>-->
                                            <a href="Admin_ManageFeedback.asp">Quản Lý Phản Hồi</a>
                                            <a href="Admin_ManageEventAndNews.asp">Quản Lý Tin Tức &amp; Sự Kiện</a>
                                            <a href="Admin_ManageUser.asp">Quản Lý Thành Viên</a>
                                 		</li>
                                	</ul>
								</div>
							</div><!--/brands_products-->
                            <br/><p></p>
                        <%	End If %>
						<div class="brands_products"><!--brands_products-->
							<h2>Thương Hiệu</h2>
							<div class="brands-name">
								<ul class="nav nav-pills nav-stacked">
                                    <% While ((Repeat1__numRows <> 0) AND (NOT rsBrands.EOF)) %>
                                   	<li>
                                        	<a HREF="Product_withBrands.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "BrandName=" & rsBrands.Fields.Item("BrandName").Value %>">
                                            	<span class="pull-right">(<%=(rsBrands.Fields.Item("ProCount").Value)%>)</span>
												<%=(rsBrands.Fields.Item("BrandName").Value)%>
                                   	  </a>
                                 	</li>
                                 	<% 
  										Repeat1__index=Repeat1__index+1
  										Repeat1__numRows=Repeat1__numRows-1
  										rsBrands.MoveNext()
										Wend
									%>
                                </ul>
							</div>
						</div><!--/brands_products-->
						<!-- InstanceBeginEditable name="left" -->
						<!-- InstanceEndEditable -->
					</div>
				</div>
				
				<div class="col-sm-9 padding-right">
					<!-- InstanceBeginEditable name="Content" -->
                    <h2 class="title text-center">Gửi Phản Hồi</h2>
                    <div class="col-sm-12">
                   		<form ACTION="<%=MM_editAction%>" id="form1" name="form1" method="POST" onSubmit="return check()">
                   	  	<table width="100%" border="0" align="center" cellpadding="5" cellspacing="0" bordercolor="#FFFFFF">
        					<tr>
          						<td width="40%" align="right" valign="top"><strong>Chủ Đề:* &nbsp;</strong></td>
          						<td width="60%" align="left" valign="top"><input id="Summary"  name="Summary" type="text" value="" size="30%"/></td>
       						</tr>
                            <tr>
                                <td align="right" valign="top"><strong>Nội Dung:* &nbsp;</strong></td>
                              	<td align="left" valign="top"><textarea id="Content" name="Content" rows="10"></textarea></td>
                            </tr>
                          	<tr>
                                <td align="right" valign="top"><input type="submit" value="Gửi" class="btn search"/></td>
                                <td align="left" valign="top"><input type="reset" value="Hủy" class="btn search"/>&nbsp;&nbsp;<a href="javascript:history.back()" class="btn search">Trở Về</a>
                             	</td>
                          	</tr>
                            <tr>
                                <td align="right" valign="top"><input type="hidden" id="Member" name="Member" value="<%=Session("MM_Username")%>" /></td>
                                <td align="left" valign="top"><strong>(*) - Không Được Để Trống</strong></td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">&nbsp;</td>
                                <td align="left" valign="top">&nbsp;</td>
                            </tr>
   					  	</table>
                        <input type="hidden" name="MM_insert" value="form1">
                        </form>
                    </div>
					<!-- InstanceEndEditable -->
				</div>
			</div>
		</div>
	</section><!--/section-->
    
	<footer id="footer"><!--Footer-->
		<div class="footer-top">
			<div class="container">
				<div class="row">
					<div class="col-sm-5">
						<div class="companyinfo">
							<h2><span>Paddy </span> Studio</h2>
							<p>Đến với Paddy Studio là sự lựa chọn đúng đắn!</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="footer-widget">
			<div class="container">
				<div class="row">
					<div class="col-sm-2">
						<div class="single-widget">
							<h2 style="color:#FE980F;">DỊCH VỤ</h2>
							<ul class="nav nav-pills nav-stacked">
								<li><a href="#">Hỗ Trợ Trực Tuyến</a></li>
								<li><a href="#">Liên Hệ</a></li>
								<li><a href="#">Câu Hỏi Thường Gặp</a></li>
							</ul>
						</div>
					</div>
					
					<div class="col-sm-2">
						<div class="single-widget">
							<h2 style="color:#FE980F;">CHÍNH SÁCH</h2>
							<ul class="nav nav-pills nav-stacked">
								<li><a href="#">Điều Khoản Sử Dụng</a></li>
								<li><a href="#">Chính Sách Bảo Mật</a></li>
							</ul>
						</div>
					</div>
					<div class="col-sm-2">
						<div class="single-widget">
							<h2 style="color:#FE980F;">VỀ CHÚNG TÔI</h2>
							<ul class="nav nav-pills nav-stacked">
                            	<li><a href="#">Về Paddy Studio</a></li>								
								<li><a href="#">Nghề Nghiệp</a></li>
								<li><a href="#">Chương Trình Liên Kết</a></li>
								<li><a href="#">Bản Quyền</a></li>
							</ul>
						</div>
					</div>
					
                    <div class="col-sm-5 col-sm-offset-1">
						<div class="single-widget">
							<h2 style="color:#FE980F;">LIÊN KẾT</h2>
							<form action="#" class="searchform">
                            	<p>Đăng ký nhận thông tin sự kiện mới nhất từ chúng tôi</p>
                                <div>
                                	<table border="0" cellpadding="0" cellpadding="0">
  										<tr>
    										<td><input type="text" placeholder="Email của bạn" /></td>
    										<td><button type="submit" class="btn search">Subscribe</button></td>
  										</tr>
									</table>
                                </div>
								<p><i>Thông tin của bạn sẽ được bảo mật tuyệt đối <br/> và bạn có thể hủy đăng ký bất cứ lúc nào.</i></p>
							</form>
						</div>
					</div>
					
				</div>
			</div>
		</div>
		
		<div class="footer-bottom">
			<div class="container">
				<div class="row">
					<p class="pull-left">Copyright 2016-2018 Paddy Studio. All rights reserved.</p>
					<p class="pull-right">Designed by <span> Group 2 - Paddy Studio</span></p>
				</div>
			</div>
		</div>
		
	</footer><!--/Footer-->

</body>
<!-- InstanceEnd --></html>
<%
rsBrands.Close()
Set rsBrands = Nothing
%>
<%
rsUserID.Close()
Set rsUserID = Nothing
%>
<%
rsFeedbackID.Close()
Set rsFeedbackID = Nothing
%>
