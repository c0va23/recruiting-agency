angular.module('app')
.controller('VacancySearchController', [
  '$scope',
  '$location',
  'Vacancy',
  'Skill',
  'skillIdsQueryParse',
  function(
    $scope,
    $location,
    Vacancy,
    Skill,
    skillIdsQueryParse
  ) {
    var params = angular.copy($location.search());
    $scope.vacancies = Vacancy.search(params);

    $scope.query = {
      salary: Number.parseFloat(params.salary),
      'skill_ids[]': _.map(params['skill_ids[]'], function(skillIdStr){
        return Number.parseInt(skillIdStr);
      }),
    }

    $scope.skills = Skill.query();

    $scope.search = function() {
      $location.search($scope.query);
    };
  }
]);
