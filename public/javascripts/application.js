var undefined;

$(document).ready(function() {

  // init colorbox
  function load_colorbox() {
    $('a.gallery').colorbox({
      current: "image {current} sur {total}",
      previous: "précédente",
      next: "suivante",
      close: "fermer"
    });
  }
  load_colorbox();

  // init scrollbar
  function load_Scrollbar() {
    if ($('.scrollable').length > 0){
      $('.scrollable').scrollbar({
        arrows: false
      });
    }
  }
  load_Scrollbar();

  // Block overlay
  $('.block > .layer').show();
  $('.block > .layer').live('mouseenter', function() {
    $(this).fadeOut('fast');
  });
  $('.block').live('mouseleave', function() {
    $(this).find('.layer').fadeIn('fast');
  });

  // portfolio navigation initialization
  var portfolios = new Object();
  var p_navigation = {
    init: function() {
      var that = this;

      if ($('#portfolios_container').length > 0) {
        $.ajax({
          url: '/portfolio',
          dataType: 'json',
          data: "section_id=" + $('#portfolios_container').attr('data-section'),
          success: function(data){
            portfolios = data;
            that.update();
          }
        });
      }
    },
    update: function() {
      //navigation update
      if (p_navigation.index <= 0) {
        $('#portfolio_switcher > a.left').fadeTo('fast', 0.5);
      } else {
        $('#portfolio_switcher > a.left').fadeTo('fast', 1);
      };
      if (p_navigation.index + 1 >= portfolios.length) {
        $('#portfolio_switcher > a.right').fadeTo('fast', 0.5);
      } else {
        $('#portfolio_switcher > a.right').fadeTo('fast', 1);
      }

      //change galery title & src
      portfolio = portfolios[p_navigation.index];

      $('#portfolio_switcher > a.target').attr('href','/portfolio/' + portfolio['portfolio_entry']['friendly_id'] + "?section_id=" + $('#portfolios_container').attr('data-section'));
      $('#portfolio_switcher > a.target').html(portfolio['portfolio_entry']['title']);
    },
    index: 0,
    loaded: []
  };
  p_navigation.init();

  // galeries selection
  $('#portfolio_switcher > a.left').live('click', (function(event){
    event.preventDefault();

    if (p_navigation.index == 0) {
      return false;
    }

    //slide portfolios
    $('#portfolios_container').animate({left: '+=420px'});

    //navigation update
    p_navigation.index -= 1;
    p_navigation.update();
  }));
  $('#portfolio_switcher > a.right').live('click', (function(event){
    event.preventDefault();

    if (p_navigation.index + 1 == portfolios.length)  {
      return false;
    }

    // replace current galery by the first on the right
    $('#portfolios_container').animate({left: '-=420px'});

    //navigation update
    p_navigation.index += 1;
    p_navigation.update();

    // Add a galery to the right
    if ( p_navigation.index > 0 &&
        p_navigation.index + 1 < portfolios.length &&
          $.inArray(p_navigation.index + 1, p_navigation.loaded) == -1
       )
     {
       $.ajax({
         url: '/portfolio/' + portfolios[p_navigation.index+1]['portfolio_entry']['id'],
         dataType: 'html',
         success: function(data){
           $('#portfolios_container').css('width','+=420px');
           $('#portfolios_container').append(data);
           // reload Scrollbar
           load_Scrollbar();
           load_colorbox();
           //populate loaded pages
           p_navigation.loaded.push(p_navigation.index + 1)
         }
       })
     }
  }));

  //calendar comportment
  //moment language initialization
  moment.lang('fr');

  var temp = '';
  var today = new Date();
  // reference day first day of current month
  var reference_day = function() {return moment([today.getFullYear(),today.getMonth()])};
  var c_navigation = {
    init: function() {
      $('#month_container').animate({left: '-=420px'});
    },
    update: function() {
      //navigation
      //change month title
      $('#month_switcher > a.target').html(moment.months[c_navigation.index.month()]);
    },
    index: reference_day(),
    loaded: [ reference_day().subtract('M', 1).format('MM-YY'),
      reference_day().format('MM-YY'),
      reference_day().add('M',1).format('MM-YY') ]
  };

  //navigation initialization
  c_navigation.init();

  // previous month
  function previous_month(event) {

    event.preventDefault();
    $('#calendar_overlay').fadeOut('fast');

    //navigation update
    c_navigation.index.subtract('M',1);

    c_navigation.update();

    // if not previously added load it
    temp = c_navigation.index.format('DD-MM-YY');
    if ( $.inArray( moment(temp,'DD-MM-YY').subtract('M',1).format('MM-YY'), c_navigation.loaded) == -1)
      {

        $.ajax({
          url: '/events/for_the',
          data: {month: c_navigation.index.format("MM-YY"), direction: 'down'},
          dataType: 'html',
          success: function(data){
            $('#month_container').prepend(data);
            //add space to container
            $('#month_container').css('width','+=420px');
            // $('#month_container').animate({left: '+=420px'});
            //populate loaded pages
            temp = c_navigation.index.format('DD-MM-YY');
            c_navigation.loaded.push(moment(temp,'DD-MM-YY').subtract('M',1).format('MM-YY'));
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
    c_navigation.index.add('M',1);

    c_navigation.update();

    // if not previously added load it
    temp = c_navigation.index.format('DD-MM-YY');
    if ( $.inArray(moment(temp,'DD-MM-YY').add('M',1).format('MM-YY'), c_navigation.loaded) == -1 )
      {
        $.ajax({
          url: '/events/for_the',
          data: {month: c_navigation.index.format("MM-YY") , direction: 'up'},
          dataType: 'html',
          success: function(data){
            $('#month_container').append(data);
            //add space to container
            $('#month_container').css('width','+=420px');
            //populate loaded pages
            temp = c_navigation.index.format('DD-MM-YY');
            c_navigation.loaded.push(moment(temp,'DD-MM-YY').add('M',1).format('MM-YY'));
          }
        });
      };
  }

  // left
  $('#month_switcher>a.left').live('click', function(event){
    previous_month(event);
  });
  // right
  $('#month_switcher>a.right').live('click',function(event){
    next_month(event);
  });

  // hover behaviour on overlay

  //wile entering, register being over
  $('#calendar_overlay').live('mouseenter', function(){$('#calendar_overlay').data('hover',true);});
  //wile leaving, register leaving & fadeOUt unless being on an event
  $('#calendar_overlay').live('mouseleave', function(){
      $('#calendar_overlay').data('hover',false);
      if (!$('#calendar_overlay').data('render')){
        $('#calendar_overlay').fadeOut('fast');
        clearTimeout($(this).data('timeoutId'));
      };
    }
  );

  // hover behaviour on a full day
  $('.event_check').live('mouseenter',
    //wile entering
    function (e) {
      //TODO: Fix me : clear timeout for in progress effect
      clearTimeout($('#calendar_overlay').data('timeoutId'));
      // set overlay as renderable
      $('#calendar_overlay').data('render', true);

      var cell = $(this);
      $.ajax({
        url: '/events/on_the',
        data: {day: cell.attr('data-day')},
        dataType: 'html',
        success: function(data){
          $('#calendar_overlay').html(data);

          var left = cell.offset().left - cell.parents('.block').offset().left + cell.outerWidth()  - 10 + 'px';
          var top  = cell.offset().top  - cell.parents('.block').offset().top  + cell.outerHeight() -  5 + 'px';
          $('#calendar_overlay').css({left: left, top: top });

          if ($('#calendar_overlay').data('render')) {
            $('#calendar_overlay').fadeIn('fast');
          };
        }
      });
    });
$('.event_check').live('mouseleave',
    //wile leaving
    function (e) {
      clearTimeout($('#calendar_overlay').data('timeoutId'));
      // set overlay as non renderable
      $('#calendar_overlay').data('render',false);
      // timeout for fading overlay unless on it
      var timeoutId = setTimeout(
        "if (!$('#calendar_overlay').data('hover')){$('#calendar_overlay').fadeOut('fast');};"
        , 1000
      );
      // register timeout
      $('#calendar_overlay').data('timeoutId', timeoutId);
    }
  );

 //agenda page animation

  $('#agenda .date>a').live('click',
    function(event){
    event.preventDefault();
    var img; img = $(this).find('img');
      if (img.is('.full')){
        if (!img.hasClass('open')){
          $('.description',$(this).closest('li')).fadeIn('fast');
          img.attr('src','/images/down.png');
          img.addClass('open');
        }
        else {
          $('.description',$(this).closest('li')).fadeOut('fast');
          img.attr('src','/images/right.png');
          img.removeClass('open');
        };
      };
    });

  // contact form animation
    //
    $('#demande_contact').live('ajax:success',
     function(event, data, status, xhr) {
       $('#fields').css({visibility: 'hidden'});
       $('#contact_message').html(data).fadeIn();
     });

  // MENU
  //

  var slideSection = function(current_section_id, current_url) {
    $('#section_container > div:not(#section_1)').each(function(index, el) {
      var section_id = index + 2; // index start to 0, section start to 1 and fisrt section is skeeped
      el = $(el);

      // open section if needed
      if (section_id <= current_section_id && !el.hasClass('open')) {
        el.animate({left: '-=670'}, function() {
          el.addClass('open');
        });
      // or close it
      } else if (section_id > current_section_id && el.hasClass('open')) {
        el.animate({left: '+=670'}, function() {
          el.removeClass('open');
        });
      }

      if (current_section_id === 1 || ($('#menu a.active').length !== 0 && current_section_id === 6)) {
        $('#menu a').removeClass('active');
        if ($('#menu a[href="'+ current_url +'"]').length === 0) {
          $('#menu a:first-child').addClass('active');
        } else {
          $('#menu a[href="'+ current_url +'"]').addClass('active');
        }
      } else  {
        $('#menu a').removeClass('active');
      }
    });
  }

  var getCurrentSectionID = function(current_url) {
    current_url = current_url.replace(location.origin, '');
    var current_section_id = parseInt(getQueryString(current_url, 'section_id') || 1);
    $('#section_container > div:not(#section_1)').each(function(index, el) {
      var section_id = index + 2; // index start to 0, section start to 1 and first section is skiped
      el = $(el);

      if (current_url.indexOf(el.find('a').attr('href')) === 0) {
        current_section_id = index + 2;
      }
    });

    return current_section_id;
  }

  $('body').bind('pjax:start', function(event, xhr, options) {
    slideSection(getCurrentSectionID(options.url), options.url);
  });

  $('#section_container #section_6 .nav_wrap, #menu a.contact').bind('click', function(event) {
    event.preventDefault();

    var tab = $('#section_container #section_6');
    $('#form_contact #fields input:not([type="submit"])').val('');
    if (tab.hasClass('open')) {
      slideSection(tab.data('lastSectionId'), location.href);
    } else {
      tab.data('lastSectionId', getCurrentSectionID(location.href));
      slideSection(6, location.pathname);
    }

    $('#form_contact').unbind('click');
  });

  $('body').bind('pjax:end', function() {
    load_Scrollbar();
    load_colorbox();
    c_navigation.init();
    p_navigation.init();
  });

  $('body').delegate('a', 'click', function(event){
    var href = $(this).attr('href');

    if (!$(this).data('pjaxDisable') && $(this).data('pjaxDisable') !== 'true' && !href.match(/^(https?)?\/\//) && !href.match(/^\/system/) && !href.match(/^#/)) {
      event.preventDefault();

      if (href !== undefined && href !== '' && location.href !== $(this).attr('href')) {
        jQuery.pjax({url: href, container: '#page_content', timeout: 10000});
      } else {
        slideSection(getCurrentSectionID(location.href), location.href);
      }
    }
  });
});

var getQueryString = function(href, name) {
  if (name === undefined) {
    name = href;
    href = window.location.href;
  }

  var vars = [], hash;
  var hashes = href.slice(href.indexOf('?') + 1).split('&');
  for(var i = 0; i < hashes.length; i++)
  {
    hash = hashes[i].split('=');
    vars.push(hash[0]);
    vars[hash[0]] = hash[1];
  }

  if (name) {
    return vars[name];
  } else {
    return vars;
  }
}
