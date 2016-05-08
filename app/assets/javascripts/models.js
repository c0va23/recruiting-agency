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
  '$http',
  '$resource',
  function(
    $http,
    $resource
  ) {
    var wrapResource = function(data, header) {
      angular.forEach(data, function(item, idx) {
        data[idx] = new Skill(item);
      });
      return data;
    };
    var Skill = $resource('/api/skills', {}, {
      query: {
        isArray: true,
        transformResponse: $http.defaults.transformResponse.concat(wrapResource),
      }
    });
    Skill.prototype.lowerCaseName = function () {
      if(undefined === this._lowerCaseName) {
        this._lowerCaseName = this.name.toLowerCase();
      }
      return this._lowerCaseName;
    };
    return Skill;
  }
])
;
