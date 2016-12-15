$("document").ready(function(){
  function readURL(input) {

      if (input.files && input.files[0]) {
          var reader = new FileReader();

          reader.onload = function (e) {
               $('header').css('background-image', 'url(' + e.target.result + ')'); 
          }

          reader.readAsDataURL(input.files[0]);
      }
  }
  $("#banner_image").change(function() {
    readURL(this);
  });
});
