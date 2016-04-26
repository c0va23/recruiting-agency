angular.module('app')
.controller('ApplicantFormController', [
  '$scope',
  '$route',
  '$location',
  'Applicant',
  function(
    $scope,
    $route,
    $location,
    Applicant
  ) {
    var applicantId = $route.current.params.applicantId;
    var newApplicant = undefined == applicantId;

    $scope.applicant = newApplicant ? new Applicant({}) : Applicant.get({id: applicantId});

    var successCallback = function(applicant) {
      delete $scope.errors;
      if(newApplicant) {
        $location.path('/applicants/' + applicant.id + '/edit')
      }
    };

    var errorCallback = function(error) {
      $scope.errors = error.data.errors;
    };

    $scope.saveApplicant = function() {
      if(newApplicant) {
        $scope.applicant.$save(successCallback, errorCallback);
      } else {
        $scope.applicant.$update({id: $scope.applicant.id}, successCallback, errorCallback);
      }
    };
  }
])
;
