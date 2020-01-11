$(function(){
  $('#modal-open-edit').on('click', function(){
    $('#modal-overlay, #modal-content-edit').fadeIn();
  });
  $('#modal-close, #modal-overlay').on('click',function(){
    $('#modal-overlay, #modal-content-edit').fadeOut();
  });

  locateCenter();
  $(window).resize(locateCenter);

  function locateCenter() {
    let w = $(window).width();
    let h = $(window).height();

    let cw = $('#modal-content-edit').outerWidth();
    let ch = $('#modal-content-edit').outerHeight();

    $('#modal-content-edit').css({
      'left': ((w - cw) / 2) + 'px',
      'top': ((h - ch) / 2) + 'px'
    });
  }
});