angular.module('app')
.filter('skillsToQuery', function(){
  return function(skills) {
    if(0 == skills.length) return;
    return '&' + _(skills).map(function(skill){
      return 'skill_ids[]=' + skill.id
    }).join('&');
  }
});
