angular.module('app')
.controller('VacanciesController', [
  '$scope',
  'Vacancy',
  function(
    $scope,
    Vacancy
  ){
    $scope.vacancies = Vacancy.query();
  }
])
