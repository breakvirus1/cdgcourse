// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

function followUser(userId) {
    Rails.ajax({
      url: '/users/' + userId + '/follow',
      type: 'post',
      success: function(data) {
        // Обновляем кнопку на странице после успешного выполнения запроса
      },
      error: function(data) {
        // Обработка ошибки, если нужно
      }
    });
  }
  
  function unfollowUser(userId) {
    Rails.ajax({
      url: '/users/' + userId + '/unfollow',
      type: 'delete',
      success: function(data) {
        // Обновляем кнопку на странице после успешного выполнения запроса
      },
      error: function(data) {
        // Обработка ошибки, если нужно
      }
    });
  }