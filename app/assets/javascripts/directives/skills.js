angular.module('app')
.directive('raSkills', [
  function() {
    return {
      restrict: 'E',
      templateUrl: 'skills.html',
      scope: {
        skillIds: '='
      },
      controller: [
        '$scope',
        'Skill',
        function(
          $scope,
          Skill
        ) {
          Skill.query(function(skills){
            $scope.skillsById = _.indexBy(skills, 'id');
          })
        }
      ]
    }
  }
])
;
