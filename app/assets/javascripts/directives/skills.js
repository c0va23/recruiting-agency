angular.module('app')
.directive('raSkills', [
  function() {
    return {
      restrict: 'E',
      templateUrl: 'shared/skills.html',
      scope: {
        skills: '='
      },
    }
  }
])
;
