angular.module('app')
.directive('raSkillsInput', [
  function(){
    return {
      restrict: 'E',
      scope: {
        skillIds: '='
      },
      templateUrl: 'skills_input.html',
      controller: [
        '$scope',
        '$q',
        'Skill',
        function(
          $scope,
          $q,
          Skill
        ) {
          var skills = Skill.query();
          var skillIdsDefered = $q.defer();

          $q.all([skillIdsDefered, skills.$promise]).then(function() {
            var skillsById = _(skills).indexBy('id');
            $scope.selectedSkills = _($scope.skillIds).map(function(skillId){
              return skillsById[skillId];
            });
            $scope.$watchCollection('selectedSkills', function(){
              $scope.skillIds = _($scope.selectedSkills).pluck('id');
            });
          });

          $scope.$watch('skillIds == undefined', function() {
            if($scope.skillIds) skillIdsDefered.resolve();
          });

          $scope.findSkills = function(query) {
            var filteredSkills = _(skills).filter(function(skill){
              return skill.name.indexOf(query) >= 0
            });
            return filteredSkills
          }
        }
      ],
    }
  }
])
