$(document).ready(function() {

 // $('.scrollable').scrollbar({
 //   arrows: false
 // });

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

      $.getJSON('/portfolio.json',
        {section_id: $('portfolio_container').attr('data-section')},
        function(data) {
          portfolios = data;
          that.update();
        }
      );
    },
    update: function() {
      //navigation update
      if (navigation.index <= 0) {
        $('#month_switcher > a.left').fadeTo('fast', 0.5);
      } else {
        $('#month_switcher > a.left').fadeTo('fast', 1);
      };
      if (navigation.index + 1 >= portfolios.length) {
        $('#month_switcher > a.right').fadeTo('fast', 0.5);
      } else {
        $('#month_switcher > a.right').fadeTo('fast', 1);
      }

      //change galery title & src
      portfolio = portfolios[navigation.index];

      $('#month_switcher > a.target').attr('href','/portfolio/' + portfolio['portfolio_entry']['friendly_id']);
      $('#month_switcher > a.target').html(portfolio['portfolio_entry']['title']);
    },
    index: 0,
    loaded: []
  };

  //navigation initialization
  navigation.init();

  // galeries selection
  $('#month_switcher > a.left').click(function(event){
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
  $('#month_switcher > a.right').click(function(event){
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
           //populate loaded pages
           navigation.loaded.push(navigation.index + 1)
         }
       })
     }
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
