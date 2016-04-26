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
  }
]);
