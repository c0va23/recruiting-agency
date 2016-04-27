angular.module('app')
.controller('ApplicantSearchController', [
  '$scope',
  '$route',
  'Applicant',
  function(
    $scope,
    $route,
    Applicant
  ) {
    $scope.applicants = Applicant.search($route.current.params);
    $scope.salary = $route.current.params.salary;

    var skillIdsRaw = $route.current.params['skill_ids[]']
    // If skill_ids have one item, then wrap it into array
    if('string' == typeof skillIds) skillIdsRaw = [skillIdsRaw]

    // Convert string value into number
    $scope.skillIds = _(skillIdsRaw).map(function(skillIdRaw) {
      return Number.parseInt(skillIdRaw);
    });
  }
]);
