angular.module('app').controller('VacancyTableController', [
  '$scope',
  function(
    $scope
  ) {
    var query = angular.copy($scope.query);

    $scope.matchVacancySalary = function(vacancy) {
      if(undefined == query) return undefined;

      return vacancy.salary >= query.salary;
    };

    $scope.matchVacancySkills = function(vacancy) {
      if(undefined == query) return undefined;

      var skillIds = _(query['skill_ids[]']);
      return _.every(vacancy.skill_ids, function(vacancySkillId){
        return skillIds.includes(vacancySkillId);
      });
    };
  }
]);
