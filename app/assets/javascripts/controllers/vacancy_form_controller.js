angular.module('app')
.controller('VacancyFormController', [
  '$scope',
  '$route',
  '$location',
  'Notification',
  'Vacancy',
  function(
    $scope,
    $route,
    $location,
    Notification,
    Vacancy
  ) {
    var vacancyId = $route.current.params.vacancyId;
    var newVacancy = undefined == vacancyId;

    $scope.vacancy = newVacancy ? new Vacancy({}) : Vacancy.get({id: vacancyId});

    var successCallback = function(vacancy) {
      delete $scope.errors;
      if(newVacancy) {
        $location.path('/vacancies/' + vacancy.id + '/edit')
      }
      Notification.success('Сохранено');
    };

    var errorCallback = function(error) {
      $scope.errors = error.data.errors;
      Notification.error('Ошибка при сохранении');
    };

    $scope.saveVacancy = function() {
      if(newVacancy) {
        $scope.vacancy.$save(successCallback, errorCallback);
      } else {
        $scope.vacancy.$update({id: $scope.vacancy.id}, successCallback, errorCallback);
      }
    };
  }
])
;
