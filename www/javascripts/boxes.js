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
		.module('boxes', ['ngSanitize', 'editor'])

		/* Router */

		.config(function ($stateProvider, $locationProvider) {
			$locationProvider.html5Mode(true);
			$stateProvider
				.state({
					name: 'box',
					url: '/box/{bId}',
					templateUrl: '/views/box.html',
					resolve: {
						box: function(Errors, Boxes, $q, $stateParams) {
							var deferred = $q.defer();
							Boxes.getBox($stateParams.bId, deferred.resolve, Errors.handleError);
							return deferred.promise;
						}
					},
					controller: function(box) {
						this.box = box;
					},
					controllerAs: 'vm',
					abstract: true
				})
				.state({
					name: 'box.tests',
					url: '/tests',
					templateUrl: '/views/box/tests.html',
					resolve: {
						tests: function(Errors, Boxes, $q, $stateParams) {
							var deferred = $q.defer();
							Boxes.getBoxTests($stateParams.bId,
								deferred.resolve, Errors.handleError);
							return deferred.promise;
						}
					},
					controller: function(tests) {
						this.tests = tests;
					},
					controllerAs: 'vm'
				})
				.state({
					name: 'box.submit',
					url: '',
					templateUrl: '/views/box/submit.html',
					resolve: {
						submission: function(Errors, Boxes, $q, $stateParams) {
							var deferred = $q.defer();
							Boxes.lastSubmission($stateParams.bId,
								deferred.resolve, Errors.handleError);
							return deferred.promise;
						}
					},
					controller: 'BoxSubmitCtrl',
					controllerAs: 'vm'
				})
				.state({
					name: 'box.submission',
					url: '/submission/{sId}',
					templateUrl: '/views/box/submit.html',
					resolve: {
						submission: function(Errors, Boxes, $q, $stateParams) {
							var deferred = $q.defer();
							Boxes.getSubmission($stateParams.bId, $stateParams.sId,
								deferred.resolve, Errors.handleError);
							return deferred.promise;
						}
					},
					controller: 'BoxSubmitCtrl',
					controllerAs: 'vm'
				})
				.state({
					name: 'box.submissions',
					url: '/submissions',
					templateUrl: '/views/box/user-submissions.html',
					resolve: {
						submissions: function(Errors, Boxes, $q, $stateParams) {
							var deferred = $q.defer();
							Boxes.getSubmissions($stateParams.bId,
								deferred.resolve, Errors.handleError);
							return deferred.promise;
						}
					},
					controller: function(submissions) {
						this.submissions = submissions;
					},
					controllerAs: 'vm',

				})
		})

		/* Model */

		.factory('Boxes', [ '$http', function($http) {
			var apiUrl = '/api';
			return {
				search: function(searchString, cb, cbErr) {
					$http.get(apiUrl + '/search?q=' + searchString)
						.success(cb)
						.error(cbErr);
				},
				getBoxes: function(cb, cbErr) {
					$http.get(apiUrl + '/boxes')
						.success(cb)
						.error(cbErr);
				},
				getBox: function(bid, cb, cbErr) {
					$http.get(apiUrl + '/boxes/' + bid)
						.success(cb)
						.error(cbErr);
				},
				getBoxTests: function(bid, cb, cbErr) {
					$http.get(apiUrl + '/boxes/' + bid + '/tests')
						.success(cb)
						.error(cbErr);
				},
				getSubmissions: function(bid, cb, cbErr) {
					$http.get(apiUrl + '/boxes/' + bid + '/submissions')
						.success(cb)
						.error(cbErr);
				},
				getSubmission: function(bid, sid, cb, cbErr) {
					$http.get(apiUrl + '/boxes/' + bid + '/submissions/' + sid)
						.success(cb)
						.error(cbErr);
				},
				saveSubmission: function(bid, sid, data, cb, cbErr) {
					$http.post(apiUrl + '/boxes/' + bid + '/submissions/' + sid, data)
						.success(cb)
						.error(cbErr);
				},
				lastSubmission: function(bid, cb, cbErr) {
					$http.get(apiUrl + '/boxes/' + bid + '/submit')
						.success(cb)
						.error(cbErr);
				},
				checkSubmission: function(bid, data, cb, cbErr) {
					$http.post(apiUrl + '/boxes/' + bid + '/submit', data)
						.success(cb)
						.error(cbErr);
				},
				sendSubmission: function(bid, data, cb, cbErr) {
					$http.put(apiUrl + '/boxes/' + bid + '/submit', data)
						.success(cb)
						.error(cbErr);
				}
			}
		}])

		/* Controllers */

		.controller('BoxSubmitCtrl', function(Errors, Boxes, $scope, $anchorScroll, box, submission) {
			var vm = this;

			$scope.$on('code-change', function(event, file) {
				Boxes.saveSubmission(
					vm.box.id, vm.submission.id, vm.submission, function(data) {
				}, Errors.handleError);
			})

			vm.checkSubmission = function() {
				$('#pendingModal').modal({backdrop: 'static'});
				Boxes.checkSubmission(vm.box.id, vm.submission, function(data) {
					vm.results = data;
					setTimeout(function() {
						$('#pendingModal').modal('hide');
						$anchorScroll('submit');
					}, 500);
				}, Errors.handleError);
			}

			vm.sendSubmission = function () {
				vm.submitErrors = {};
				if(vm.submission.teammate) {
					if(!/^[A-Z]{4}[0-9]{8}$/.test(vm.submission.teammate)) {
						vm.submitErrors.teammate = 'Teammate student code seems invalid'
						return false;
					}
				}
				Boxes.sendSubmission(vm.box.id, vm.submission, function (data) {
					$('#submitModal').modal();
				}, Errors.handleError);
			};

			vm.box = box;
			vm.submission = submission;
		})

		/* Directives */

		.directive('boxList', function () {
			return {
				scope: {},
				bindToController: {
					boxes: '='
				},
				controller: function() {},
				controllerAs: 'vm',
				restrict: 'E',
				replace: true,
				templateUrl: '/directives/boxes/box-list.html'
			};
		})

		.directive('boxPanel', function () {
			return {
				scope: {},
				bindToController: {
					box: '='
				},
				controller: function() {},
				controllerAs: 'vm',
				restrict: 'E',
				replace: true,
				templateUrl: '/directives/boxes/box-panel.html'
			};
		})

		.directive('testPanel', function () {
			return {
				scope: {},
				bindToController: {
					test: '='
				},
				controller: function() {},
				controllerAs: 'vm',
				restrict: 'E',
				replace: true,
				templateUrl: '/directives/boxes/test-panel.html'
			};
		})

		.directive('testCard', function () {
			return {
				scope: {},
				bindToController: {
					test: '='
				},
				controller: function() {},
				controllerAs: 'vm',
				restrict: 'E',
				replace: true,
				templateUrl: '/directives/boxes/test-card.html'
			};
		})

		.directive('testDiff', function() {
			return {
				scope: {
					diffId: '@',
					diffString: '@'
				},
				restrict: 'E',
				link: function($scope, $element, $attr) {
					$scope.$watch('diffString', function(diffString) {
						var diff2htmlUi = new Diff2HtmlUI({diff: $scope.diffString});
						diff2htmlUi.draw("#" + $scope.diffId, {
							inputFormat: 'json',
							outputFormat: 'side-by-side',
							matching: 'lines',
							synchronisedScroll: true
						});
					});
				},
				templateUrl: '/directives/boxes/diff-panel.html'
			};
		})
})();
