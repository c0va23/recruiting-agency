angular.module('app')
.controller('VacancySearchController', [
  '$scope',
  '$route',
  'Vacancy',
  'skillIdsQueryParse',
  function(
    $scope,
    $route,
    Vacancy,
    skillIdsQueryParse
  ) {
    $scope.vacancies = Vacancy.search($route.current.params);

    $scope.salary = $route.current.params.salary;

    $scope.skillIds = skillIdsQueryParse($route.current.params['skill_ids[]']);
  }
]);
