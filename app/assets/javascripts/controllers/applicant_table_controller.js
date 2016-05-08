angular.module('app').controller('ApplicantTableController', [
  '$scope',
  function(
    $scope
  ) {
    var query = angular.copy($scope.query);
    $scope.matchApplicantSalary = function(applicant) {
      return applicant.expected_salary < query.salary;
    };

    $scope.matchApplicantSkills = function(applicant) {
      var applicantSkillIds = _(applicant.skill_ids);
      return _(query['skill_ids[]']).every(function(expectedSkillId){
        return applicantSkillIds.includes(expectedSkillId);
      });
    };
  }
]);
