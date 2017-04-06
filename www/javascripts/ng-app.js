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

	.run(['$anchorScroll', function($anchorScroll) {
		$anchorScroll.yOffset = 80;
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
				templateUrl: '/views/box.html',
				abstract: true
			})
			.state({
				name: 'box.submit',
				url: '',
				controller: 'BoxSubmitCtrl',
				controllerAs: 'vm',
				templateUrl: '/views/box/submit.html'
			})
			.state({
				name: 'box.submission',
				url: '/submission/{sId}',
				controller: 'BoxSubmitCtrl',
				controllerAs: 'vm',
				templateUrl: '/views/box/submit.html'
			})
			.state({
				name: 'box.submissions',
				url: '/submissions',
				controller: 'BoxUserSubmissionsCtrl',
				controllerAs: 'vm',
				templateUrl: '/views/box/user-submissions.html'
			})
			.state({
				name: 'user',
				url: '/user',
				controller: function($scope, $state) {
					$scope.$on('$stateChangeSuccess', function(){
						if(!$scope.session) $state.go('home');
					});
				},
				controllerAs: 'vm',
				templateUrl: '/views/user.html',
				abstract: true
			})
			.state({
				name: 'user.boxes',
				url: '/boxes',
				controller: 'UserBoxesCtrl',
				controllerAs: 'vm',
				templateUrl: '/views/user/boxes.html',
			})
			.state({
				name: 'user.submissions',
				url: '/submissions',
				controller: 'UserSubmissionsCtrl',
				controllerAs: 'vm',
				templateUrl: '/views/user/submissions.html',
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
