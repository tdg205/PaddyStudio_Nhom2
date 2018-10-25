<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/cn.asp" -->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="True"
MM_authFailedURL="Admin_Login.asp"
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
' IIf implementation
Function MM_IIf(condition, ifTrue, ifFalse)
  If condition = "" Then
    MM_IIf = ifFalse
  Else
    MM_IIf = ifTrue
  End If
End Function
%>
<%
If (CStr(Request("MM_update")) = "form1") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_cn_STRING
    MM_editCmd.CommandText = "UPDATE dbo.tbProduct SET ProductName = ?, ProductImage = ?, ProductDescription = ?, Price = ?, WarrantyTime = ?, ManufacturerYear = ?, BrandName = ? WHERE ProductID = ?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 201, 1, 50, Request.Form("ProductName")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 201, 1, 200, Request.Form("ProductImage")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 500, Request.Form("ProductDescription")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 201, 1, 20, Request.Form("Price")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 5, 1, -1, MM_IIF(Request.Form("WarrantyTime"), Request.Form("WarrantyTime"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 5, 1, -1, MM_IIF(Request.Form("ManufacturerYear"), Request.Form("ManufacturerYear"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 201, 1, 20, Request.Form("BrandName")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 5, 1, -1, MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null)) ' adDouble
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "Admin_ManageProduct.asp"
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
Dim rsUpdateProduct__MMColParam
rsUpdateProduct__MMColParam = "1"
If (Request.QueryString("ProductID") <> "") Then 
  rsUpdateProduct__MMColParam = Request.QueryString("ProductID")
End If
%>
<%
Dim rsUpdateProduct
Dim rsUpdateProduct_cmd
Dim rsUpdateProduct_numRows

Set rsUpdateProduct_cmd = Server.CreateObject ("ADODB.Command")
rsUpdateProduct_cmd.ActiveConnection = MM_cn_STRING
rsUpdateProduct_cmd.CommandText = "SELECT * FROM dbo.tbProduct WHERE ProductID = ?" 
rsUpdateProduct_cmd.Prepared = true
rsUpdateProduct_cmd.Parameters.Append rsUpdateProduct_cmd.CreateParameter("param1", 5, 1, -1, rsUpdateProduct__MMColParam) ' adDouble

Set rsUpdateProduct = rsUpdateProduct_cmd.Execute
rsUpdateProduct_numRows = 0
%>
<%
Dim rsBrandList
Dim rsBrandList_cmd
Dim rsBrandList_numRows

Set rsBrandList_cmd = Server.CreateObject ("ADODB.Command")
rsBrandList_cmd.ActiveConnection = MM_cn_STRING
rsBrandList_cmd.CommandText = "SELECT * FROM dbo.tbBrand" 
rsBrandList_cmd.Prepared = true

Set rsBrandList = rsBrandList_cmd.Execute
rsBrandList_numRows = 0
%>
<%
Dim rsUpdate__MMColParam
rsUpdate__MMColParam = "1"
If (Request.QueryString("ProductID") <> "") Then 
  rsUpdate__MMColParam = Request.QueryString("ProductID")
End If
%>
<%
Dim rsUpdate
Dim rsUpdate_cmd
Dim rsUpdate_numRows

Set rsUpdate_cmd = Server.CreateObject ("ADODB.Command")
rsUpdate_cmd.ActiveConnection = MM_cn_STRING
rsUpdate_cmd.CommandText = "SELECT * FROM dbo.tbProduct WHERE ProductID = ?" 
rsUpdate_cmd.Prepared = true
rsUpdate_cmd.Parameters.Append rsUpdate_cmd.CreateParameter("param1", 5, 1, -1, rsUpdate__MMColParam) ' adDouble

Set rsUpdate = rsUpdate_cmd.Execute
rsUpdate_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
rsBrands_numRows = rsBrands_numRows + Repeat1__numRows
%>
<%
Dim Repeat2__numRows
Dim Repeat2__index

Repeat2__numRows = 10
Repeat2__index = 0
rsUpdateProduct_numRows = rsUpdateProduct_numRows + Repeat2__numRows
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
<title>Cập Nhật Sản Phẩm</title>
<STYLE type="text/css">
.showMsg {
	font-family: verdana;
	font-size: 10px;
	color: red;
	display: none;
}
</STYLE>
<script>
function confirmUpdate()
{
	if(confirm("Bạn muốn cập nhật thông tin Sản Phẩm ?")){
		return true;
	} else {
		return false;
	}
}

function change_price()
{
	var Price = document.getElementById("Price").value;
	//alert(Number(Price));
	if(!isNaN(Number(Price))){		
		var chPrice = "";
		var count = Price.length;
		for(count; ;count=count-3){
			if(count<=3){
				//substring(bengin, end)
				var subPrice = Price.substring(0, count);
				chPrice = subPrice + chPrice;
				break;
			} else {		
				//substr(bengin, length)	
				var subPrice = Price.substr(count-3, 3);
				chPrice = "." + subPrice + chPrice;	
				//alert(subPrice);		
			}					
		}
		//alert(chPrice);
		document.getElementById("Price").value = chPrice;
	}
}

function cut_string()
{
	var s = new String(document.getElementById("fileImage").value);
	var p = s.lastIndexOf("\\"); 
	/*Tra ve vi tri cuoi cua item dang tim kiem.Tra ve -1 neu ko co*/
	var name = s.substr(p+1);
	/*Tra ve vi tri loai file cua name*/
	p = name.lastIndexOf("\.");
	var tof = name.substr(p+1);//Tra ve duoi bmp/ png/ jpg...
	tof = tof.toLowerCase();
	if((tof != 'jpg') && (tof != 'jpeg') && (tof != 'gif') && (tof != 'bmp')&& (tof != 'png')){
		alert("Hãy chọn file ảnh có định dạng *.gif, *.jpg, *.bmp, *.jpeg, *.png.");
		document.getElementById("fileImage").value = "";
		return false;
	} else {
		document.getElementById("ProductImage").value = name;
		document.getElementById("fieldImage").src = "images\\product\\" + name;
	}
}

function check()
{
	var ProductName = document.getElementById("ProductName").value;
	var ProductImage = document.getElementById("ProductImage").value;
	var ProductDescription = document.getElementById("ProductDescription").value;
	var Price = document.getElementById("Price").value;
	var WarrantyTime = document.getElementById("WarrantyTime").value;
	var ManufacturerYear = document.getElementById("ManufacturerYear").value;

/*	Check Product Name
	- Không được rỗng
 	- Nhỏ hơn hoặc bằng 50 ký tự
	 /^[a-zA-Z][\w\s\-/.()]+$/;
	- Bắt đầu bằng 1 chữ cái hoa hoặc thường
	- Ký tự còn lại chứa: chữ hoa hoặc thường hoặc dấu gạch dưới 
	hoặc số, khoảng trắng, dấu gạch ngang, dấu /, dấu . hoặc dấu ()*/
	if(ProductName == "")
	{
		document.getElementById("errProductName1").style.display = "inline";
		document.getElementById("ProductName").style.border = "1px solid #e00";
		document.getElementById("ProductName").focus();
		return false;
	} else {
		document.getElementById("errProductName1").style.display = "none";
		document.getElementById("ProductName").style.border = "1px solid #d6d6d6";		
	}
	
	if(ProductName.length < 3 || ProductName.length > 50)
	{
		document.getElementById("errProductName2").style.display = "inline";
		document.getElementById("ProductName").style.border = "1px solid #e00";
		document.getElementById("ProductName").focus();
		return false;
	} else {
		document.getElementById("errProductName2").style.display = "none";
		document.getElementById("ProductName").style.border = "1px solid #d6d6d6";		
	} 
	
	var re_ProductName = /^[a-zA-Z][\w\s\-\/\.\(\)]+$/;												
	if(re_ProductName.test(ProductName) == false){
		document.getElementById("errProductName3").style.display = "inline";
		document.getElementById("ProductName").style.border = "1px solid #e00";
		document.getElementById("ProductName").focus();
		return false;	
	} else {
		document.getElementById("errProductName3").style.display = "none";
		document.getElementById("ProductName").style.border = "1px solid #d6d6d6";		
	} 
	
/*	Check Product Image
	- Tên hình ảnh không được quá 200 ký tự
	- Không được để trống
	- Băt đuôi ảnh /(\.jpg|\.jpeg|\.png|\.gif|\.bmp)$/;
	- Chọn file trong folder image/product*/
	if(ProductImage == "")
	{
		document.getElementById("errProductImage1").style.display = "inline";
		document.getElementById("ProductImage").style.border = "1px solid #e00";
		document.getElementById("fileImage").focus();
		return false;
	} else {
		document.getElementById("errProductImage1").style.display = "none";
		document.getElementById("ProductImage").style.border = "1px solid #d6d6d6";		
	}
	
	if(ProductImage.length > 200)
	{
		document.getElementById("errProductImage2").style.display = "inline";
		document.getElementById("ProductImage").style.border = "1px solid #e00";
		document.getElementById("fileImage").focus();
		document.getElementById("fileImage").value = "";
		return false;
	} else {
		document.getElementById("errProductImage2").style.display = "none";
		document.getElementById("ProductImage").style.border = "1px solid #d6d6d6";		
	}

	/*Mô tả sản phẩm:
	- Không rỗng
	- Độ dài không lớn hơn 1000*/
	if(ProductDescription == "")
	{
		document.getElementById("errProductDescription1").style.display = "inline";
		document.getElementById("ProductDescription").style.border = "1px solid #e00";
		document.getElementById("ProductDescription").focus();
		return false;
	} else {
		document.getElementById("errProductDescription1").style.display = "none";
		document.getElementById("ProductDescription").style.border = "1px solid #d6d6d6";		
	}
	
	if(ProductDescription.length > 1000)
	{
		document.getElementById("errProductDescription2").style.display = "inline";
		document.getElementById("ProductDescription").style.border = "1px solid #e00";
		document.getElementById("ProductDescription").focus();
		return false;
	} else {
		document.getElementById("errProductDescription2").style.display = "none";
		document.getElementById("ProductDescription").style.border = "1px solid #d6d6d6";		
	}
	
	/*Giá:
	- Không trống
	- Phải là số
	- Phải lớn hơn hoặc bằng 0
	- Không lớn hơn 200 triệu*/
	//string.replace(chuoicantim,chuoithaythe);
	for(var i=0; i<Price.length; i++) {	 
		Price = Price.replace(".","");	 
	}
	//alert(Price);	
	if(Price == "")
	{
		document.getElementById("errPrice1").style.display = "inline";
		document.getElementById("Price").style.border = "1px solid #e00";
		document.getElementById("Price").focus();
		return false;
	} else {
		document.getElementById("errPrice1").style.display = "none";
		document.getElementById("Price").style.border = "1px solid #d6d6d6";		
	}
	
	if(isNaN(Price))
	{
		document.getElementById("errPrice2").style.display = "inline";
		document.getElementById("Price").style.border = "1px solid #e00";
		document.getElementById("Price").focus();
		document.getElementById("Price").value = "";
		return false;
	} else {
		document.getElementById("errPrice2").style.display = "none";
		document.getElementById("Price").style.border = "1px solid #d6d6d6";		
	}
	
	if(Price < 0)
	{
		document.getElementById("errPrice3").style.display = "inline";
		document.getElementById("Price").style.border = "1px solid #e00";
		document.getElementById("Price").focus();
		document.getElementById("Price").value = "";
		return false;
	} else {
		document.getElementById("errPrice3").style.display = "none";
		document.getElementById("Price").style.border = "1px solid #d6d6d6";		
	}
	
	if(Price > 200000000)
	{
		document.getElementById("errPrice4").style.display = "inline";
		document.getElementById("Price").style.border = "1px solid #e00";
		document.getElementById("Price").focus();
		document.getElementById("Price").value = "";
		return false;
	} else {
		document.getElementById("errPrice4").style.display = "none";
		document.getElementById("Price").style.border = "1px solid #d6d6d6";		
	}
	
	/*Bảo hành:
	- Không được rỗng.
	- Phải là kiểu số.
	- Phải từ 0 đến 36.*/	
	if(WarrantyTime == "")
	{
		document.getElementById("errWarrantyTime1").style.display = "inline";
		document.getElementById("WarrantyTime").style.border = "1px solid #e00";
		document.getElementById("WarrantyTime").focus();
		return false;
	} else {
		document.getElementById("errWarrantyTime1").style.display = "none";
		document.getElementById("WarrantyTime").style.border = "1px solid #d6d6d6";		
	}
	
	if(isNaN(WarrantyTime))
	{
		document.getElementById("errWarrantyTime2").style.display = "inline";
		document.getElementById("WarrantyTime").style.border = "1px solid #e00";
		document.getElementById("WarrantyTime").focus();
		document.getElementById("WarrantyTime").value = "";
		return false;
	} else {
		document.getElementById("errWarrantyTime2").style.display = "none";
		document.getElementById("WarrantyTime").style.border = "1px solid #d6d6d6";		
	}
	
	if(WarrantyTime < 0)
	{
		document.getElementById("errWarrantyTime3").style.display = "inline";
		document.getElementById("WarrantyTime").style.border = "1px solid #e00";
		document.getElementById("WarrantyTime").focus();
		return false;
	} else {
		document.getElementById("errWarrantyTime3").style.display = "none";
		document.getElementById("WarrantyTime").style.border = "1px solid #d6d6d6";		
	}
	
	if(WarrantyTime > 36)
	{
		document.getElementById("errWarrantyTime4").style.display = "inline";
		document.getElementById("WarrantyTime").style.border = "1px solid #e00";
		document.getElementById("WarrantyTime").focus();
		return false;
	} else {
		document.getElementById("errWarrantyTime4").style.display = "none";
		document.getElementById("WarrantyTime").style.border = "1px solid #d6d6d6";		
	}
	
	/*Năm sản xuất:
	- Không được trống
	- Phải là số
	- Phải từ năm 2010 đến nay*/	
	if(ManufacturerYear == "")
	{
		document.getElementById("errManufacturerYear1").style.display = "inline";
		document.getElementById("ManufacturerYear").style.border = "1px solid #e00";
		document.getElementById("ManufacturerYear").focus();
		return false;
	} else {
		document.getElementById("errManufacturerYear1").style.display = "none";
		document.getElementById("ManufacturerYear").style.border = "1px solid #d6d6d6";		
	}
	
	if(isNaN(ManufacturerYear))
	{
		document.getElementById("errManufacturerYear2").style.display = "inline";
		document.getElementById("ManufacturerYear").style.border = "1px solid #e00";
		document.getElementById("ManufacturerYear").focus();
		document.getElementById("ManufacturerYear").value = "";
		return false;
	} else {
		document.getElementById("errManufacturerYear2").style.display = "none";
		document.getElementById("ManufacturerYear").style.border = "1px solid #d6d6d6";		
	}
	
	var n = new Date().getFullYear();
	if(ManufacturerYear < 2010 || ManufacturerYear > n)
	{
		document.getElementById("errManufacturerYear3").style.display = "inline";
		document.getElementById("ManufacturerYear").style.border = "1px solid #e00";
		document.getElementById("ManufacturerYear").focus();
		document.getElementById("ManufacturerYear").value = "";
		return false;
	} else {
		document.getElementById("errManufacturerYear3").style.display = "none";
		document.getElementById("ManufacturerYear").style.border = "1px solid #d6d6d6";		
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
      <div class="row"><a class="ps-logo" href="Home.asp" style="color:white;"><span style="color:#429DF1;">Paddy</span>Studio</a>
        <div class="mainmenu pull-left">
          <ul class="nav navbar-nav collapse navbar-collapse">
            <li><a href="Introduction.asp">Giới Thiệu</a></li>
            <li><a href="Product.asp">Sản Phẩm</a></li>
            <li><a href="EventAndNews.asp">Tin Tức</a></li>
            <li><a href="Contact.asp">Liên Hệ</a></li>
          </ul>
        </div>
        <div class="shop-menu pull-right">
          <ul class="nav navbar-nav">
            <% 	If(Session("MM_Username") <> "") Then %>
            
            <% 	If(Session("MM_UserRole") = "1") Then %>
            <li><a href="Admin_Account.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "UserID=" & Session("MM_Username") %>">Xin chào,  <%=Session("MM_Username")%></a></li>
            <% 	Else If(Session("MM_UserRole") = "0") Then %>
            <li><a href="User_Account.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "UserID=" & Session("MM_Username") %>">Xin chào,  <%=Session("MM_Username")%></a></li>
            <li><a href="User_Feedback.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "FeedbackMemberID=" & Session("MM_Username") %>">Phản Hồi</a></li>
            <%	End If %>
            <%	End If %>
            <li><a href="<%= MM_Logout %>">Đăng Xuất</a></li>
            <%	Else %>
            <li><a href="Register.asp">Đăng Ký</a></li>
            <li><a href="Login.asp">Đăng Nhập</a></li>
            <%	End If %>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <!--/header-middle-->
  <!--header-bottom-->
  <div class="header-bottom">
    <div class="container">
      <div class="row">
        <!--/*<div class="col-sm-9">
          <div class="navbar-header"></div>
          <div class="mainmenu pull-left">
            <ul class="nav navbar-nav collapse navbar-collapse">
              <li><a href="../Introduction.asp">Giới Thiệu</a></li>
              <li><a href="../Product.asp">Sản Phẩm</a></li>
              <li><a href="../EventAndNews.asp">Tin Tức</a></li>
              <li><a href="../Contact.asp">Liên Hệ</a></li>
            </ul>
          </div>
        </div>*/-->
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
  <!--/header-bottom-->
</header>
<!--/header-->

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
                <li><a href="Admin_Home.asp">Trang Chủ Admin</a><a href="Admin_ManageBrand.asp">Quản Lý Thương Hiệu</a><a href="Admin_ManageProduct.asp">Quản Lý Sản Phẩm</a><a href="Admin_ManageFeedback.asp">Quản Lý Phản Hồi</a><a href="Admin_ManageEventAndNews.asp">Quản Lý Tin Tức &amp; Sự Kiện</a><a href="Admin_ManageUser.asp">Quản Lý Thành Viên</a></li>
              </ul>
            </div>
          </div>
          <!--/brands_products-->
          <br/>
          <p></p>
          <%	End If %>
          <div class="brands_products"><!--brands_products-->
            <h2>Thương Hiệu</h2>
            <div class="brands-name">
              <ul class="nav nav-pills nav-stacked">
                <% While ((Repeat1__numRows <> 0) AND (NOT rsBrands.EOF)) %>
                  <li><a HREF="Product_withBrands.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "BrandName=" & rsBrands.Fields.Item("BrandName").Value %>"><span class="pull-right">(<%=(rsBrands.Fields.Item("ProCount").Value)%>)</span><%=(rsBrands.Fields.Item("BrandName").Value)%></a></li>
                  <% 
					Repeat1__index=Repeat1__index+1
					Repeat1__numRows=Repeat1__numRows-1
					rsBrands.MoveNext()
					Wend
				%>
              </ul>
            </div>
          </div>
          <!--/brands_products-->
          <!-- InstanceBeginEditable name="left" -->
          <!-- InstanceEndEditable -->
        </div>
      </div>
      <div class="col-sm-9 padding-right">
        <!-- InstanceBeginEditable name="Content" -->
        <h2 class="title text-center">Cập Nhật Sản Phẩm</h2>
        <div class="col-sm-12">
          <form ACTION="<%=MM_editAction%>" id="form1" name="form1" method="POST" onSubmit="return check()">
            <table width="100%" border="0" align="center" cellpadding="5" cellspacing="0" bordercolor="#FFFFFF">
              <% While ((Repeat2__numRows <> 0) AND (NOT rsUpdateProduct.EOF)) %>
                <tr>
                  <td width="40%" align="right" valign="top"><strong>Tên Sản Phẩm:* &nbsp;</strong></td>
                  <td width="60%" align="left" valign="top"><input id="ProductName" name="ProductName" type="text" size="35" value="<%=(rsUpdateProduct.Fields.Item("ProductName").Value)%>"/>
                  <br/>
                  <div class="showMsg" id="errProductName1">Tên Sản Phẩm không được để trống.</div>
                  <div class="showMsg" id="errProductName2">Tên Sản Phẩm phải từ 3 đến 50 ký tự.</div>
                  <div class="showMsg" id="errProductName3">Tên Sản Phẩm phải bắt đầu bằng 1 ký tự chữ cái tiếng Anh. Ký tự còn lại chỉ chứa: chữ cái tiếng Anh, dấu gạch dưới, chữ số, khoảng trắng, dấu gạch ngang, dấu /, dấu chấm, dấu ().</div></td>
                </tr>
                <tr>
                  <td align="right" valign="top"><strong>Hình Ảnh:* &nbsp;</strong></td>
                  <td align="left" valign="top"><input name="fieldImage" id="fieldImage" type="image" src="images/product/<%=(rsUpdateProduct.Fields.Item("ProductImage").Value)%>" width="200" height="200"/>
                    <br/>
                    <input name="ProductImage" id="ProductImage" type="text" value="<%=(rsUpdateProduct.Fields.Item("ProductImage").Value)%>" readonly/>
                    <br/>
                    <br/>
                    <input name="fileImage" id="fileImage" type="file" accept=".jpg, .jpeg, .png, .gif, .bmp" onChange="cut_string()">
                    <br/>
                  <div class="showMsg" id="errProductImage1">Hãy lựa chọn một Hình Ảnh.</div>
                  <div class="showMsg" id="errProductImage2">Tên Hình Ảnh không được quá 200 ký tự.</div>
                    </td>
                </tr>
                <tr>
                  <td align="right" valign="top"><strong>Mô Tả:* &nbsp;</strong></td>
                  <td align="left" valign="top"><textarea id="ProductDescription" name="ProductDescription" cols="32" rows="12" ><%=(rsUpdateProduct.Fields.Item("ProductDescription").Value)%></textarea>
                   <br/>
                  <div class="showMsg" id="errProductDescription1">Mô Tả không được để trống.</div>
                  <div class="showMsg" id="errProductDescription2">Mô Tả không được quá 1000 ký tự.</div>
                  </td>
                </tr>
                <tr>
                  <td align="right" valign="top"><strong>Giá (VNĐ):* &nbsp;</strong></td>
                  <td align="left" valign="top"><input id="Price" name="Price" type="text" size="35" value="<%=(rsUpdateProduct.Fields.Item("Price").Value)%>" onChange="change_price()"/>
                  <br/>
                  <div class="showMsg" id="errPrice1">Giá (VNĐ) không được để trống.</div>
                  <div class="showMsg" id="errPrice2">Giá (VNĐ) phải là kiểu số.</div>
                  <div class="showMsg" id="errPrice3">Giá (VNĐ) phải lớn hơn hoặc bằng 0.</div>
                  <div class="showMsg" id="errPrice4">Giá (VNĐ) không được lớn hơn 200 triệu.</div>
                  </td>
                </tr>
                <tr>
                  <td align="right" valign="top"><strong>Bảo Hành (Tháng):* &nbsp;</strong></td>
                  <td align="left" valign="top"><input id="WarrantyTime" name="WarrantyTime" type="text" size="35" value="<%=(rsUpdateProduct.Fields.Item("WarrantyTime").Value)%>" />
                   <br/>
                  <div class="showMsg" id="errWarrantyTime1">Bảo Hành (Tháng) không được để trống.</div>
                  <div class="showMsg" id="errWarrantyTime2">Bảo Hành (Tháng) phải là kiểu số.</div>
                  <div class="showMsg" id="errWarrantyTime3">Bảo Hành (Tháng) phải lớn hơn hoặc bằng 0.</div>
                  <div class="showMsg" id="errWarrantyTime4">Bảo Hành (Tháng) không được quá 36 tháng.</div>
                  </td>
                </tr>
                <tr>
                  <td align="right" valign="top"><strong>Năm Sản Xuất:* &nbsp;</strong></td>
                  <td align="left" valign="top"><input id="ManufacturerYear" name="ManufacturerYear" type="text" size="35" value="<%=(rsUpdateProduct.Fields.Item("ManufacturerYear").Value)%>" />
                  <br/>
                  <div class="showMsg" id="errManufacturerYear1">Năm Sản Xuất không được để trống.</div>
                  <div class="showMsg" id="errManufacturerYear2">Năm Sản Xuất phải là kiểu số.</div>
                  <div class="showMsg" id="errManufacturerYear3">Năm Sản Xuất phải từ 2010 đến năm hiện hành.</div>
                  </td>
                </tr>
                <tr>
                  <td align="right" valign="top"><strong>Tên Thương Hiệu: &nbsp;</strong></td>
                  <td align="left" valign="top"><select id="BrandName" name="BrandName" >
                      <%
									While (NOT rsBrandList.EOF)
								%>
                      <option value="<%=(rsBrandList.Fields.Item("BrandName").Value)%>" <%If (Not isNull((rsUpdateProduct.Fields.Item("BrandName").Value))) Then If (CStr(rsBrandList.Fields.Item("BrandName").Value) = CStr((rsUpdateProduct.Fields.Item("BrandName").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(rsBrandList.Fields.Item("BrandName").Value)%></option>
                      <%
  									rsBrandList.MoveNext()
									Wend
									If (rsBrandList.CursorType > 0) Then
  										rsBrandList.MoveFirst
									Else
  										rsBrandList.Requery
									End If
								%>
                    </select></td>
                </tr>
                <tr>
                  <td align="right" valign="top"><input type="submit" id="btnUpdate" name="btnUpdate" value="Cập Nhật" class="btn search" onClick="return confirmUpdate()"/></td>
                  <td align="left" valign="top"><!--<input type="reset" value="Hủy" class="btn search"/>&nbsp;&nbsp;--><a href="javascript:history.back()" class="btn search">Trở Về</a></td>
                </tr>
                <tr>
                  <td align="right" valign="top">&nbsp;</td>
                  <td align="left" valign="top"><strong><b>(*) : Không Được Để Trống</strong></td>
                </tr>
                <tr>
                  <td align="right" valign="top">&nbsp;</td>
                  <td align="left" valign="top"><input id="ProductName1" name="ProductName1" type="hidden" size="35" value="<%=(rsUpdateProduct.Fields.Item("ProductName").Value)%>"/></td>
                </tr>
                <% 
  								Repeat2__index=Repeat2__index+1
  								Repeat2__numRows=Repeat2__numRows-1
  								rsUpdateProduct.MoveNext()
								Wend
							%>
            </table>
            <input type="hidden" name="MM_update" value="form1">
            <input type="hidden" name="MM_recordId" value="<%= rsUpdate.Fields.Item("ProductID").Value %>">
          </form>
        </div>
        <!-- InstanceEndEditable -->
      </div>
    </div>
  </div>
</section>
<!--/section-->
<footer id="footer"><!--Footer-->
  <div class="footer-top">
    <div class="container">
      <div class="row">
        <div class="col-sm-5">
          <div class="companyinfo">
            <h2><span>Paddy</span>Studio</h2>
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
            <h2 style="color:#429DF1;">DỊCH VỤ</h2>
            <ul class="nav nav-pills nav-stacked">
              <li><a href="#">Hỗ Trợ Trực Tuyến</a></li>
              <li><a href="#">Liên Hệ</a></li>
              <li><a href="#">Câu Hỏi Thường Gặp</a></li>
            </ul>
          </div>
        </div>
        <div class="col-sm-2">
          <div class="single-widget">
            <h2 style="color:#429DF1;">CHÍNH SÁCH</h2>
            <ul class="nav nav-pills nav-stacked">
              <li><a href="#">Điều Khoản Sử Dụng</a></li>
              <li><a href="#">Chính Sách Bảo Mật</a></li>
            </ul>
          </div>
        </div>
        <div class="col-sm-2">
          <div class="single-widget">
            <h2 style="color:#429DF1;">VỀ CHÚNG TÔI</h2>
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
            <h2 style="color:#429DF1;">LIÊN KẾT</h2>
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
              <p><i>Thông tin của bạn sẽ được bảo mật tuyệt đối<br/>
                và bạn có thể hủy đăng ký bất cứ lúc nào.</i></p>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="footer-bottom">
    <div class="container">
      <div class="row">
        <p class="pull-left">Copyright 2016 - 2018 Paddy Studio. All rights reserved.</p>
        <p class="pull-right">Designed by <span>Group 2 - Paddy Studio</span></p>
      </div>
    </div>
  </div>
</footer>
<!--/Footer-->

</body>
<!-- InstanceEnd --></html>
<%
rsBrands.Close()
Set rsBrands = Nothing
%>
<%
rsUpdateProduct.Close()
Set rsUpdateProduct = Nothing
%>
<%
rsBrandList.Close()
Set rsBrandList = Nothing
%>
<%
rsUpdate.Close()
Set rsUpdate = Nothing
%>
