$(document).ready(function() {
  $('.scrollable').scrollbar({
    arrows: false
  });

  //block comportment
  $('.block>.layer').css({display: 'inline'});
  $('.block').hover(
    function () {
    $(this).find('.layer').fadeOut('fast', function() {$(this).css({'display': 'none'});
    });
  },
  function () {
    $(this).find('.layer').fadeIn('fast', function() {$(this).css({'display': 'inline'});
    });
  });

  //prettyphoto activation
  $("a[rel^='prettyPhoto']").prettyPhoto({social_tools:false});

  var navigation;
  navigation = {
    init: function() {
      //navigation initialization
      if ($('.flash.current').prev('.flash').length == 0) {$('a.left').fadeTo('fast', 0.5);}
      if ($('.flash.current').next('.flash').length == 0) {$('a.right').fadeTo('fast',0.5);}
    },
    update: function() {
      //navigation update
      if ($('.flash.current').prev('.flash').length == 0) {$('a.left').fadeTo('fast', 0.5);}
      else {$('a.left').fadeTo('fast', 1);};
      if ($('.flash.current').next('.flash').length == 0) {$('a.right').css({'opacity' : 0.5});}
      else {$('a.right').fadeTo('fast', 1);};
      //change galery title & src
      // portfolio = portfolios[navigation.index]
      // $('#month_switcher > a.target').attr('href','/portfolio/' + portfolio['title']).innerHtml(portfolio['title']);
    },
    index: 0
  };

  //navigation initialization
  navigation.init();

  // galeries selection
  $('#month_switcher>a.left').click(function(event){
    if ($('.flash.current').prev('.flash').length == 0)  {return false;};
    event.preventDefault();
    navigation.index -= 1;
    // replace current galery by the first on the left
    $('.flash.current').fadeOut('fast', function() {
      //change layer source image
      $('.layer img.portfolio_img').attr('src',$('.flash.current div.img_resize a').attr('href'));
      $('.flash.current').removeClass('current').prev('.flash').addClass('current');
    }).prev('.flash').fadeIn('fast');
    //navigation update
    navigation.update();
  });
  $('#month_switcher>a.right').click(function(event){
    if ($('.flash.current').next('.flash').length == 0)  {return false;};
    event.preventDefault();
    navigation.index += 1;
    // replace current galery by the first on the right
    $('.flash.current').fadeOut('slow', function() {
      //change layer source image
      $('.layer img.portfolio_img').attr('src',$('.flash.current div.img_resize a').attr('href'));
      $('.flash.current').removeClass('current').next('.flash').addClass('current');
    }).next('.flash').fadeIn('fast');
    //navigation update
    navigation.update();
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
      $('#section' + sectionid).fadeIn('fast');//.css({display: 'block'}); //images et textes de la section courante sélectionné
      $('#page_content').slideDown(1000); //apparition du contenu
      vb.parent().find('.current').animate({width: '34px'},'fast').removeClass('current').end(); //slider out
      vb.animate({width: '736px'},'fast').addClass('current'); //slider in
    });
  });
});
