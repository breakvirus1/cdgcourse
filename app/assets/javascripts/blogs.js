document.addEventListener('DOMContentLoaded', function() {
    const likeButtons = document.querySelectorAll('.like_button');
    const unlikeButtons = document.querySelectorAll('.unlike_button');
  
    likeButtons.forEach(function(button) {
      button.addEventListener('click', likeBlog);
    });
  
    unlikeButtons.forEach(function(button) {
      button.addEventListener('click', unlikeBlog);
    });
  });
  
  function likeBlog() {
    const blogId = this.getAttribute('data-blog-id');
    Rails.ajax({
      url: '/blogs/' + blogId + '/like',
      type: 'post',
      success: function(data) {
        // Обновляем кнопку на странице после успешного выполнения запроса
        document.getElementById("like_button_" + blogId).innerHTML = "Unlike";
        document.getElementById("like_button_" + blogId).classList.remove('like_button');
        document.getElementById("like_button_" + blogId).classList.add('unlike_button');
        document.getElementById("like_button_" + blogId).setAttribute("onclick", "unlikeBlog()");
        // Обновляем счетчик лайков
        document.getElementById("likes_count_" + blogId).innerHTML = data.likes_count;
      },
      error: function(data) {
        // Обработка ошибки, если нужно
      }
    });
  }
  
  function unlikeBlog() {
    const blogId = this.getAttribute('data-blog-id');
    Rails.ajax({
      url: '/blogs/' + blogId + '/unlike',
      type: 'delete',
      success: function(data) {
        // Обновляем кнопку на странице после успешного выполнения запроса
        document.getElementById("like_button_" + blogId).innerHTML = "Like";
        document.getElementById("like_button_" + blogId).classList.remove('unlike_button');
        document.getElementById("like_button_" + blogId).classList.add('like_button');
        document.getElementById("like_button_" + blogId).setAttribute("onclick", "likeBlog()");
        // Обновляем счетчик лайков
        document.getElementById("likes_count_" + blogId).innerHTML = data.likes_count;
      },
      error: function(data) {
        // Обработка ошибки, если нужно
      }
    });
  }