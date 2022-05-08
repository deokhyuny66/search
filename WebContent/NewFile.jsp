<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.2.0/css/swiper.css">
  <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.2.0/js/swiper.js"></script>
  <style>
html, body {
        position: relative;
        height: 100%;
    }
    body {
        background: #eee;
        font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
        font-size: 14px;
        color:#000;
        margin: 0;
        padding: 0;
    }

    .swiper-container {
        width: 30%;
        height: 45px;
    }
    .swiper-slide {
    border: 1px solid #000;
        text-align: center;
        font-size: 18px;
        background: #fff;
        
        /* Center slide text vertically */
/*         display: -webkit-box;
        display: -ms-flexbox;
        display: -webkit-flex; */
        display: flex;
/*         -webkit-box-pack: center;
        -ms-flex-pack: center;
        -webkit-justify-content: center; */
        justify-content: center;
/*         -webkit-box-align: center;
        -ms-flex-align: center;
        -webkit-align-items: center; */
        align-items: center;
    }
    .swiper-button-prev,
    .swiper-button-next {
    	display: none;
    }
  </style>
</head>
<body>
 <div class="container">   
    <!-- Slider main container -->
    <div class="swiper-container">
        <!-- Additional required wrapper -->
        <div class="swiper-wrapper">
            <div class="swiper-slide">1</div>
            <div class="swiper-slide">2</div>
            <div class="swiper-slide">3</div>
            <div class="swiper-slide">4</div>
            <div class="swiper-slide">5</div>
            <div class="swiper-slide">6</div>
            <div class="swiper-slide">7</div>
            <div class="swiper-slide">8</div>
            <div class="swiper-slide">9</div>
            <div class="swiper-slide">10</div>
        </div>

    </div>
</div>   

<script type = "text/javascript">
$(document).ready(function() {
	// Swiper: Slider
	    new Swiper('.swiper-container', {
	        loop: true,
	        slidesPerView: 6,
	        paginationClickable: true,
	        spaceBetween: 20
/* 	        breakpoints: {
	            1920: {
	                slidesPerView: 3,
	                spaceBetween: 30
	            },
	            1028: {
	                slidesPerView: 2,
	                spaceBetween: 30
	            },
	            480: {
	                slidesPerView: 1,
	                spaceBetween: 10
	            }
	        } */
	    });
	});

</script>
</body>
</html>