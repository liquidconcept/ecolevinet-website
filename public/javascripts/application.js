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
  //moment language initialization
  moment.lang('fr');

  var temp = '';

  var today = new Date();
  // reference day first day of current month
  var reference_day = function() {return moment([today.getFullYear(),today.getMonth()])};
  var navigation = {
    init: function() {
      $('#month_container').animate({left: '-=420px'});
    },
    update: function() {
      //navigation
      //change month title
      $('#month_switcher > a.target').html(moment.months[navigation.index.month()]);
    },
    index: reference_day(),
    loaded: [ reference_day().subtract('M', 1).format('MM-YY'),
              reference_day().format('MM-YY'),
              reference_day().add('M',1).format('MM-YY') ]
  };

  //navigation initialization
  navigation.init();

   // previous month
  function previous_month(event) {

    event.preventDefault();
    $('#calendar_overlay').fadeOut('fast');

    //navigation update
    navigation.index.subtract('M',1);

    navigation.update();

    // if not previously added load it
    temp = navigation.index.format('DD-MM-YY');
    if ( $.inArray( moment(temp,'DD-MM-YY').subtract('M',1).format('MM-YY'), navigation.loaded) == -1)
      {

        $.ajax({
          url: '/events/for_the',
          data: {month: navigation.index.format("MM-YY"), direction: 'down'},
          dataType: 'html',
          success: function(data){
            $('#month_container').prepend(data);
            //add space to container
            $('#month_container').css('width','+=420px');
            // $('#month_container').animate({left: '+=420px'});
            //populate loaded pages
            temp = navigation.index.format('DD-MM-YY');
            navigation.loaded.push(moment(temp,'DD-MM-YY').subtract('M',1).format('MM-YY'));
            console.log(navigation.loaded);
          }
        });
      }
      else {
        // replace current month by the first on the left
        $('#month_container').animate({left: '+=420px'});
      };
  }
  // next month

  function next_month(event) {
     event.preventDefault();
     var temp; // temporary container for currrent index
     $('#calendar_overlay').fadeOut('fast');

    // replace current month by the first on the right
    $('#month_container').animate({left: '-=420px'});

    //navigation update
    navigation.index.add('M',1);
    
    navigation.update();
    
    // if not previously added load it
    temp = navigation.index.format('DD-MM-YY');
    if ( $.inArray(moment(temp,'DD-MM-YY').add('M',1).format('MM-YY'), navigation.loaded) == -1 )
    {
      $.ajax({
         url: '/events/for_the',
         data: {month: navigation.index.format("MM-YY") , direction: 'up'},
         dataType: 'html',
         success: function(data){
           $('#month_container').append(data);
           //add space to container
           $('#month_container').css('width','+=420px');
           //populate loaded pages
           temp = navigation.index.format('DD-MM-YY');
           navigation.loaded.push(moment(temp,'DD-MM-YY').add('M',1).format('MM-YY'));
           console.log(navigation.loaded);
          }
      });
    };
  }

  // left
  $('#month_switcher>a.left').click(function(event){
    previous_month(event);
  });
  // right
  $('#month_switcher>a.right').click(function(event){
    next_month(event);
  });

  // hover behaviour on an event
  var render = true;
  $('.event_check').hover(
    //wile entering
    function (e) {
     render = true;
     console.log(e.pageY);
     console.log(e.pageY - 570);

     $.ajax({
       url: '/events/on_the',
       data: {day: $(this).attr('data-day')},
       dataType: 'html',
       success: function(data){
         $('#calendar_overlay').html(data);
         $('#calendar_overlay').css({
           'bottom': (650 - e.pageY) + 'px',
           'right':  (380 - e.pageX) + 'px'
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
