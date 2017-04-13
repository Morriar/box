/*
 * Copyright 2017 Alexandre Terrasa <alexandre@moz-code.org>.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

(function() {
	angular
		.module('users', [])

		/* Router */

		.config(function ($stateProvider, $locationProvider) {
			$locationProvider.html5Mode(true);
			$stateProvider
				.state({
					name: 'user',
					url: '/user',
					controller: function($scope, $state) {},
					controllerAs: 'vm',
					templateUrl: '/views/user.html',
					abstract: true
				})
				.state({
					name: 'user.boxes',
					url: '/boxes',
					templateUrl: '/views/user/boxes.html',
					resolve: {
						boxes: function(Errors, Users, $q) {
							var deferred = $q.defer();
							Users.getBoxes(deferred.resolve, Errors.handleError);
							return deferred.promise;
						}
					},
					controller: function(boxes) {
						this.boxes = boxes;
					},
					controllerAs: 'vm'
				})
				.state({
					name: 'user.submissions',
					url: '/submissions',
					templateUrl: '/views/user/submissions.html',
					resolve: {
						submissions: function(Errors, Users, $q) {
							var deferred = $q.defer();
							Users.getSubmissions(deferred.resolve, Errors.handleError);
							return deferred.promise;
						}
					},
					controller: function(submissions) {
						this.submissions = submissions;
					},
					controllerAs: 'vm'
				})
		})

		/* Model */

		.factory('Users', [ '$http', function($http) {
			var apiUrl = '/api';
			return {
				login: function(redirectionUrl) {
					window.location.replace('/auth/shib/login?next=' + redirectionUrl);
				},
				logout: function(redirectionUrl) {
					window.location.replace('/auth/logout?next=' + redirectionUrl);
				},
				getAuth: function(cb, cbErr) {
					$http.get(apiUrl + '/user')
						.success(cb)
						.error(cbErr);
				},
				getBoxes: function(cb, cbErr) {
					$http.get(apiUrl + '/user/boxes')
						.success(cb)
						.error(cbErr);
				},
				getSubmissions: function(cb, cbErr) {
					$http.get(apiUrl + '/user/submissions')
						.success(cb)
						.error(cbErr);
				}
			}
		}])

		/* Controllers */

		.controller('AuthCtrl', function(Errors, Users, $rootScope, $location) {
			this.login = function() {
				Users.login($location.absUrl());
			}

			this.logout = function() {
				Users.logout($location.absUrl());
			}

			Users.getAuth(function(data) {
				$rootScope.session = data;
			}, Errors.handleError);
		})

		/* Directives */

		.directive('userMenu', function(Errors, $rootScope) {
			return {
				controller: 'AuthCtrl',
				controllerAs: 'vm',
				templateUrl: '/directives/users/menu.html',
				restrict: 'E',
				replace: true
			};
		})
})();
