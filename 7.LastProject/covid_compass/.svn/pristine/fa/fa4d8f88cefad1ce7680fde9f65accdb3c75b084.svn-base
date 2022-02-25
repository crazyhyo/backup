<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head></head>

<title></title>

<body>
	<section class="content">
			<div class="row">
				<div class="col-12">
					<div class="card card-primary">
						<div class="card-header center" style="background:#5b6f90;">
							<h3 class="card-title">QR문진표</h3>
						</div>
						<div class="card-body">
							<div class="row" style="justify-content: center;">
								
								
								<div class="col-6 align-self-center text-right" style>
									<h1><b>문진표 작성</b></h1>
								</div>
								
								<div id="qrcode" class="col-6"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
	</section>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
	<script>
		window.onload = function() {

			generateQR();

		}
		var qrcode = new QRCode(document.getElementById("qrcode"));
		var data = "";

		function generateQR() {

			data = "http://192.168.43.64/ddit/index.do";
			qrcode.makeCode(data);

		}

		function decode() {
			//alert(data);
			var devalue = document.getElementById('decodetext');
			devalue.value = data;
		}
		
	</script>

</body>