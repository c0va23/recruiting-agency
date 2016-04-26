angular.module('app')
.filter('skillIdsToQuery', function(){
  return function(skillIds) {
    if(0 == skillIds.length) return;
    return '&' + _(skillIds).map(function(skillId){
      return 'skill_ids[]=' + skillId
    }).join('&');
  }
});
