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
		.module('editor', [])

		.controller('CodeEditorCtrl', function($scope) {
			var vm = this;

			vm.buffers = {};
			vm.current = null;

			vm.createBuffer = function(name, text, mode) {
				vm.buffers[name] = CodeMirror.Doc(text, mode);
			}

			vm.openBuffer = function(name) {
				var buffer = vm.buffers[name];
				if (buffer.getEditor()) {
					buffer = buffer.linkedDoc({sharedHist: true});
				}
				var old = vm.editor.swapDoc(buffer);
				var linked = old.iterLinkedDocs(function(doc) {linked = doc;});
				if (linked) {
					for (var name in vm.buffers) {
						if (vm.buffers[name] == old) vm.buffers[name] = linked;
					}
					old.unlinkDoc(linked);
				}
				vm.current = name;
				vm.editor.focus();
			}

			vm.init = function(div) {
				vm.editor = CodeMirror(div, {
					lineNumbers: true,
					matchBrackets: true,
					viewportMargin: Infinity
				});
				vm.editor.on('change', function(CodeMirror) {
					vm.files.forEach(function(file) {
						if(file.path == vm.current) {
							file.content = CodeMirror.doc.getValue();
							$scope.$emit('code-change', file)
						}
					})
				});
				vm.files.forEach(function(file) {
					vm.createBuffer(file.path, file.content, file.extension);
				})
				vm.openBuffer(vm.files[0].path);
			}

			$scope.$on('code-fileopen', function($event, file) {
				vm.openBuffer(file.path);
			})
		})

		/* Directives */

		.directive('codeEditor', function () {
			return {
				scope: {},
				bindToController: {
					files: '='
				},
				controller: 'CodeEditorCtrl',
				controllerAs: 'vm',
				link: function($scope, $el, $attr, CodeEditorCtrl) {
					CodeEditorCtrl.init(angular.element('#code-mirror')[0]);
				},
				restrict: 'E',
				replace: true,
				templateUrl: '/directives/editor/code-editor.html'
			};
		})

		.directive('codeFiletree', function () {
			return {
				scope: {},
				bindToController: {
					files: '=',
					prefix: '=?',
					active: '=?'
				},
				controller: function($scope) {
					var vm = this;
					vm.roots = {};
					vm.files.forEach(function(file){
						if(!vm.active) vm.active = file.path;

						var parts = file.path.split('/');

						var prefix = [];
						if(vm.prefix) {
							var pparts = vm.prefix.split('/');
							while(parts[0] == pparts[0]) {
								prefix.push(parts[0]);
								parts = parts.slice(1);
								pparts = pparts.slice(1);
							}
						}
						prefix.push(parts[0]);
						var key = prefix.join('/');

						if(parts.length == 1) {
							vm.roots[key] = file
							return;
						}

						if(!vm.roots[key]) {
							vm.roots[key] = {
								id: prefix.join('-'),
								filename: parts[0],
								path: parts[0],
								children: []
							}
						}

						vm.roots[key].children.push(file)
					})

					vm.open = function(file) {
						vm.active = file.path;
						$scope.$emit('code-fileopen', file);
					}

					$scope.$on('code-fileopen', function($event, file) {
						vm.active = file.path;
					})
				},
				controllerAs: 'vm',
				restrict: 'E',
				replace: true,
				templateUrl: '/directives/editor/code-filetree.html'
			};
		})
})();
