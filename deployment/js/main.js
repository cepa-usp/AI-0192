var btnPlayPause;
var timer = 0;
var current = 0;
var started = false;
var animationFrame;

var t;

function init(){
	btnPlayPause = $("#start_stop_button");
	btnPlayPause.on("mousedown", btnClick);
	t = $(".timer");
	window.requestAnimationFrame(updateTimer);
}

function btnClick(evt){
	if(started){
		started = false;
		btnPlayPause.html("INICIAR");
		btnPlayPause.css("background-color", "green");
		$(".time").html(timer.toFixed(2) + " segundos");
		if(Math.abs(timer - 15) < 0.5){
			$(".final").html("Você acertou!");
		}else{
			$(".final").html("Tente novamente.");
		}
		$(".result").show();
	}else{
		timer = 0;
		started = true;
		btnPlayPause.html("PARAR");
		btnPlayPause.css("background-color", "red");
		$(".result").hide();
	}
}

function updateTimer(timestamp){
	var dt = (timestamp - current)/1000;
	current = timestamp;

	if(started) timer += dt;
	//t.html(timer.toFixed(2));

	window.requestAnimationFrame(updateTimer);
}