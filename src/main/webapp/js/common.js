$.validator.addMethod("regex", function(value, element, regexp) {
		let re = new RegExp(regexp);
		let res = re.test(value);
		return res;
	})

	function inputPhoneNumber(obj) {

		var number = obj.value.replace(/[^0-9]/g, "");
		var phone = "";

		if (number.length < 4) {
			return number;
		} else if (number.length < 7) {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3);
		} else if (number.length < 11) {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3, 3);
			phone += "-";
			phone += number.substr(6);
		} else {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3, 4);
			phone += "-";
			phone += number.substr(7);
		}
		obj.value = phone;
	}

$.validator.addMethod("idchk", function(value, element) {
	if (empIdCheck()) {
		return true;
	} else {
		return false;
	}
})

$.validator.addMethod("snchk", function(value, element) {
	if (snKeyCehck()) {
		return true;
	} else {
		return false;
	}
})

function numkeyCheck(e) {
	var keyValue = event.keyCode;
	if (((keyValue < 48) || (keyValue > 57)))
		return false;
	else {
		return true;
	}
}
