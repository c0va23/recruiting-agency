// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require angular
//= require angular-resource
//= require angular-route
//= require underscore
//= require ngTagsInput/build/ng-tags-input
//= require_self
//= require models.js
//= require filters
//= require_tree ./controllers
//= require_tree ./directives

angular.module(
    'app', [
      'ngRoute',
      'ngResource',
      'ngTagsInput',
    ]
)
.config([
  '$routeProvider',
  function($routeProvider) {
    $routeProvider
      .when('/vacancies', {
        templateUrl: 'vacancies.html',
        controller: 'VacanciesController'
      })
      .when('/vacancies/search', {
        templateUrl: 'vacancies.html',
        controller: 'VacancySearchController'
      })
      .when('/vacancies/new', {
        templateUrl: 'vacancy_form.html',
        controller: 'VacancyFormController'
      })
      .when('/vacancies/:vacancyId/edit', {
        templateUrl: 'vacancy_form.html',
        controller: 'VacancyFormController'
      })
      .when('/applicants', {
        templateUrl: 'applicants.html',
        controller: 'ApplicantsController'
      })
      .when('/applicants/new', {
        templateUrl: 'applicant_form.html',
        controller: 'ApplicantFormController'
      })
      .when('/applicants/:applicantId/edit', {
        templateUrl: 'applicant_form.html',
        controller: 'ApplicantFormController'
      })
      .otherwise({
        redirectTo: '/vacancies'
      })
    ;
  }
])
.config([
  '$httpProvider',
  function($httpProvider) {
    $httpProvider.defaults.headers.common['Accept'] = 'application/json';
  }
])
;
