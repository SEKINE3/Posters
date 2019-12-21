$(function(){
	$('#modal-open').on('click', function(){
		$('#modal-overlay, #modal-content').fadeIn();
	});
	$('#modal-close, #modal-overlay').on('click',function(){
		$('#modal-overlay, #modal-content').fadeOut();
	});

	locateCenter();
  $(window).resize(locateCenter);

  function locateCenter() {
    let w = $(window).width();
    let h = $(window).height();

    let cw = $('#modal-content').outerWidth();
    let ch = $('#modal-content').outerHeight();

    $('#modal-content').css({
      'left': ((w - cw) / 2) + 'px',
      'top': ((h - ch) / 2) + 'px'
    });
  }
});