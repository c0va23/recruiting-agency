angular.module('app')
.factory('Vacancy', [
  '$resource',
  function(
    $resource
  ) {
    return $resource('/api/vacancies');
  }
])
.factory('Applicant', [
  '$resource',
  function($resource) {
    return $resource('/api/applicants')
  }
])
;
