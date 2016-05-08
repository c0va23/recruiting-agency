angular.module('app')
.directive('raSkillsInput', [
  function(){
    return {
      restrict: 'E',
      scope: {
        skillIds: '='
      },
      templateUrl: 'shared/skills_input.html',
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

          var setSkillIds = function() {
            $scope.skillIds = _($scope.selectedSkills).pluck('id');
          };

          $q.all([skillIdsDefered, skills.$promise]).then(function() {
            var skillsById = _(skills).indexBy('id');
            $scope.selectedSkills = _($scope.skillIds).map(function(skillId){
              return skillsById[skillId];
            });
            $scope.$watchCollection('selectedSkills', setSkillIds);
          });

          // Wait until skillIds not set value
          $scope.$watch('skillIds == undefined', function() {
            if($scope.skillIds) skillIdsDefered.resolve();
          });

          $scope.findSkills = function(query) {
            var lowerCaseQuery = query.toLowerCase();
            return _(skills).filter(function(skill){
              return skill.lowerCaseName().indexOf(lowerCaseQuery) >= 0
            });
          };

          $scope.createSkill = function(newSkill) {
            var existedSkill = _(skills).find(function(skill){
              return skill.name == newSkill.name;
            });

            if(existedSkill != undefined) return;

            Skill.save(newSkill, function(savedSkill) {
              newSkill.id = savedSkill.id;
              setSkillIds();
            });
          };
        }
      ],
    }
  }
])
