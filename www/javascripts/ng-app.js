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
	angular.module('ng-app', ['ui.router', 'ngSanitize', 'angular-loading-bar', 'ui.bootstrap', 'users', 'boxes', 'editor'])

	.config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
		cfpLoadingBarProvider.includeSpinner = false;
	}])

	.config(function ($stateProvider, $locationProvider) {
		$locationProvider.html5Mode(true);
		$stateProvider
			.state({
				name: 'home',
				url: '/',
				controller: 'BoxesCtrl',
				controllerAs: 'vm',
				templateUrl: '/views/index.html'
			})
			.state({
				name: 'box',
				url: '/box/{bId}',
				controller: 'BoxCtrl',
				controllerAs: 'vm',
				templateUrl: '/views/box.html'
			})
			.state({
				name: 'otherwise',
				url: '*path',
				template: '<panel404 />'
			})
	})

	.factory('Errors', function($rootScope) {
		return {
			handleError: function(err) {
				console.log(err);
			}
		}
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
