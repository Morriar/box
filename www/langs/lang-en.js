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
	angular.module('lang-en', ['pascalprecht.translate'])

	.config(function ($translateProvider) {
		$translateProvider.translations('en', {
			/* User Menu */
			'LOGIN': 'Login with UQÀM',
			'LOGOUT': 'Logout',
			'MY_BOXES': 'My boxes',
			'MY_SUBMISSIONS': 'My submissions',
			'NOTHING_TO_SHOW': 'Nothing to show here.',
			'CLOSE': 'Close',
			'CANCEL': 'Cancel',
			'USER': 'user',

			/* Root */
			'WELCOME': 'Welcome to Box!',
			'SEARCH_BOX': 'Select a box to submit your work:',
			'SEARCH_BY': 'Search a box by its id or professor code',
			'SEARCH_NO_RESULTS': 'Nothing found for your query...',
			'POWERED_BY': 'is powered by',

			/* Box */
			'BOX': 'box',
			'BOXES': 'boxes',
			'SUBMISSION': 'submission',
			'SUBMISSIONS': 'submissions',
			'PUBLIC_TESTS': 'public tests',
			'PRIVATE_TESTS': 'private tests',
			'CLOSES_AT': 'closes on',
			'BOX_CLOSED': 'CLOSED',
			'APPROUVED': 'approuved',
			'CHECK_AND_SUBMIT': 'check & submit',
			'TEST_CASES': 'test cases',
			'TESTS_PASSED': 'tests passed',
			'ERROR': 'ERROR',
			'SUCCESS': 'SUCCESS',
			'FAILURE': 'FAILURE',
			'WARNING': 'WARNING',
			'NOTRUNNED': 'NOT RUNNED',
			'INPUT': 'Input',
			'EXPECTED_OUTPUT': 'Expected output',
			'YOUR_OUTPUT': 'Your output',
			'YOU_FAILED': 'You failed this test!',
			'YOU_PASSED': 'Congratulations, you passed this test!',

			/* Submission */
			'WRITE_THE_CODE': 'Write the code',
			'TRY_YOUR_WORK': 'Try your work',
			'CHECK_MY_WORK': 'Try my work',
			'TESTED_AGAINST': 'Your code will be tested against',
			'SEND_YOUR_WORK': 'Send your work to the professor',
			'DEPOSED_AS': 'Your work will be deposed as',
			'ADD_TEAMMATE': 'Add a teammate:',
			'TEAMMATE': 'teammate',
			'WARN_UNCHECKED': 'You should not submit your work until you have tested it.',
			'WARN_FAILURE': 'You should not submit your work until you pass all the public tests.',
			'WARN_LAST': 'Only your last submission will be evaluated by the professor.',
			'ARE_YOU_SURE': 'Are you sure you want to send it the professor?',
			'SEND_MY_WORK': 'Send my work',
			'TEAMMATE_ERROR': 'Teammate student code seems invalid.',
			'PENDING': 'Pending...',
			'TESTING_YOUR_SUBMISSION': 'Testing your submission...',
			'SEND_ANYWAY': 'Send anyway',
			'WORK_SENT': 'Your work has been sent to the professor for evaluation.',
			'TIMESTAMP': 'timestamp',

			/* Errors */
			'404': 'Page not found',
			'404_HELP': 'The page your are looking for does not exist.',
			'403': 'Please login',
			'403_HELP': 'You must be logged in to check and submit your work.',
		});
	})
})();
