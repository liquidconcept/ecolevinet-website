$(document).ready(function() {
        $('.horizontalaccordion>ul>li>a').click(function(event){
          event.preventDefault();
          var vb, link;
          vb   = $(this).parent();
          link = $(this);
          $.pjax({url: $(this).attr('href') , container: '#page_content',  timeout: 3000});
          $('body').unbind('start.pjax').bind('start.pjax', function() {
            $('#page_content').slideUp(1000);
          });
          $('body').unbind('end.pjax').bind('end.pjax',   function() {
            var sectionid;
            sectionid = link.attr('data-sectionid');
            $('#section' + sectionid).siblings().css({display: 'none'});
            $('#section' + sectionid).css({display: 'block'});
            $('#page_content').slideDown(1000);
            vb.parent().find('.current').animate({width: '35px'},'slow').removeClass('current').end();
            vb.animate({width: '735px'},'slow').addClass('current');
          });
        });
});
