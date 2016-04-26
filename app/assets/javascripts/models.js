angular.module('app')
.factory('Vacancy', [
  '$resource',
  function(
    $resource
  ) {
    return $resource('/api/vacancies');
  }
])
;
