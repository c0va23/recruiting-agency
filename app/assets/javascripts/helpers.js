angular.module('app')
.factory('skillIdsQueryParse', function() {
  return function(rawSkillIds) {
    // If skill_ids have one item, then wrap it into array
    var rawSkillIdsArray = ('string' == typeof rawSkillIds) ? [rawSkillIds] : rawSkillIds;
    console.log(rawSkillIdsArray);

    // Convert string value into number
    return _(rawSkillIdsArray).map(function(skillIdRaw) {
      return Number.parseInt(skillIdRaw);
    });
  }
})
