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

		.controller('UserBoxesCtrl', function(Errors, Users, Boxes, $state) {
			var vm = this;

			Users.getBoxes(function(data) {
				vm.boxes = data;
			}, Errors.handleError);
		})

		.controller('UserSubmissionsCtrl', function(Errors, Users) {
			var vm = this;
			Users.getSubmissions(function(data) {
				vm.submissions = data;
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
