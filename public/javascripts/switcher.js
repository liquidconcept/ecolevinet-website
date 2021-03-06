var timer;
var slides;
var original_image;
var original_text;
var original_href;
var original_hat;

function change_slide(delay, index) {
  var text = slides[index].text;
  var image = slides[index].image;

  $('#section_1 > .nav_text > h2 > p').fadeOut("slow", function() {
    $(this).html(text).fadeIn("slow");
    $("#section_1 > .nav_text > h2").animate({
      height:$("#section_1 > .nav_text > h2 > p").outerHeight()
    }, 600);
  });

  $('#section_1 > img').fadeOut("slow", function() {
    $(this).attr('src', image);
    $(this).fadeIn("slow");

    $('#section_1 > .nav_text > p > .current').attr("class", "");
    $('#section_1 > .nav_text > p > #' + index).attr("class", "current");
    $('#section_1 > .nav_text > p > .current').off('click');
    $('#section_1 > .nav_text > p > p:not(".current")').on('click', function() {
      clearTimeout(timer);
      change_slide(0, parseInt($(this).attr('id')));
      clearTimeout(timer);
    });
  });

  if (delay != 0) {
    timer = setTimeout(function(){change_slide(delay, (index + 1) % slides.length );}, delay);
  }
}

function start_slide() {
  if (($('.open').length <= 1) && (timer == null)) {
    $('#section_1 > .nav_text > h2').html("<a href=" + original_href + ">" + original_text + "</a><span class='text_background'></span>");
    $('#section_1 > .nav_text > p').html("<a href=" + original_href + ">" + original_hat + "</a><span class='text_background'></span>");
    $("#section_1 > .nav_text > h2").show();
    $("#section_1 > .nav_text > p").show();

    var height = $("#section_1 > .nav_text > h2").outerHeight() + $("#section_1 > .nav_text > p").outerHeight();

    $("#section_1 > .nav_text").animate({
      height: height
    },600);

    $.getJSON('/switcher/slides.json', function(data) {
      data.slides.unshift({"image" : original_image, "text" : original_text});
      slides = data.slides;
      delay = data.delay;

      var i = 1;
      if (data.slides.length > 1) {
        for (x in data.slides) {
          $('#section_1 > .nav_text > p').append('<p id="' + x + '"></p>');
        }
        $('#section_1 > .nav_text > p > p:not(".current")').click(function() {
          clearTimeout(timer);
          change_slide(0, parseInt($(this).attr('id')));
          clearTimeout(timer);
        });
        $('#section_1 > .nav_text > p > #0').attr("class", "current")
        timer = setTimeout(function(){change_slide(delay, 1);}, delay);
      }

    });
  }
}

window.onload = function () {
  original_image = $('#section_1 > img').attr('src').toString();
  original_text = $('#section_1 > .nav_text > h2 > a').text().toString();
  original_href = $('#section_1 > .nav_text > h2 > a').attr('href');
  original_hat = $('#section_1 > .nav_text > p').text().toString();
  start_slide();
  $('#menu > a').click(function(){setTimeout(function() {start_slide();}, 500)});
};




