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
					name: 'root.box',
					url: '/box/{bId}',
					templateUrl: '/views/box.html',
					resolve: {
						box: function(Boxes, $q, $stateParams) {
							var d = $q.defer();
							Boxes.getBox($stateParams.bId, d.resolve, function() {d.resolve()});
							return d.promise;
						}
					},
					controller: function(session, box) {
						this.session = session;
						this.box = box;
					},
					controllerAs: 'vm',
					abstract: true
				})
				.state({
					name: 'root.box.tests',
					url: '/tests',
					templateUrl: '/views/box/tests.html',
					resolve: {
						tests: function(Boxes, $q, $stateParams) {
							var d = $q.defer();
							Boxes.getBoxTests($stateParams.bId,
								d.resolve, function() {d.resolve()});
							return d.promise;
						}
					},
					controller: function(tests) {
						this.tests = tests;
					},
					controllerAs: 'vm'
				})
				.state({
					name: 'root.box.submit',
					url: '',
					templateUrl: '/views/box/submit.html',
					resolve: {
						submission: function(Boxes, $q, $stateParams) {
							var d = $q.defer();
							Boxes.lastSubmission($stateParams.bId,
								d.resolve, function() {d.resolve()});
							return d.promise;
						},
						status: function(Boxes, $q, $stateParams) {
							var d = $q.defer();
							Boxes.lastSubmissionStatus($stateParams.bId,function(data) {console.log(data); 
								d.resolve(data)}, function() {d.resolve()});
							return d.promise;
						}
					},
					controller: 'BoxSubmitCtrl',
					controllerAs: 'vm'
				})
				.state({
					name: 'root.box.submission',
					url: '/submission/{sId}',
					templateUrl: '/views/box/submit.html',
					resolve: {
						submission: function(Boxes, $q, $stateParams) {
							var d = $q.defer();
							Boxes.getSubmission($stateParams.bId, $stateParams.sId,
								d.resolve, function() {d.resolve()});
							return d.promise;
						},
						status: function(Boxes, $q, $stateParams) {
							var d = $q.defer();
							Boxes.getSubmissionStatus($stateParams.bId, $stateParams.sId,
								d.resolve, function() {d.resolve()});
							return d.promise;
						}
					},
					controller: 'BoxSubmitCtrl',
					controllerAs: 'vm'
				})
				.state({
					name: 'root.box.submissions',
					url: '/submissions',
					templateUrl: '/views/box/user-submissions.html',
					resolve: {
						submissions: function(Boxes, $q, $stateParams) {
							var d = $q.defer();
							Boxes.getSubmissions($stateParams.bId,
								d.resolve, function() {d.resolve()});
							return d.promise;
						},
					},
					controller: function(box, submissions) {
						this.box = box;
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
				getSubmissionStatus: function(bid, sid, cb, cbErr) {
					$http.get(apiUrl + '/boxes/' + bid + '/submissions/' + sid + '/status')
						.success(cb)
						.error(cbErr);
				},
				lastSubmission: function(bid, cb, cbErr) {
					$http.get(apiUrl + '/boxes/' + bid + '/submit')
						.success(cb)
						.error(cbErr);
				},
				lastSubmissionStatus: function(bid, cb, cbErr) {
					$http.get(apiUrl + '/boxes/' + bid + '/submit/status')
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

		.controller('BoxSubmitCtrl', function(Errors, Boxes, $scope, $anchorScroll, session, box, submission, status) {
			var vm = this;

			vm.checkSubmissionStatus = function() {
				Boxes.getSubmissionStatus(vm.box.id, vm.submission.id, function(data) {
					vm.status = data;
					if(vm.status.is_pending) {
						setTimeout(function() {
							vm.checkSubmissionStatus();
						}, 1000);
					}
				}, Errors.handleError);
			}

			vm.checkSubmission = function() {
				Boxes.checkSubmission(vm.box.id, {
						files: vm.submission.files
					}, function(data) {
					vm.submission = data;
					vm.checkSubmissionStatus();
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
				if(!vm.status.is_runned || !vm.status.is_passed) {
					$('#warningModal').modal();
				} else {
					vm.postSubmission();
				}
			};

			vm.postSubmission = function() {
				Boxes.sendSubmission(vm.box.id, {
						files: vm.submission.files,
						teammate: vm.submission.teammate
					}, function (data) {
					$('#warningModal').modal('hide');
					$('#submitModal').modal();
				}, Errors.handleError);
			};

			vm.session = session;
			vm.box = box;
			vm.submission = submission;
			vm.status = status;

			if(vm.submission) {
				vm.checkSubmissionStatus();
			}
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
