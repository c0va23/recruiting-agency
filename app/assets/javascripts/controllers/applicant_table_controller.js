angular.module('app').controller('ApplicantTableController', [
  '$scope',
  function(
    $scope
  ) {
    var query = angular.copy($scope.query);

    $scope.matchApplicantSalary = function(applicant) {
      if(undefined == query) return undefined;

      return applicant.expected_salary < query.salary;
    };

    $scope.matchApplicantSkills = function(applicant) {
      if(undefined == query) return undefined;

      var applicantSkillIds = _(applicant.skill_ids);
      return _(query['skill_ids[]']).every(function(expectedSkillId){
        return applicantSkillIds.includes(expectedSkillId);
      });
    };
  }
]);
