/*
 * Virtual Keyboard & Keypad
 * 가상키보드 및 가상키패드
 * 
 * Jquery, Bootstrap, Hangul.js
 * 
 * */

let virkeyState = true; // 가상키보드 활성화 여부

/*$('body').append('<div class="card virtualKeyboard_content" id="virtualKeyboardMain">'+
	'<div class="row virtualKeyboard_content" style="width:100%; height:18%; margin-bottom: 0.3%;">'+
		'<div class="col virkey" id="virkey_0_0">`</div>'+
		'<div class="col virkey" id="virkey_0_1">1</div>'+
		'<div class="col virkey" id="virkey_0_2">2</div>'+
		'<div class="col virkey" id="virkey_0_3">3</div>'+
		'<div class="col virkey" id="virkey_0_4">4</div>'+
		'<div class="col virkey" id="virkey_0_5">5</div>'+
		'<div class="col virkey" id="virkey_0_6">6</div>'+
		'<div class="col virkey" id="virkey_0_7">7</div>'+
		'<div class="col virkey" id="virkey_0_8">8</div>'+
		'<div class="col virkey" id="virkey_0_9">9</div>'+
		'<div class="col virkey" id="virkey_0_10">0</div>'+
		'<div class="col virkey" id="virkey_0_11">-</div>'+
		'<div class="col virkey" id="virkey_0_12">=</div>'+
		'<div class="col virkey" id="virkey_0_13" style="min-width:10%;">backspace</div>'+
	'</div>'+
	'<div class="row virtualKeyboard_content" style="width:100%; height:18%; margin-bottom: 0.3%;">'+
		'<div class="col virkey" id="virkey_1_0" style="min-width:8%;">tab</div>'+
		'<div class="col virkey" id="virkey_1_1">ㅂ</div>'+
		'<div class="col virkey" id="virkey_1_2">ㅈ</div>'+
		'<div class="col virkey" id="virkey_1_3">ㄷ</div>'+
		'<div class="col virkey" id="virkey_1_4">ㄱ</div>'+
		'<div class="col virkey" id="virkey_1_5">ㅅ</div>'+
		'<div class="col virkey" id="virkey_1_6">ㅛ</div>'+
		'<div class="col virkey" id="virkey_1_7">ㅕ</div>'+
		'<div class="col virkey" id="virkey_1_8">ㅑ</div>'+
		'<div class="col virkey" id="virkey_1_9">ㅐ</div>'+
		'<div class="col virkey" id="virkey_1_10">ㅔ</div>'+
		'<div class="col virkey" id="virkey_1_11">[</div>'+
		'<div class="col virkey" id="virkey_1_12">]</div>'+
		'<div class="col virkey" id="virkey_1_13" style="min-width:8%;">\\</div>'+
	'</div>'+
	'<div class="row virtualKeyboard_content" style="width:100%; height:18%; margin-bottom: 0.3%;">'+
		'<div class="col virkey" id="virkey_2_0" style="min-width:9%;">Caps Lock</div>'+
		'<div class="col virkey" id="virkey_2_1">ㅁ</div>'+
		'<div class="col virkey" id="virkey_2_2">ㄴ</div>'+
		'<div class="col virkey" id="virkey_2_3">ㅇ</div>'+
		'<div class="col virkey" id="virkey_2_4">ㄹ</div>'+
		'<div class="col virkey" id="virkey_2_5">ㅎ</div>'+
		'<div class="col virkey" id="virkey_2_6">ㅗ</div>'+
		'<div class="col virkey" id="virkey_2_7">ㅓ</div>'+
		'<div class="col virkey" id="virkey_2_8">ㅏ</div>'+
		'<div class="col virkey" id="virkey_2_9">ㅣ</div>'+
		'<div class="col virkey" id="virkey_2_10">;</div>'+
		'<div class="col virkey" id="virkey_2_11">'+"'"+'</div>'+
		'<div class="col virkey" id="virkey_2_12" style="min-width:10%;">Enter</div>'+
	'</div>'+
	'<div class="row virtualKeyboard_content" style="width:100%; height:18%; margin-bottom: 0.3%;">'+
		'<div class="col virkey" id="virkey_3_0" style="min-width:10%;">Shift</div>'+
		'<div class="col virkey" id="virkey_3_1">ㅋ</div>'+
		'<div class="col virkey" id="virkey_3_2">ㅌ</div>'+
		'<div class="col virkey" id="virkey_3_3">ㅊ</div>'+
		'<div class="col virkey" id="virkey_3_4">ㅍ</div>'+
		'<div class="col virkey" id="virkey_3_5">ㅠ</div>'+
		'<div class="col virkey" id="virkey_3_6">ㅜ</div>'+
		'<div class="col virkey" id="virkey_3_7">ㅡ</div>'+
		'<div class="col virkey" id="virkey_3_8">,</div>'+
		'<div class="col virkey" id="virkey_3_9">.</div>'+
		'<div class="col virkey" id="virkey_3_10">/</div>'+
		'<div class="col virkey" id="virkey_3_11" style="min-width:12%;">Shift</div>'+
	'</div>'+
	'<div class="row virtualKeyboard_content" style="width:100%; height:18%; margin-bottom: 0.3%;">'+
		'<div class="col virkey" id="virkey_4_0">ctrl</div>'+
		'<div class="col virkey" id="virkey_4_1">win</div>'+
		'<div class="col virkey" id="virkey_4_2">alt</div>'+
		'<div class="col virkey" id="virkey_4_3" style="min-width:60%;">space</div>'+
		'<div class="col virkey" id="virkey_4_4">한/영</div>'+
		'<div class="col virkey" id="virkey_4_5">ctrl</div>'+
	'</div>'+
	'<div class="row virtualKeyboard_content" style="width:100%; height:10%;"></div>'+
'</div>');
*/
let virtualKeyboard_selector = '';
let virtualKeyboard_language = 'ko';
let capslock_state = false;
let shift_state = false;
let virtualKeyboard_original_offset_top = 0;

$(document).on('click',function(e) {
	if(!$(e.target).hasClass('virtualKeyboard') &&
		!$(e.target).hasClass('virkey') &&
		!$(e.target).hasClass('virtualKeyboard_content')) { 
		if($('#virtualKeyboardMain').css('display') == 'block') { // 가상 키보드가 켜져있을 경우
			$('#virtualKeyboardMain').fadeOut('100', function() {
		    	$('#virtualKeyboardMain').animate({position : 'absolute'},100);
		        $('#virtualKeyboardMain').css('top',virtualKeyboard_original_offset_top);
		    });
	        $('html, body').animate({scrollTop : 0}, 100);
		}
    }
});

$(document).on('click','.virtualKeyboard',function() {
	if(!$(virtualKeyboard_selector).is($(this)) || virtualKeyboard_selector == '' || $('#virtualKeyboardMain').css('display') == 'none') {
		$('#virtualKeyboardMain').css('top','');
		virtualKeyboard_selector = $(this);
		if(virkeyState) {
			$('#virtualKeyboardMain').fadeIn('100');
			if(($(this).offset().top + $(this).outerHeight()) >= $('#virtualKeyboardMain').offset().top) {
				virtualKeyboard_original_offset_top = $('#virtualKeyboardMain').offset().top;
				$('#virtualKeyboardMain').css('top',$(this).offset().top + $(this).outerHeight() + 15);
				var offset = $(this).offset();
		        $('html, body').animate({scrollTop : offset.top}, 1500);
			} else {
				$('#virtualKeyboardMain').css('top','');
			}
		}
	}
});

// 누르고있는 기능
/*var timeoutId = 0;
var intervalId = 0;

$(document).on('mousedown', '.virtualKeyboard_content .virkey', function() {
	var thisVal = $(this).text();
	var thisNode = $(this);
	
    timeoutId = setTimeout(function() {
    	intervalId = setInterval(function() {
    		var virkey_input_str = $(virtualKeyboard_selector).val();
    		if(thisNode.attr('id') == 'virkey_0_13') { // backspace
    			$(virtualKeyboard_selector).val(virkey_input_str.substring(0, virkey_input_str.length - 1));
    		} else if(thisNode.attr('id') == 'virkey_1_0') { // tab
    			var e = jQuery.Event("keydown");
    			e.which = 8; // # Some key code value
    			$(virtualKeyboard_selector).trigger(e);
    		} else if(thisNode.attr('id') == 'virkey_2_0') { // Caps Lock
    			capsLockKey();
    		} else if(thisNode.attr('id') == 'virkey_2_12') { // Enter
    			
    		} else if(thisNode.attr('id') == 'virkey_3_0' || thisNode.attr('id') == 'virkey_3_11') { // Shift
    			shiftKey();
    		} else if(thisNode.attr('id') == 'virkey_4_0' || thisNode.attr('id') == 'virkey_4_5') { // Ctrl
    			
    		} else if(thisNode.attr('id') == 'virkey_4_1') { // Win
    			
    		} else if(thisNode.attr('id') == 'virkey_4_2') { // Alt
    			
    		} else if(thisNode.attr('id') == 'virkey_4_3') { // SpaceBar
    			$(virtualKeyboard_selector).val(virkey_input_str+' ');
    		} else if(thisNode.attr('id') == 'virkey_4_4') { // 한영 전환
    			if(virtualKeyboard_language == 'ko') {
    				languageChange('en');
    				virtualKeyboard_language = 'en';
    			} else if(virtualKeyboard_language == 'en'){
    				languageChange('ko');
    				virtualKeyboard_language = 'ko';
    			}
    		} else {
    			$(virtualKeyboard_selector).val(virkey_input_str + thisVal);
    		}
    	}, 80);
    }, 500);
}).on('mouseup mouseleave', function() {
    clearTimeout(timeoutId);
    clearInterval(intervalId);
});*/

$(document).on('click','.virtualKeyboard_content .virkey',function() {
	$(virtualKeyboard_selector).focus();
	var virkey_input_str = $(virtualKeyboard_selector).val();
	if($(this).attr('id') == 'virkey_0_13') { // backspace
		$(virtualKeyboard_selector).val(virkey_input_str.substring(0, virkey_input_str.length - 1));
	} else if($(this).attr('id') == 'virkey_1_0') { // tab
		//$(virtualKeyboard_selector).next().focus();
		//virtualKeyboard_selector = $(virtualKeyboard_selector).next();
	} else if($(this).attr('id') == 'virkey_2_0') { // Caps Lock
		capsLockKey();
	} else if($(this).attr('id') == 'virkey_2_12') { // Enter
		
	} else if($(this).attr('id') == 'virkey_3_0' || $(this).attr('id') == 'virkey_3_11') { // Shift
		shiftKey();
	} else if($(this).attr('id') == 'virkey_4_0' || $(this).attr('id') == 'virkey_4_5') { // Ctrl
		
	} else if($(this).attr('id') == 'virkey_4_1') { // Win
		
	} else if($(this).attr('id') == 'virkey_4_2') { // Alt
		
	} else if($(this).attr('id') == 'virkey_4_3') { // SpaceBar
		$(virtualKeyboard_selector).val(virkey_input_str+' ');
	} else if($(this).attr('id') == 'virkey_4_4') { // 한영 전환
		if(virtualKeyboard_language == 'ko') {
			languageChange('en');
			virtualKeyboard_language = 'en';
		} else if(virtualKeyboard_language == 'en'){
			languageChange('ko');
			virtualKeyboard_language = 'ko';
		}
		
	} else {
		$(virtualKeyboard_selector).val(Hangul.assemble(Hangul.disassemble(virkey_input_str+$(this).text())));
	}
});

function shiftKey() {
	if(shift_state) { // shift 비활성화
		shift_state = false;
		$('#virkey_3_0').css('color','#363642');
		$('#virkey_3_0').css('background-color','white');
		$('#virkey_3_0').css('border-color','gray');
		$('#virkey_3_11').css('color','#363642');
		$('#virkey_3_11').css('background-color','white');
		$('#virkey_3_11').css('border-color','gray');

		$('#virkey_0_0').text('`');
		$('#virkey_0_1').text('1');
		$('#virkey_0_2').text('2');
		$('#virkey_0_3').text('3');
		$('#virkey_0_4').text('4');
		$('#virkey_0_5').text('5');
		$('#virkey_0_6').text('6');
		$('#virkey_0_7').text('7');
		$('#virkey_0_8').text('8');
		$('#virkey_0_9').text('9');
		$('#virkey_0_10').text('0');
		$('#virkey_0_11').text('-');
		$('#virkey_0_12').text('=');
		$('#virkey_1_11').text('[');
		$('#virkey_1_12').text(']');
		$('#virkey_1_13').text('\\');
		$('#virkey_2_10').text(';');
		$('#virkey_2_11').text("'");
		$('#virkey_3_8').text(',');
		$('#virkey_3_9').text('.');
		$('#virkey_3_10').text('/');
		
		if(virtualKeyboard_language == 'ko') { // 한국어
			$('#virkey_1_1').text('ㅂ');
			$('#virkey_1_2').text('ㅈ');
			$('#virkey_1_3').text('ㄷ');
			$('#virkey_1_4').text('ㄱ');
			$('#virkey_1_5').text('ㅅ');
		}
	} else { // shift 활성화
		shift_state = true;
		$('#virkey_3_0').css('color','white');
		$('#virkey_3_0').css('background-color','#0066CC');
		$('#virkey_3_0').css('border-color','red');
		$('#virkey_3_11').css('color','white');
		$('#virkey_3_11').css('background-color','#0066CC');
		$('#virkey_3_11').css('border-color','red');
		
		$('#virkey_0_0').text('~');
		$('#virkey_0_1').text('!');
		$('#virkey_0_2').text('@');
		$('#virkey_0_3').text('#');
		$('#virkey_0_4').text('$');
		$('#virkey_0_5').text('%');
		$('#virkey_0_6').text('^');
		$('#virkey_0_7').text('&');
		$('#virkey_0_8').text('*');
		$('#virkey_0_9').text('(');
		$('#virkey_0_10').text(')');
		$('#virkey_0_11').text('_');
		$('#virkey_0_12').text('+');
		$('#virkey_1_11').text('{');
		$('#virkey_1_12').text('}');
		$('#virkey_1_13').text('|');
		$('#virkey_2_10').text(':');
		$('#virkey_2_11').text('"');
		$('#virkey_3_8').text('<');
		$('#virkey_3_9').text('>');
		$('#virkey_3_10').text('?');
		
		if(virtualKeyboard_language == 'ko') { // 한국어
			$('#virkey_1_1').text('ㅃ');
			$('#virkey_1_2').text('ㅉ');
			$('#virkey_1_3').text('ㄸ');
			$('#virkey_1_4').text('ㄲ');
			$('#virkey_1_5').text('ㅆ');
		}
	}
}

function capsLockKey() {
	if(capslock_state) { // capslock 비활성화
		capslock_state = false;
		$('#virkey_2_0').css('color','#363642');
		$('#virkey_2_0').css('background-color','white');
		$('#virkey_2_0').css('border-color','gray');
		if(virtualKeyboard_language == 'ko') { // 한국어
		} else if (virtualKeyboard_language == 'en') { // 영어
			var keyboardLang = [
				{
					"0": "q",
					"1": "w",
					"2": "e",
					"3": "r",
					"4": "t",
					"5": "y",
					"6": "u",
					"7": "i",
					"8": "o",
					"9": "p"
				},
				{
					"0": "a",
					"1": "s",
					"2": "d",
					"3": "f",
					"4": "g",
					"5": "h",
					"6": "j",
					"7": "k",
					"8": "l"
				},
				{
					"0": "z",
					"1": "x",
					"2": "c",
					"3": "v",
					"4": "b",
					"5": "n",
					"6": "m"
				}
			];
			$('#virkey_1_1').text(keyboardLang[0][0]);
			$('#virkey_1_2').text(keyboardLang[0][1]);
			$('#virkey_1_3').text(keyboardLang[0][2]);
			$('#virkey_1_4').text(keyboardLang[0][3]);
			$('#virkey_1_5').text(keyboardLang[0][4]);
			$('#virkey_1_6').text(keyboardLang[0][5]);
			$('#virkey_1_7').text(keyboardLang[0][6]);
			$('#virkey_1_8').text(keyboardLang[0][7]);
			$('#virkey_1_9').text(keyboardLang[0][8]);
			$('#virkey_1_10').text(keyboardLang[0][9]);
			$('#virkey_2_1').text(keyboardLang[1][0]);
			$('#virkey_2_2').text(keyboardLang[1][1]);
			$('#virkey_2_3').text(keyboardLang[1][2]);
			$('#virkey_2_4').text(keyboardLang[1][3]);
			$('#virkey_2_5').text(keyboardLang[1][4]);
			$('#virkey_2_6').text(keyboardLang[1][5]);
			$('#virkey_2_7').text(keyboardLang[1][6]);
			$('#virkey_2_8').text(keyboardLang[1][7]);
			$('#virkey_2_9').text(keyboardLang[1][8]);
			$('#virkey_3_1').text(keyboardLang[2][0]);
			$('#virkey_3_2').text(keyboardLang[2][1]);
			$('#virkey_3_3').text(keyboardLang[2][2]);
			$('#virkey_3_4').text(keyboardLang[2][3]);
			$('#virkey_3_5').text(keyboardLang[2][4]);
			$('#virkey_3_6').text(keyboardLang[2][5]);
			$('#virkey_3_7').text(keyboardLang[2][6]);
		}
	} else { // capslock 활성화
		capslock_state = true;
		$('#virkey_2_0').css('color','white');
		$('#virkey_2_0').css('background-color','#0066CC');
		$('#virkey_2_0').css('border-color','red');
		if(virtualKeyboard_language == 'ko') { // 한국어
		} else if (virtualKeyboard_language == 'en') { // 영어
			var keyboardLang = [
				{
					"0": "Q",
					"1": "W",
					"2": "E",
					"3": "R",
					"4": "T",
					"5": "Y",
					"6": "U",
					"7": "I",
					"8": "O",
					"9": "P"
				},
				{
					"0": "A",
					"1": "S",
					"2": "D",
					"3": "F",
					"4": "G",
					"5": "H",
					"6": "J",
					"7": "K",
					"8": "L"
				},
				{
					"0": "Z",
					"1": "X",
					"2": "C",
					"3": "V",
					"4": "B",
					"5": "N",
					"6": "M"
				}
			];
			$('#virkey_1_1').text(keyboardLang[0][0]);
			$('#virkey_1_2').text(keyboardLang[0][1]);
			$('#virkey_1_3').text(keyboardLang[0][2]);
			$('#virkey_1_4').text(keyboardLang[0][3]);
			$('#virkey_1_5').text(keyboardLang[0][4]);
			$('#virkey_1_6').text(keyboardLang[0][5]);
			$('#virkey_1_7').text(keyboardLang[0][6]);
			$('#virkey_1_8').text(keyboardLang[0][7]);
			$('#virkey_1_9').text(keyboardLang[0][8]);
			$('#virkey_1_10').text(keyboardLang[0][9]);
			$('#virkey_2_1').text(keyboardLang[1][0]);
			$('#virkey_2_2').text(keyboardLang[1][1]);
			$('#virkey_2_3').text(keyboardLang[1][2]);
			$('#virkey_2_4').text(keyboardLang[1][3]);
			$('#virkey_2_5').text(keyboardLang[1][4]);
			$('#virkey_2_6').text(keyboardLang[1][5]);
			$('#virkey_2_7').text(keyboardLang[1][6]);
			$('#virkey_2_8').text(keyboardLang[1][7]);
			$('#virkey_2_9').text(keyboardLang[1][8]);
			$('#virkey_3_1').text(keyboardLang[2][0]);
			$('#virkey_3_2').text(keyboardLang[2][1]);
			$('#virkey_3_3').text(keyboardLang[2][2]);
			$('#virkey_3_4').text(keyboardLang[2][3]);
			$('#virkey_3_5').text(keyboardLang[2][4]);
			$('#virkey_3_6').text(keyboardLang[2][5]);
			$('#virkey_3_7').text(keyboardLang[2][6]);
		}
	}
}

function languageChange(language) {
	if(language == 'ko') {
		var keyboardLang = [
			{
				"0": "ㅂ",
				"1": "ㅈ",
				"2": "ㄷ",
				"3": "ㄱ",
				"4": "ㅅ",
				"5": "ㅛ",
				"6": "ㅕ",
				"7": "ㅑ",
				"8": "ㅐ",
				"9": "ㅔ"
			},
			{
				"0": "ㅁ",
				"1": "ㄴ",
				"2": "ㅇ",
				"3": "ㄹ",
				"4": "ㅎ",
				"5": "ㅗ",
				"6": "ㅓ",
				"7": "ㅏ",
				"8": "ㅣ"
			},
			{
				"0": "ㅋ",
				"1": "ㅌ",
				"2": "ㅊ",
				"3": "ㅍ",
				"4": "ㅠ",
				"5": "ㅜ",
				"6": "ㅡ"
			}
		];
		$('#virkey_1_1').text(keyboardLang[0][0]);
		$('#virkey_1_2').text(keyboardLang[0][1]);
		$('#virkey_1_3').text(keyboardLang[0][2]);
		$('#virkey_1_4').text(keyboardLang[0][3]);
		$('#virkey_1_5').text(keyboardLang[0][4]);
		$('#virkey_1_6').text(keyboardLang[0][5]);
		$('#virkey_1_7').text(keyboardLang[0][6]);
		$('#virkey_1_8').text(keyboardLang[0][7]);
		$('#virkey_1_9').text(keyboardLang[0][8]);
		$('#virkey_1_10').text(keyboardLang[0][9]);
		$('#virkey_2_1').text(keyboardLang[1][0]);
		$('#virkey_2_2').text(keyboardLang[1][1]);
		$('#virkey_2_3').text(keyboardLang[1][2]);
		$('#virkey_2_4').text(keyboardLang[1][3]);
		$('#virkey_2_5').text(keyboardLang[1][4]);
		$('#virkey_2_6').text(keyboardLang[1][5]);
		$('#virkey_2_7').text(keyboardLang[1][6]);
		$('#virkey_2_8').text(keyboardLang[1][7]);
		$('#virkey_2_9').text(keyboardLang[1][8]);
		$('#virkey_3_1').text(keyboardLang[2][0]);
		$('#virkey_3_2').text(keyboardLang[2][1]);
		$('#virkey_3_3').text(keyboardLang[2][2]);
		$('#virkey_3_4').text(keyboardLang[2][3]);
		$('#virkey_3_5').text(keyboardLang[2][4]);
		$('#virkey_3_6').text(keyboardLang[2][5]);
		$('#virkey_3_7').text(keyboardLang[2][6]);
	} else if(language == 'en') {
		if(capslock_state) { // CapsLock이 눌려있을 경우
			var keyboardLang = [
				{
					"0": "Q",
					"1": "W",
					"2": "E",
					"3": "R",
					"4": "T",
					"5": "Y",
					"6": "U",
					"7": "I",
					"8": "O",
					"9": "P"
				},
				{
					"0": "A",
					"1": "S",
					"2": "D",
					"3": "F",
					"4": "G",
					"5": "H",
					"6": "J",
					"7": "K",
					"8": "L"
				},
				{
					"0": "Z",
					"1": "X",
					"2": "C",
					"3": "V",
					"4": "B",
					"5": "N",
					"6": "M"
				}
			];
			$('#virkey_1_1').text(keyboardLang[0][0]);
			$('#virkey_1_2').text(keyboardLang[0][1]);
			$('#virkey_1_3').text(keyboardLang[0][2]);
			$('#virkey_1_4').text(keyboardLang[0][3]);
			$('#virkey_1_5').text(keyboardLang[0][4]);
			$('#virkey_1_6').text(keyboardLang[0][5]);
			$('#virkey_1_7').text(keyboardLang[0][6]);
			$('#virkey_1_8').text(keyboardLang[0][7]);
			$('#virkey_1_9').text(keyboardLang[0][8]);
			$('#virkey_1_10').text(keyboardLang[0][9]);
			$('#virkey_2_1').text(keyboardLang[1][0]);
			$('#virkey_2_2').text(keyboardLang[1][1]);
			$('#virkey_2_3').text(keyboardLang[1][2]);
			$('#virkey_2_4').text(keyboardLang[1][3]);
			$('#virkey_2_5').text(keyboardLang[1][4]);
			$('#virkey_2_6').text(keyboardLang[1][5]);
			$('#virkey_2_7').text(keyboardLang[1][6]);
			$('#virkey_2_8').text(keyboardLang[1][7]);
			$('#virkey_2_9').text(keyboardLang[1][8]);
			$('#virkey_3_1').text(keyboardLang[2][0]);
			$('#virkey_3_2').text(keyboardLang[2][1]);
			$('#virkey_3_3').text(keyboardLang[2][2]);
			$('#virkey_3_4').text(keyboardLang[2][3]);
			$('#virkey_3_5').text(keyboardLang[2][4]);
			$('#virkey_3_6').text(keyboardLang[2][5]);
			$('#virkey_3_7').text(keyboardLang[2][6]);
		} else { // CapsLock이 눌려있지 않을 경우
			var keyboardLang = [
				{
					"0": "q",
					"1": "w",
					"2": "e",
					"3": "r",
					"4": "t",
					"5": "y",
					"6": "u",
					"7": "i",
					"8": "o",
					"9": "p"
				},
				{
					"0": "a",
					"1": "s",
					"2": "d",
					"3": "f",
					"4": "g",
					"5": "h",
					"6": "j",
					"7": "k",
					"8": "l"
				},
				{
					"0": "z",
					"1": "x",
					"2": "c",
					"3": "v",
					"4": "b",
					"5": "n",
					"6": "m"
				}
			];
			$('#virkey_1_1').text(keyboardLang[0][0]);
			$('#virkey_1_2').text(keyboardLang[0][1]);
			$('#virkey_1_3').text(keyboardLang[0][2]);
			$('#virkey_1_4').text(keyboardLang[0][3]);
			$('#virkey_1_5').text(keyboardLang[0][4]);
			$('#virkey_1_6').text(keyboardLang[0][5]);
			$('#virkey_1_7').text(keyboardLang[0][6]);
			$('#virkey_1_8').text(keyboardLang[0][7]);
			$('#virkey_1_9').text(keyboardLang[0][8]);
			$('#virkey_1_10').text(keyboardLang[0][9]);
			$('#virkey_2_1').text(keyboardLang[1][0]);
			$('#virkey_2_2').text(keyboardLang[1][1]);
			$('#virkey_2_3').text(keyboardLang[1][2]);
			$('#virkey_2_4').text(keyboardLang[1][3]);
			$('#virkey_2_5').text(keyboardLang[1][4]);
			$('#virkey_2_6').text(keyboardLang[1][5]);
			$('#virkey_2_7').text(keyboardLang[1][6]);
			$('#virkey_2_8').text(keyboardLang[1][7]);
			$('#virkey_2_9').text(keyboardLang[1][8]);
			$('#virkey_3_1').text(keyboardLang[2][0]);
			$('#virkey_3_2').text(keyboardLang[2][1]);
			$('#virkey_3_3').text(keyboardLang[2][2]);
			$('#virkey_3_4').text(keyboardLang[2][3]);
			$('#virkey_3_5').text(keyboardLang[2][4]);
			$('#virkey_3_6').text(keyboardLang[2][5]);
			$('#virkey_3_7').text(keyboardLang[2][6]);
		}
	}
}









$('body').append('<div class="card virtualKeypad_content" id="virtualKeypadMain">'+
					'<div class="row virtualKeypad_content" style="width:100%; height:18%; margin-bottom: 0.3%;">'+
					'<div class="col virkey" id="virkeypad_0_0" style="font-size:1.5vw; text-align:center;"><i class="fas fa-long-arrow-alt-left" id="backspace"></i></div>'+
					'<div class="col virkey" id="virkeypad_0_1" style="font-size:1.2vw;">/</div>'+
					'<div class="col virkey" id="virkeypad_0_2" style="font-size:1.2vw;">x</div>'+
					'<div class="col virkey" id="virkeypad_0_3" style="font-size:1.2vw;">-</div>'+
				'</div>'+
					'<div class="row virtualKeypad_content" style="width:100%; height:18%; margin-bottom: 0.3%;">'+
					'<div class="col virkey" id="virkeypad_1_0">7</div>'+
					'<div class="col virkey" id="virkeypad_1_1">8</div>'+
					'<div class="col virkey" id="virkeypad_1_2">9</div>'+
					'<div class="col virkey" id="virkeypad_1_3" style="font-size:1.2vw;">+</div>'+
				'</div>'+
					'<div class="row virtualKeypad_content" style="width:100%; height:18%; margin-bottom: 0.3%;">'+
					'<div class="col virkey" id="virkeypad_2_0">4</div>'+
					'<div class="col virkey" id="virkeypad_2_1">5</div>'+
					'<div class="col virkey" id="virkeypad_2_2">6</div>'+
					'<div class="col virkey" id="virkeypad_2_3" style="font-size:1.5vw; text-align:center;"><i class="far fa-caret-square-up" id="upCount"></i></div>'+
				'</div>'+
					'<div class="row virtualKeypad_content" style="width:100%; height:18%; margin-bottom: 0.3%;">'+
					'<div class="col virkey" id="virkeypad_3_0">1</div>'+
					'<div class="col virkey" id="virkeypad_3_1">2</div>'+
					'<div class="col virkey" id="virkeypad_3_2">3</div>'+
					'<div class="col virkey" id="virkeypad_3_3" style="font-size:1.5vw; text-align:center;"><i class="far fa-caret-square-down" id="downCount"></i></div>'+
				'</div>'+
					'<div class="row virtualKeypad_content" style="width:100%; height:18%; margin-bottom: 0.3%;">'+
					'<div class="col virkey" id="virkeypad_4_0" style="min-width:50%;">0</div>'+
					'<div class="col virkey" id="virkeypad_4_1">.</div>'+
					'<div class="col virkey" id="virkeypad_4_2">Enter</div>'+
				'</div>'+
					'<div class="row virtualKeypad_content" style="width:100%; height:10%;"></div>'+
				'</div>');

let virtualKeypad_selector = '';
let virtualKeypad_original_offset_top = 0;

$(document).on('click',function(e) {
	if(!$(e.target).hasClass('virtualKeypad') &&
		!$(e.target).hasClass('virkey') &&
		!$(e.target).hasClass('virtualKeypad_content') &&
		$(e.target).attr('id') != 'backspace' &&
		$(e.target).attr('id') != 'upCount' &&
		$(e.target).attr('id') != 'downCount') {
		if($('#virtualKeypadMain').css('display') == 'block') { // 가상 키패드가 켜져있을 경우
			$('#virtualKeypadMain').fadeOut('100', function() {
	        	$('#virtualKeypadMain').animate({position : 'absolute'},100);
		        $('#virtualKeypadMain').css('top',virtualKeypad_original_offset_top);
		        
	        });
	        $('html, body').animate({scrollTop : 0}, 100);
		}
    }
});

$(document).on('click','.virtualKeypad',function() {
	if(!$(virtualKeypad_selector).is($(this)) || virtualKeypad_selector == '' || $('#virtualKeypadMain').css('display') == 'none') {
		$('#virtualKeypadMain').css('top','');
		virtualKeypad_selector = $(this);
		if(virkeyState) {
			$('#virtualKeypadMain').fadeIn('100');
			if(($(this).offset().top + $(this).outerHeight()) >= $('#virtualKeypadMain').offset().top) {
				virtualKeypad_original_offset_top = $('#virtualKeypadMain').offset().top;
				//$('#virtualKeypadMain').css('top',$(this).offset().top + $(this).outerHeight() + 15);
				var offset = $(this).offset();
		        $('html, body').animate({scrollTop : offset.top}, 100);
			} else {
				$('#virtualKeypadMain').css('top','');
			}
		}
	}
});

$(document).on('click','.virtualKeypad_content .virkey',function() {
	$(virtualKeypad_selector).focus();
	var virkey_input_str = $(virtualKeypad_selector).val();
	if($(this).attr('id') == 'virkeypad_0_0' || $(this).attr('id') == 'backspace') { // backspace
		$(virtualKeypad_selector).val(virkey_input_str.substring(0, virkey_input_str.length - 1)).trigger('keyup');
	} else if($(this).attr('id') == 'virkeypad_2_3' || $(this).attr('id') == 'upCount') { // +1
		$(virtualKeypad_selector).val(virkey_input_str==''?0:parseFloat(virkey_input_str)+1).trigger('keyup');
	} else if($(this).attr('id') == 'virkeypad_3_3' || $(this).attr('id') == 'downCount') { // -1
		$(virtualKeypad_selector).val(virkey_input_str==''?0:parseFloat(virkey_input_str)-1).trigger('keyup');
	} else if($(this).attr('id') == 'virkeypad_4_2') { // Enter
		
	} else {
		$(virtualKeypad_selector).val(Hangul.assemble(Hangul.disassemble(virkey_input_str+$(this).text()))).trigger('keyup');
	}
});