angular.module('app')
.controller('VacancySearchController', [
  '$scope',
  '$route',
  'Vacancy',
  function(
    $scope,
    $route,
    Vacancy
  ) {
    $scope.vacancies = Vacancy.search($route.current.params);
  }
]);
