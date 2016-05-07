angular.module('app')
.controller('ApplicantSearchController', [
  '$scope',
  '$location',
  'Applicant',
  'Skill',
  'skillIdsQueryParse',
  function(
    $scope,
    $location,
    Applicant,
    Skill,
    skillIdsQueryParse
  ) {
    var params = $location.search();
    $scope.applicants = Applicant.search(params);

    $scope.query = {
      partial_match: params.partial_match,
      salary: Number.parseFloat(params.salary),
      'skill_ids[]': _.map(params['skill_ids[]'], function(idStr){
        return Number.parseInt(idStr);
      }),
    };

    $scope.skills = Skill.query();

    $scope.search = function() {
      $location.search($scope.query);
    };
  }
]);
