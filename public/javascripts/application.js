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
  // hover behaviour on an event
  var render = true;

  $('.event_check').hover(
    //wile entering
    function (e) {
     render = true;
     $.ajax({
       url: '/events/on_the',
       data: {day: $(this).attr('data-day')},
       dataType: 'html',
       success: function(data){
         $('#calendar_overlay').html(data);
         $('#calendar_overlay').css({
           'bottom': (e.pagey - 570) + 'px',
           'right': (380 -  e.pageX) + 'px'
         });
           if (render) {
             $('#calendar_overlay').fadeIn('fast');
           };
        }}
     );
    },
    //wile leaving
    function (e) {
      render = false;
      $('#calendar_overlay').fadeOut('fast');
    }
  );

  //month selection
  var months = {};

  months.list = {
    "1": "Janvier",
    "2": "Février",
    "3": "Mars",
    "4": "Avril",
    "5": "Mai",
    "6": "Juin",
    "7": "Juillet",
    "8": "Août",
    "9": "Septembre",
    "10": "Octobre",
    "11": "Novembre",
    "12": "Décembre"};

  months.from =  function (month) {
      return months.list[Number(month)]
    };

  // previous month
  function previous_month(event) {
     event.preventDefault();
     $('#calendar_overlay').fadeOut('fast');
     $.ajax({
       url: '/events/for_the',
       data: {month: $('#month').attr('data-month'), direction: 'down'},
       dataType: 'html',
       success: function(data){
         $('#calendar').html(data);
         $('#month_switcher > a.target').html(months.from($('#month').attr('data-month').substr(0,2)));
        }}
     );
  }
  // next month
  function next_month(event) {
     event.preventDefault();
     $('#calendar_overlay').fadeOut('fast');
     $.ajax({
       url: '/events/for_the',
       data: {month: $('#month').attr('data-month'), direction: 'up'},
       dataType: 'html',
       success: function(data){
         $('#calendar').html(data);
         $('#month_switcher > a.target').text(months.from($('#month').attr('data-month').substr(0,2)));
        }}
     );
  }

  // left
  $('#month_switcher>a.left').click(function(event){
    previous_month(event);
  });
  // right
  $('#month_switcher>a.right').click(function(event){
    next_month(event);
  });

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
