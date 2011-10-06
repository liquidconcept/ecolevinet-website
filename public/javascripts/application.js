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

  //calendar comportment
  $('.event_check').hover(
    function () {
     $('.calendar_overlay').fadeIn('slow', function() {
        $('.calendar_overlay').css({'display': 'inline'});// Animation complete.
      });
    },
    function () {
      $('.calendar_overlay').fadeOut('slow', function() {
        $('.calendar_overlay').css({'display': 'none'});// Animation complete.
      });
    }
  );


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
