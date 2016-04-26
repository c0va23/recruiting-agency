angular.module('app')
.controller('ApplicantsController', [
  '$scope',
  'Applicant',
  function(
    $scope,
    Applicant
  ) {
    $scope.applicants = Applicant.query();
  }
]);
