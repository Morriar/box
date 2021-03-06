/*
 * Copyright 2017 Alexandre Terrasa <alexandre@moz-code.org>.
 *
 * Licensed under the Apache License, Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

(function() {
	angular.module('ng-app', ['ui.router', 'angular-loading-bar', 'ui.bootstrap', 'pascalprecht.translate', 'users', 'boxes', 'lang'])

	/* Config */

	.config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
		cfpLoadingBarProvider.includeSpinner = false;
	}])

	.config(function ($translateProvider) {
		$translateProvider.useSanitizeValueStrategy(null);
		$translateProvider.fallbackLanguage('en');
		$translateProvider.preferredLanguage('en');
	})

	.run(['$anchorScroll', function($anchorScroll) {
		$anchorScroll.yOffset = 80;
	}])

	/* Router */

	.config(function ($stateProvider, $locationProvider) {
		$locationProvider.html5Mode(true);
		$stateProvider
			.state({
				name: 'root',
				abstract: true,
				resolve: {
					session: function(Errors, Users, $q) {
						var d = $q.defer();
						Users.getAuth(d.resolve, function () { d.resolve(null) });
						return d.promise;
					}
				},
				controller: function(session) {
					this.session = session;
				},
				controllerAs: 'vm',
				templateUrl: '/views/root.html'
			})
			.state({
				name: 'root.home',
				url: '/',
				controller: 'BoxesCtrl',
				controllerAs: 'vm',
				templateUrl: '/views/index.html'
			})
			.state({
				name: 'root.otherwise',
				url: '*path',
				template: '<panel404 />'
			})
	})

	/* Model */

	.factory('Errors', function() {
		return {
			handleError: function(err) {
				console.log(err);
			}
		}
	})

	/* Controllers */

	.controller('BoxesCtrl', function(Errors, Boxes) {
		var vm = this;

		this.search = function() {
			Boxes.search(vm.searchString, function(data) {
				vm.boxes = data;
			}, Errors.handleError);
		}
	})

	/* Directives */

	.directive('selectLang', function() {
		return {
			scope: {},
			controller: function($translate, $window) {
				var locale = $window.navigator.language.split('-')[0];
				var vm = this;
				vm.currentLang = locale;
				vm.select = function(lang) {
					$translate.use(lang);
					vm.currentLang = lang;
				}
			},
			controllerAs: 'vm',
			templateUrl: '/directives/select-lang.html',
			restrict: 'E',
			replace: true
		};
	})

	.directive('panel403', function(Users, $location) {
		return {
			scope: {},
			controller: function() {
				this.login = function() {
					Users.login($location.absUrl());
				}
			},
			controllerAs: 'vm',
			templateUrl: '/directives/403-panel.html',
			restrict: 'E',
			replace: true
		};
	})

	.directive('panel404', function() {
		return {
			scope: {},
			templateUrl: '/directives/404-panel.html',
			restrict: 'E',
			replace: true
		};
	})
})();
