$(function(){
	$('#modal-open-noti').on('click', function(){
		$('#modal-overlay, #modal-content-noti').fadeIn();
	});
	$('#modal-close, #modal-overlay').on('click',function(){
		$('#modal-overlay, #modal-content-noti').fadeOut();
	});

	locateCenter();
  $(window).resize(locateCenter);

  function locateCenter() {
    let w = $(window).width();
    let h = $(window).height();

    let cw = $('#modal-content-noti').outerWidth();
    let ch = $('#modal-content-noti').outerHeight();

    $('#modal-content-noti').css({
      'left': ((w - cw) / 2) + 'px',
      'top': ((h - ch) / 2) + 'px'
    });
  }
});