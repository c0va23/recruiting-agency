angular.module('app')
.factory('Vacancy', [
  '$resource',
  function(
    $resource
  ) {
    return $resource('/api/vacancies/:id', {}, {
      update: {method: 'PUT'},
      search: {
        url: '/api/vacancies/search',
        isArray: true,
      },
    });
  }
])
.factory('Applicant', [
  '$resource',
  function($resource) {
    return $resource('/api/applicants/:id', {}, {
      update: {method: 'PUT'},
      search: {
        url: '/api/applicants/search',
        isArray: true,
      },
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
