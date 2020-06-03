app.directive('passwordConfirm', ['$window', function ($window) {
    var obvious = [];

    return {
        scope: {
            valid: '=valid',
            minEntropy: '=minEntropy',
            password: '=password'
        },
        link: function (scope) {
            if (scope.minEntropy === undefined) {
                scope.minEntropy = 15;
            }

            // init values
            scope.entropy = 0;

            scope.passwordsMatch = function () {
                return scope.password === scope.confirm;
            };

            scope.passwordIsStrong = function () {
                return scope.entropy > scope.minEntropy;
            };

            scope.$watch('password', function (pass) {
                if ($window.zxcvbn === undefined) {
                    scope.entropy = 0;
                    return;
                }

                if (pass && pass.length >= 8) {
                    scope.entropy = zxcvbn(pass, obvious).entropy;
                }
                else {
                    scope.entropy = 0;
                }
            });

            scope.$watch(function () {
                return scope.passwordIsStrong() && scope.passwordsMatch();
            }, function (val) {
                scope.valid = val;
            });
        },
        templateUrl: '/static/directives/password-confirm.html'
    };

}]);
/**
 * Created by justin on 4/13/16.
 */
