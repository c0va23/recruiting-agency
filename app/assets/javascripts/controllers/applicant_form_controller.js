angular.module('app')
.controller('ApplicantFormController', [
  '$scope',
  '$route',
  '$location',
  'Notification',
  'Applicant',
  function(
    $scope,
    $route,
    $location,
    Notification,
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
      Notification.success('Сохранено');
    };

    var errorCallback = function(error) {
      $scope.errors = error.data.errors;
      Notification.error('Ошибка при сохранении');
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
