angular.module('app')
.controller('ApplicantSearchController', [
  '$scope',
  '$route',
  'Applicant',
  'skillIdsQueryParse',
  function(
    $scope,
    $route,
    Applicant,
    skillIdsQueryParse
  ) {
    $scope.applicants = Applicant.search($route.current.params);
    $scope.salary = $route.current.params.salary;

    $scope.skillIds = skillIdsQueryParse($route.current.params['skill_ids[]']);
  }
]);
