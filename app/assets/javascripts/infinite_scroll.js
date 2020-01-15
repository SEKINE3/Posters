$(function() {
	$('#post1').infiniteScroll({
		path: '.pagenation a[rel=next]',
		append:  '.show_post_contents', //読み込まれる要素
		history: false, //ページが読み込まれてもURLを変えない
		prefill: true,
		scrollThreshold: 1000,
		status: '.page-load-status',
		checkLastPage: true
	})
});