<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - VNT 客户端</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<link rel="shortcut icon" href="images/favicon.ico">
<link rel="icon" href="images/favicon.png">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/main.css">
<script type="text/javascript" src="/jquery.js"></script>
<script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/state.js"></script>
<script type="text/javascript" src="/general.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script type="text/javascript" src="/help.js"></script>
<script>
<% <% vnt_status(); %> %>
var $j = jQuery.noConflict();
function initial(){
	show_banner(2);
	show_menu(5, 15, 1);
	show_footer();
	var st = vnt_status();
	$("svc_status").innerHTML = st ? '<span class="label label-success">运行中</span>' : '<span class="label label-warning">已停止</span>';
}
function submitAction(v){
	showLoading();
	document.form.connect_action.value = v;
	document.form.submit();
}
</script>
</head>
<body onload="initial();" onunLoad="return unload_body();">
<div class="wrapper"><div class="container-fluid" style="padding-right: 0px"><div class="row-fluid"><div class="span3"><center><div id="logo"></div></center></div><div class="span9"><div id="TopBanner"></div></div></div></div></div>
<div id="Loading" class="popup_bg"></div>
<iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>
<form method="post" name="form" id="ruleForm" action="VNT_action.asp" target="hidden_frame">
<input type="hidden" name="connect_action" value="">
<div class="container-fluid"><div class="row-fluid"><div class="span3"><div class="well sidebar-nav side_nav" style="padding: 0px;"><ul id="mainMenu" class="clearfix"></ul><ul class="clearfix"><li><div id="subMenu" class="accordion"></div></li></ul></div></div><div class="span9"><div class="row-fluid"><div class="span12"><div class="box well grad_colour_dark_blue"><h2 class="box_head round_top">VNT 客户端</h2><div class="round_bottom"><div id="tabMenu" class="submenuBlock"></div>
<table width="100%" cellpadding="4" cellspacing="0" class="table">
<tr><th width="30%">运行状态</th><td id="svc_status"></td></tr>
<tr><th>操作</th><td>
<input type="button" class="btn btn-info" value="保存" onclick="submitAction('Save');">
<input type="button" class="btn btn-success" value="保存并应用" onclick="submitAction('SaveApply');">
<input type="button" class="btn" value="启动/重启" onclick="submitAction('Restart');">
<input type="button" class="btn btn-danger" value="停止" onclick="submitAction('Stop');">
</td></tr>
<tr><th>配置文件</th><td><textarea name="config_text" rows="22" style="width: 98%; font-family: monospace; font-size: 12px;"><% vnt_config(); %></textarea><br><small>保存后写入 /etc/storage 下的配置文件，重启路由器仍保留。</small></td></tr>
</table>
</div></div></div></div></div></div></div>
</form>
</div>
</body>
</html>
