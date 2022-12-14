/*!
    * Start Bootstrap - SB Admin v7.0.5 (https://startbootstrap.com/template/sb-admin)
    * Copyright 2013-2022 Start Bootstrap
    * Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-sb-admin/blob/master/LICENSE)
    */
// 
// Scripts
// 


scroll_bottom = function () {
    if ($('#message_container').length > 0) {
        $('#message_container').scrollTop($('#message_container')[0].scrollHeight);
    }
}


$(document).on('turbolinks:load', function () {
    scroll_bottom();
})





// with turbolink
window.addEventListener('turbolinks:load', event => {
    // Toggle the side navigation
    const sidebarToggle = document.body.querySelector('#sidebarToggle');
    // var sidebarToggle = document.body.querySelector('#sidebarToggle');
    if (sidebarToggle) {
        // Uncomment Below to persist sidebar toggle between refreshes
        // 
        // if (localStorage.getItem('sb|sidebar-toggle') === 'true') {
        //     document.body.classList.toggle('sb-sidenav-toggled');
        // }
        // 
        sidebarToggle.addEventListener('click', event => {
            event.preventDefault();
            document.body.classList.toggle('sb-sidenav-toggled');
            localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
        });
    }

});


// window.setInterval(function () {
//     var elem = document.getElementById('message_container');
//     elem.scrollTop = elem.scrollHeight;
// // }, 5000);
// }, 0);

