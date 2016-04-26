angular.module('app')
.factory('Vacancy', [
  '$resource',
  function(
    $resource
  ) {
    return $resource('/api/vacancies/:id', {}, {
      update: {method: 'PUT'}
    });
  }
])
.factory('Applicant', [
  '$resource',
  function($resource) {
    return $resource('/api/applicants/:id', {}, {
      update: {method: 'PUT'}
    });
  }
])
.factory('Skill', [
  '$resource',
  function($resource) {
    return $resource('/api/skills')
  }
])
;
