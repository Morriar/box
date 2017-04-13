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
	angular.module('lang-fr', ['pascalprecht.translate'])

	.config(function ($translateProvider) {
		$translateProvider.translations('fr', {
			/* User Menu */
			'LOGIN': 'Se connecter avec l\'UQÀM',
			'LOGOUT': 'Se deconnecter',
			'MY_BOXES': 'Mes boîtes',
			'MY_SUBMISSIONS': 'Mes soumissions',
			'NOTHING_TO_SHOW': 'Il n\'y a rien à afficher ici.',
			'CLOSE': 'Fermer',
			'CANCEL': 'Annuler',
			'USER': 'utilisateur',

			/* Root */
			'WELCOME': 'Bienvenue sur Box!',
			'SEARCH_BOX': 'Sélectionnez une boîte pour déposer votre travail:',
			'SEARCH_BY': 'Cherchez une boîte par ID ou par code de professeur',
			'SEARCH_NO_RESULTS': 'Aucun résultat',
			'POWERED_BY': 'est propulsé par',

			/* Box */
			'BOX': 'boîte',
			'BOXES': 'boîtes',
			'SUBMISSION': 'soumission',
			'SUBMISSIONS': 'soumissions',
			'PUBLIC_TESTS': 'tests publics',
			'PRIVATE_TESTS': 'tests privés',
			'CLOSES_AT': 'ferme le',
			'BOX_CLOSED': 'FERMÉE',
			'APPROUVED': 'approuvée',
			'CHECK_AND_SUBMIT': 'Vérifier & Envoyer',
			'TEST_CASES': 'cas de test',
			'TESTS_PASSED': 'tests réussis',
			'ERROR': 'ERREUR',
			'SUCCESS': 'SUCCÈS',
			'FAILURE': 'ERREUR',
			'WARNING': 'ATTENTION',
			'NOTRUNNED': 'NON EXÉCUTÉ',
			'INPUT': 'Entrée',
			'EXPECTED_OUTPUT': 'Sortie attendue',
			'YOUR_OUTPUT': 'Votre sortie',
			'YOU_FAILED': 'Vous avez échoué ce test!',
			'YOU_PASSED': 'Bravo, vous avez réussi ce test!',

			/* Submission */
			'WRITE_THE_CODE': 'Écrivez le code',
			'TRY_YOUR_WORK': 'Vérifiez votre travail',
			'CHECK_MY_WORK': 'Vérifier mon travail',
			'TESTED_AGAINST': 'Votre code va être testé contre',
			'SEND_YOUR_WORK': 'Envoyez votre code au professeur',
			'DEPOSED_AS': 'Votre code va être déposé en tant que',
			'ADD_TEAMMATE': 'Ajouter un coéquipier:',
			'TEAMMATE': 'coéquipier',
			'WARN_UNCHECKED': 'Vous ne devriez pas envoyer votre travail avant de l\'avoir testé.',
			'WARN_FAILURE': 'Vous ne devriez pas envoyer votre travail avant de passer tous les tests.',
			'WARN_LAST': 'Seulement votre dernière soumission sera évaluée par le professeur.',
			'ARE_YOU_SURE': 'Êtes-vous certain de vouloire l\'envoyer?',
			'SEND_MY_WORK': 'Envoyer mon travail',
			'TEAMMATE_ERROR': 'Le code permanent du coéquipier est invalide.',
			'PENDING': 'Patientez...',
			'TESTING_YOUR_SUBMISSION': 'Vérification de votre soumission...',
			'SEND_ANYWAY': 'Envoyer quand même',
			'WORK_SENT': 'Votre travail a été remi au professeur pour évaluation',
			'TIMESTAMP': 'horodatage',

			/* Errors */
			'404': 'Page non trouvée',
			'404_HELP': 'La page que vous cherchez n\'existe pas.',
			'403': 'Connexion requise',
			'403_HELP': 'Vous devez être connecté pour tester et envoyer votre travail.',
		});
	})
})();
