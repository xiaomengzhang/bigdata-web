<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script src="http://www.bloomberg.com/jscommon/calculators/finance.js" language="javascript"></script>
<script src="http://www.bloomberg.com/jscommon/calculators/mktscurrcalc.js" language="javascript"></script>
<script src="http://www.bloomberg.com/jscommon/calculators/currdata.js" language="javascript"></script>
<script type="text/javascript">
function loadResults_my(){
if ((navigator.appName.indexOf("Netscape") != -1)&& (parseInt(navigator.appVersion) == 4)) {
   document.write('<DIV ID="crncyres2" style="width:250px; height:9px;color:#FF0000; margin:15px 30px;"></DIV>');
} 
else {
   document.write('<DIV ID="crncyres" style="width:250px; height:9px;color:#FF0000;margin:15px 30px;"></DIV>');
}
}
function ShowResult_my(fromval, toval, amount)
{
var totval = amount * toval / fromval;   //total conversion rate
    var select1 = document.currcalc.from_tkc; //Base currency name from the HTML form
    var select2 = document.currcalc.to_tkc;   //"Convert into" currency name from the HTML form
var translate = document.currcalc.translation.value;
var all_results =amount+" " 
     + select1.options[select1.selectedIndex].text 
     + ' = ' + round(totval)+" " 
     + select2.options[select2.selectedIndex].text;

//Print the results in Netscape 4.x versions
if ((navigator.appName.indexOf("Netscape") != -1)&& (parseInt(navigator.appVersion) == 4)) {
    var reslayer = document.layers['crncyres2'].document;
    reslayer.open();
    reslayer.write(all_results);
    reslayer.close();
     } 
//Print the results in IE and Netscape 6.x versions
else if ((navigator.appName.indexOf("Microsoft") != -1) || 
    (parseInt(navigator.appVersion) >= 5)){
    document.getElementById("crncyres").innerHTML = all_results;
    } 
//Print an error message for other browsers not supporting the DOM
else {
   alert(errmsg3);
}
}
function calculate()
{
    var select1 = document.currcalc.from_tkc; 
    var select2 = document.currcalc.to_tkc;    
    var select1_text = select1[select1.selectedIndex].text;
    var select2_text = select2[select2.selectedIndex].text;
    var fromval;    //Value of the currency to be converted
    var toval;        //Value of the currency to convert into
    //These error messages are hidden values in the HTML page
    //They get translated into foreign languages
    var errmsg1 = document.currcalc.translation1.value;
    var errmsg2 = document.currcalc.translation2.value;
    var errmsg3 = document.currcalc.translation3.value;
      //calculate the fixed Euro value
     if (select1_text.match(/\(EUR\)/) != null)
     {
         var temp = select2_text.split("(");
         var lastsplit = temp.length - 1;
         var result = temp[lastsplit].match(/(FRF|ATS|PTE|ESP|BEF|NLG|FIM|DEM|IEP|ITL|LUF|GRD)/);
         if (result != null)
         {
            fromval = 1;
            toval = eurovals[result[0]];
         }
     }
    
      //calculate the fixed Euro value
     if (select2_text.match(/\(EUR\)/) != null)
     {
         var tmp = select1_text.split("(");
        var lstsplit = tmp.length - 1;
        var result = tmp[lstsplit].match(/(FRF|ATS|PTE|ESP|BEF|NLG|FIM|DEM|IEP|ITL|LUF|GRD)/);
         if (result != null)
         {
            toval = 1;
            fromval = eurovals[result[0]];
        }
     }
    
     //set the prices
     if (fromval == null && toval == null)            
     {
           fromval = price[select1[select1.selectedIndex].value];
          toval = price[select2[select2.selectedIndex].value];
        
     }
    
     //check to make sure that there is a valid price/ valid currency for each
     if ((fromval < 0) || (fromval == "") || isNaN(fromval) || (toval < 0) || (toval == "") || isNaN(toval)){
        alert(errmsg1);
        return false;
     }
    //assign the amount and check that it is valid, remove any punctuation
    //amount is the number of the base currency units specified by the user
    var amount = document.currcalc.amount.value;
    if ((amount == "") || isNaN(amount) || (amount == 0) || (amount < 1)){
         alert(errmsg2);
        document.currcalc.amount.focus();
        return false;
    }
       var pattern = /,/g;
       amount = amount.replace(pattern, "");
    
    //show all results
    ShowResult_my(fromval, toval, amount);
}
//window.onload = calculate;
</script>
<div class="clearfloat"></div>
<div id="crncycalc" style="width:950px; float:left">
<form name="currcalc" onSubmit="calculate(); return false;">
<input type=HIDDEN name="flag" value=0>
<input type=HIDDEN name="result" value=1>
<input type=HIDDEN name="d_list" value=1>
<input type=HIDDEN name="version" value="us">
<input type=HIDDEN name="exp2" value="us1">
<input type=HIDDEN name="displayres" value=" GBP">
<input type=HIDDEN name="disptkc" value="British Pound">
<input type=HIDDEN name=T value="markets_curr99.ht">
<input type=HIDDEN name=TZ>
<input type=HIDDEN name="translation" value="">
<input type=HIDDEN name="translation1" value="您的选择出现了一点问题，请重新选择两种货币再试。">
<input type=HIDDEN name="translation2" value="请输入一个合法的货币数量。">
<input type=HIDDEN name="translation3" value="该转换工具只能在 Netscape Navigator 或者 Microsoft Internet Explorer 4.0 以上版本中使用。">
<div style="float:left;"><img src="img/coin.png" /></div>
<div align="left" style="width:630px; float:left; height:8px; float:left; margin-top:3px; color:#FF0000; ">
兑换金额:
<input type="text" name="amount" value="100.00" size="15">&emsp;原始货币:
<select name="from_tkc" size="1">
<option value="">选择货币
<option value="CNY:CUR">人民币(CNY)
<option value="JPY:CUR" selected>日元(JPY)
<OPTION VALUE="USD:CUR">美元(USD)
</select>&emsp;目标货币:
<select name="to_tkc" size="1">
<option value="">选择货币
<option value="CNY:CUR" selected>人民币(CNY)
<option value="JPY:CUR">日元(JPY)
<OPTION VALUE="USD:CUR">美元(USD)
</select>

<script>
	var results = r.query.results;
	alert("hello");
</script>
<script src="https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%20in%20(%22USDMXN%22)&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"></script>

<input type="button" name="cal" value="开始兑换" onClick="calculate()">
</div>
<div style=" margin-top:15px; color:#CCCCCC">
<script language="Javascript">loadResults_my();calculate();
 document.wite(price['AFN:CUR']);
</script>
</div>
</form>
</div>
</body>
</html>