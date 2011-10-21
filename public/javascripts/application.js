$(document).ready(function() {

  function load_Scrollbar () {
    if ($('.scrollable').length > 0){
      $('.scrollable').scrollbar({
        arrows: false
      });
    }
  }
  load_Scrollbar();

  //block general comportment
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

  // PORTFOLIO
  // prettyphoto activation
  function load_prettyPhoto () {
    if ($("a[rel^='prettyPhoto']").length > 0) {$("a[rel^='prettyPhoto']").prettyPhoto({social_tools:false});}
  };

  load_prettyPhoto();

  //navigation initialization
  var portfolios = new Object();
  var navigation = {
    init: function() {
      var that = this;

      $.ajax({
        url: '/portfolio',
        dataType: 'json',
        data: "section_id=" + $('#portfolios_container').attr('data-section'),
        success: function(data){
          portfolios = data;
          that.update();
        }
      });
    },
    update: function() {
      //navigation update
      if (navigation.index <= 0) {
        $('#portfolio_switcher > a.left').fadeTo('fast', 0.5);
      } else {
        $('#portfolio_switcher > a.left').fadeTo('fast', 1);
      };
      if (navigation.index + 1 >= portfolios.length) {
        $('#portfolio_switcher > a.right').fadeTo('fast', 0.5);
      } else {
        $('#portfolio_switcher > a.right').fadeTo('fast', 1);
      }

      //change galery title & src
      portfolio = portfolios[navigation.index];

      $('#portfolio_switcher > a.target').attr('href','/portfolio/' + portfolio['portfolio_entry']['friendly_id']);
      $('#portfolio_switcher > a.target').html(portfolio['portfolio_entry']['title']);
    },
    index: 0,
    loaded: []
  };

  //navigation initialization
  navigation.init();

  // galeries selection
  $('#portfolio_switcher > a.left').click(function(event){
    event.preventDefault();

    if (navigation.index == 0) {
      return false;
    }

    //slide portfolios
    $('#portfolios_container').animate({left: '+=420px'});

    //navigation update
    navigation.index -= 1;
    navigation.update();
  });
  $('#portfolio_switcher > a.right').click(function(event){
    event.preventDefault();

    if (navigation.index + 1 == portfolios.length)  {
      return false;
    }

    // replace current galery by the first on the right
    $('#portfolios_container').animate({left: '-=420px'});

    //navigation update
    navigation.index += 1;
    navigation.update();

    // Add a galery to the right
    if ( navigation.index > 0 &&
         navigation.index + 1 < portfolios.length &&
         $.inArray(navigation.index + 1, navigation.loaded) == -1
       )
     {
       $.ajax({
         url: '/portfolio/' + portfolios[navigation.index+1]['portfolio_entry']['id'],
         dataType: 'html',
         success: function(data){
           $('#portfolios_container').css('width','+=420px');
           $('#portfolios_container').append(data);
           // reload prettyPhoto
           load_prettyPhoto();
           // reload Scrollbar
           load_Scrollbar();
           //populate loaded pages
           navigation.loaded.push(navigation.index + 1)
         }
       })
     }
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

  var over_note = false;
  $('#calendar_overlay').hover(
    function(){
      over_note = true;
    }
    ,
    function(){
      over_note = false;
    }
  );

  var render = true;
  $('.event_check').hover(
    //wile entering
    function (e) {
     render = true;
     console.log('y=' + e.pageY);
     console.log('x=' + e.pageX);
     console.log('cal y=' + (650 - e.pageY)) ;
     console.log('cal x=' + (350 + 90 - e.pageX) );

     $.ajax({
       url: '/events/on_the',
       data: {day: $(this).attr('data-day')},
       dataType: 'html',
       success: function(data){
         $('#calendar_overlay').html(data);
         $('#calendar_overlay').css({
           'bottom': (650 - e.pageY) + 'px',
           'right':  (350 + 90 - e.pageX) + 'px'
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
      if ( !over_note) {
        $('#calendar_overlay').fadeOut('fast');
      };
    }
  );

  //Horizontal accordion
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
