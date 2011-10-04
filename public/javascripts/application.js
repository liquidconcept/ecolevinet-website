$(document).ready(function() {
  $('.scrollable').scrollbar({
	arrows: false
  });

  //block comportment
  $('.block>.layer').css({display: 'inline'});
  $('.block').hover(
    function () {
      $(this).find('.layer').fadeOut('slow', function() {
      $(this).css({'display': 'none'});// Animation complete.
    });
    },
    function () {
      $(this).find('.layer').fadeIn('slow', function() {
       $(this).css({'display': 'inline'});
    });
  });

  //prettyphoto activation
  $("a[rel^='prettyPhoto']").prettyPhoto({social_tools:false});

// galeries selection
  $('#month_switcher>a.left').click(function(event){
    if ($('#flash.current').prev('#flash').length == 0)  {return false;};
    // replace current galery by the first on the left
    $('#flash.current').fadeOut('slow', function() {
      $(this).css({'display': 'none'});// Animation complete.
    }).prev('#flash').fadeIn('slow', function() {
       $(this).css({'display': 'inline'});
    });
    $('#flash.current').toggleClass('current').prev('#flash').toggleClass('current');
    //focus
    $('#flash.current').focus();
    //change layer source image
    $('.layer>img.portfolio_img').attr('href',$('#flash.current>div.img_resize>img.thumbnails_img').attr('href'));
  });
  $('#month_switcher>a.right').click(function(event){
    if ($('#flash.current').next('#flash').length == 0)  {return false;};
    $('#flash.current').fadeOut('slow', function() {
      $(this).css({'display': 'none'});// Animation complete.
    }).next('#flash').fadeIn('slow', function() {
       $(this).css({'display': 'inline'});
    });
    $('#flash.current').toggleClass('current').next('#flash').toggleClass('current');
    //focus
    $('#flash.current').focus();
    //change layer source image
    $('.layer>img.portfolio_img').attr('href',$('#flash.current>div.img_resize>img.thumbnails_img').attr('href'));
    alert($('#flash.current>.img_resize>img.thumbnails_img').attr('src'));
  });


  //horizontal accordion
  $('#horizontalaccordion>ul>li>a').click(function(event){
    event.preventDefault();
    var vb, link;
    vb   = $(this).parent();
    link = $(this);
    // if user is asking for the current page, do nothing
    if (location.pathname == $(this).attr('href') ) {return false;};

    //pjax call
    $.pjax({url: $(this).attr('href') , container: '#page_content',  timeout: 3000});

    //pjax start bind
    $('body').unbind('start.pjax').bind('start.pjax', function() {
      $('#page_content').slideUp(1000);
    });

    //pjax end bind
    $('body').unbind('end.pjax').bind('end.pjax',   function() {
      var sectionid;
      sectionid = link.attr('data-sectionid');
      $('#section' + sectionid).siblings().css({display: 'none'});//images et textes des autres sections en non sélectionnés
      $('#section' + sectionid).fadeIn('slow');//.css({display: 'block'}); //images et textes de la section courante sélectionné
      $('#page_content').slideDown(1000); //apparition du contenu
      vb.parent().find('.current').animate({width: '34px'},'slow').removeClass('current').end(); //slider out
      vb.animate({width: '736px'},'slow').addClass('current'); //slider in
    });
  });
});
