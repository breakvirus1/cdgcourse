document.addEventListener('DOMContentLoaded', function() {
    // Добавляем слушатели событий на кнопки подписки/отписки
    const followButtons = document.querySelectorAll('.follow_button');
    const unfollowButtons = document.querySelectorAll('.unfollow_button');
  
    followButtons.forEach(function(button) {
      button.addEventListener('click', followUser);
    });
  
    unfollowButtons.forEach(function(button) {
      button.addEventListener('click', unfollowUser);
    });
  });
  
  function followUser() {
    const userId = this.getAttribute('data-user-id');
    Rails.ajax({
      url: '/users/' + userId + '/follow',
      type: 'post',
      success: function(data) {
        // Обновляем кнопку на странице после успешного выполнения запроса
        document.getElementById("follow_button_" + userId).innerHTML = "Unfollow";
        document.getElementById("follow_button_" + userId).classList.remove('follow_button');
        document.getElementById("follow_button_" + userId).classList.add('unfollow_button');
        document.getElementById("follow_button_" + userId).setAttribute("onclick", "unfollowUser()");
      },
      error: function(data) {
        // Обработка ошибки, если нужно
      }
    });
  }
  
  function unfollowUser() {
    const userId = this.getAttribute('data-user-id');
    Rails.ajax({
      url: '/users/' + userId + '/unfollow',
      type: 'delete',
      success: function(data) {
        // Обновляем кнопку на странице после успешного выполнения запроса
        document.getElementById("follow_button_" + userId).innerHTML = "Follow";
        document.getElementById("follow_button_" + userId).classList.remove('unfollow_button');
        document.getElementById("follow_button_" + userId).classList.add('follow_button');
        document.getElementById("follow_button_" + userId).setAttribute("onclick", "followUser()");
      },
      error: function(data) {
        // Обработка ошибки, если нужно
      }
    });
  }