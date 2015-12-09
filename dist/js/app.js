'use strict';
angular.module('touk.applyFilter', []).run([
  '$rootScope', '$parse', function($scope, $parse) {
    return $scope.constructor.prototype.applyFilter = function(filter, value) {
      if (filter) {
        return $parse(value + " | " + filter)();
      } else {
        return value;
      }
    };
  }
]);
;'use strict';
angular.module('touk.dowod.directives', ['touk.dowod.validators']).directive('validateDowod', [
  'dowod', 'HotKeysElement', function(validator, HotKeys) {
    return {
      restrict: 'A',
      require: 'ngModel',
      link: function(scope, element, attrs, ctrl) {
        return ctrl.$validators.dowod = function(modelValue, viewValue) {
          var value;
          value = modelValue || viewValue;
          return ctrl.$isEmpty(value) || validator.validate(value);
        };
      }
    };
  }
]);
;'use strict';
var Dowod,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

angular.module('touk.dowod.validators', []).service('dowod', Dowod = (function() {
  function Dowod() {
    this.generate = bind(this.generate, this);
    this.validate = bind(this.validate, this);
  }

  Dowod.prototype.charMap = {
    A: 10,
    B: 11,
    C: 12,
    D: 13,
    E: 14,
    F: 15,
    G: 16,
    H: 17,
    I: 18,
    J: 19,
    K: 20,
    L: 21,
    M: 22,
    N: 23,
    O: 24,
    P: 25,
    Q: 26,
    R: 27,
    S: 28,
    T: 29,
    U: 30,
    V: 31,
    W: 32,
    X: 33,
    Y: 34,
    Z: 35
  };

  Dowod.prototype.weights = [7, 3, 1, 9, 7, 3, 1, 7, 3];

  Dowod.prototype.sum = function(chars) {
    var char, i, j, len, num, ref, sum, weight;
    sum = 0;
    ref = this.weights;
    for (i = j = 0, len = ref.length; j < len; i = ++j) {
      weight = ref[i];
      char = chars[i];
      if (i < 3) {
        num = this.charMap[char];
      } else {
        num = parseInt(char);
      }
      sum += weight * (num || 0);
    }
    return sum = sum % 10;
  };

  Dowod.prototype.validate = function(dowod) {
    var chars;
    if (!/^[a-z]{3}[0-9]{6}$/i.test(dowod)) {
      return false;
    }
    chars = dowod.toString().toUpperCase().split('');
    return this.sum(chars) === 0;
  };

  Dowod.prototype.generate = function() {
    var char, chars, dowod, i, j, k, r, ref, v;
    chars = [];
    for (i = j = 0; j <= 7; i = ++j) {
      if (i < 3) {
        r = 10 + Math.round(Math.random() * 15);
        ref = this.charMap;
        for (k in ref) {
          v = ref[k];
          if (r === v) {
            char = k;
          }
        }
      } else {
        char = (Math.round(Math.random() * 9)).toString();
      }
      chars[i] = char;
    }
    chars[8] = (this.weights[8] * this.sum(chars) % 10).toString();
    return dowod = chars.join('');
  };

  return Dowod;

})());
;'use strict';
angular.module('touk.email.directives', ['touk.email.validators']).directive('validateEmail', [
  'EmailValidator', function(Validator) {
    return {
      restrict: 'A',
      require: 'ngModel',
      link: function(scope, element, attrs, ctrl) {
        return ctrl.$validators.email = function(modelValue, viewValue) {
          var value;
          value = modelValue || viewValue;
          return ctrl.$isEmpty(value) || new Validator().validate(value);
        };
      }
    };
  }
]);
;'use strict';
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

angular.module('touk.email.validators', []).factory('EmailValidator', function() {
  var EmailValidator;
  return EmailValidator = (function() {
    function EmailValidator() {
      this.validate = bind(this.validate, this);

      /* RFC */
      this.regex = /^(?:[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$/i;
    }

    EmailValidator.prototype.validate = function(text) {
      if (this.regex.test(text)) {
        return true;
      }
      return false;
    };

    return EmailValidator;

  })();
});
;String.prototype.has = function(subString) {
  return this.hasSubstring(subString);
};

String.prototype.hasSubstring = function(subString) {
  return Boolean(this.match(new RegExp(subString, 'gi')));
};

String.prototype.startsWith = function(subString) {
  return Boolean(this.indexOf(subString) === 0);
};

String.prototype.isOnlyDigits = function() {
  return Boolean(/^\d+$/.test(this));
};

Array.prototype.has = function(element) {
  return Boolean(this.indexOf(element) >= 0);
};

Array.prototype.unique = function() {
  return _.unique(this);
};

Array.prototype.divideBy = function(num) {
  var el, i, j, ref, results;
  if (!_.isNumber(num) || num < 2) {
    return [this];
  }
  results = [];
  for (i = j = 0, ref = num - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
    results.push((function() {
      var k, len, ref1, ref2, results1;
      ref2 = this.slice(i);
      ref1 = num;
      results1 = [];
      for ((ref1 > 0 ? (k = 0, len = ref2.length) : k = ref2.length - 1); ref1 > 0 ? k < len : k >= 0; k += ref1) {
        el = ref2[k];
        results1.push(el);
      }
      return results1;
    }).call(this));
  }
  return results;
};
;'use strict';
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

angular.module('touk.locale.directive', ['touk.locale.service']).directive('languageChangeSelect', function() {
  var LanguageSelect;
  return {
    restrict: 'EA',
    template: "<select\n	ng-model=\"LSC.currentLocaleDisplayName\"\n	ng-options=\"name as (name | translate) for name in LSC.localesDisplayNames\"\n	ng-change=\"LSC.changeLanguage()\"\n></select>",
    controller: [
      'LocaleService', '$scope', LanguageSelect = (function() {
        function LanguageSelect($service, $scope) {
          this.$service = $service;
          this.changeLanguage = bind(this.changeLanguage, this);
          this.currentLocaleDisplayName = this.$service.getLocaleDisplayName();
          this.localesDisplayNames = this.$service.getLocalesDisplayNames();
        }

        LanguageSelect.prototype.changeLanguage = function(currentLocaleDisplayName) {
          this.currentLocaleDisplayName = currentLocaleDisplayName != null ? currentLocaleDisplayName : this.currentLocaleDisplayName;
          return this.$service.setLocaleByDisplayName(this.currentLocaleDisplayName);
        };

        return LanguageSelect;

      })()
    ],
    controllerAs: 'LSC',
    scope: {}
  };
});
;'use strict';
var LocaleService,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  slice = [].slice;

LocaleService = (function() {
  function LocaleService($translate, $rootScope, tmhDynamicLocale, LOCALES) {
    this.$translate = $translate;
    this.getLocalesDisplayNames = bind(this.getLocalesDisplayNames, this);
    this.setLocaleByDisplayName = bind(this.setLocaleByDisplayName, this);
    this.getLocaleDisplayName = bind(this.getLocaleDisplayName, this);
    this.setLocale = bind(this.setLocale, this);
    this.checkLocaleIsValid = bind(this.checkLocaleIsValid, this);
    this.locales = LOCALES.locales, this.preferredLocale = LOCALES.preferredLocale;
    if (!_.size(this.locales)) {
      console.error("There are no locales provided.\nDefine \"LOCALES\" value.");
    }
    this.currentLocale = this.$translate.proposedLanguage();
    $rootScope.$on('$translateChangeSuccess', function(event, data) {
      document.documentElement.setAttribute('lang', data.language);
      return tmhDynamicLocale.set(data.language.toLowerCase().replace(/_/g, '-'));
    });
    this.setLocale(this.preferredLocale);
  }

  LocaleService.prototype.checkLocaleIsValid = function(locale) {
    return _.has(this.locales, locale);
  };

  LocaleService.prototype.setLocale = function(locale) {
    if (!this.checkLocaleIsValid(locale)) {
      console.error("Locale name \"" + locale + "\" is invalid'");
    }
    this.currentLocale = locale;
    return this.$translate.use(locale);
  };

  LocaleService.prototype.getLocaleDisplayName = function() {
    return this.locales[this.currentLocale];
  };

  LocaleService.prototype.setLocaleByDisplayName = function(localeDisplayName) {
    return this.setLocale(_.findKey(this.locales, _.matches(localeDisplayName)));
  };

  LocaleService.prototype.getLocalesDisplayNames = function() {
    return _.values(this.locales);
  };

  return LocaleService;

})();

angular.module('touk.locale.service', ['pascalprecht.translate', 'tmh.dynamicLocale']).provider('LocaleService', function() {
  var LocaleServiceProvider;
  return new (LocaleServiceProvider = (function() {
    function LocaleServiceProvider() {}

    LocaleServiceProvider.prototype.$get = [
      '$translate', '$rootScope', 'tmhDynamicLocale', function() {
        return (function(func, args, ctor) {
          ctor.prototype = func.prototype;
          var child = new ctor, result = func.apply(child, args);
          return Object(result) === result ? result : child;
        })(LocaleService, slice.call(arguments).concat([this.LOCALES]), function(){});
      }
    ];

    return LocaleServiceProvider;

  })());
});
;'use strict';
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

angular.module('touk.money.directives', ['touk.money.filters']).directive('unitFloat', function() {
  var UnitFloat;
  return {
    restrict: 'A',
    require: ['unitFloat', 'ngModel'],
    bindToController: {
      value: '=ngModel',
      step: '=?',
      allowNegative: '=?',
      precision: '=?',
      translateFn: '&?',
      filter: '@?',
      prefix: '@?',
      suffix: '@?',
      ceiling: '=?max',
      floor: '=?min'
    },
    scope: true,
    controller: UnitFloat = (function() {
      UnitFloat.prototype.step = 1;

      UnitFloat.prototype.allowNegative = true;

      UnitFloat.prototype.keyUp = 38;

      UnitFloat.prototype.keyDown = 40;

      UnitFloat.$inject = ['$element', '$parse'];

      function UnitFloat($element, $parse) {
        this.$element = $element;
        this.$parse = $parse;
        this.render = bind(this.render, this);
        this.round = bind(this.round, this);
        this.fix = bind(this.fix, this);
        this.formatter = bind(this.formatter, this);
        this.parser = bind(this.parser, this);
        this.change = bind(this.change, this);
        this.destructor = bind(this.destructor, this);
        this.unbindEvents = bind(this.unbindEvents, this);
        this.bindEvents = bind(this.bindEvents, this);
      }

      UnitFloat.prototype.bindEvents = function() {
        this.$element.on('keydown', (function(_this) {
          return function(event) {
            switch (event.which) {
              case _this.keyUp:
                _this.change(event.shiftKey ? +10 : +1);
                return event.preventDefault();
              case _this.keyDown:
                _this.change(event.shiftKey ? -10 : -1);
                return event.preventDefault();
            }
          };
        })(this));
        return this.$element.on('blur paste keydown', (function(_this) {
          return function() {
            return _this.render();
          };
        })(this));
      };

      UnitFloat.prototype.unbindEvents = function() {
        return this.$element.off();
      };

      UnitFloat.prototype.destructor = function() {
        return this.unbindEvents();
      };

      UnitFloat.prototype.change = function(amount) {
        var i, j, ref, step, value;
        value = this.model.$modelValue || 0;
        step = 1;
        for (i = j = 0, ref = this.getPositive(this.precision); 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
          step = step / 10;
        }
        step = Math.max(this.step, step);
        value += amount * step;
        value = this.round(value);
        if (!this.allowNegative) {
          value = this.getPositive(value);
        }
        this.model.$setDirty();
        this.model.$setViewValue(this.formatter(value));
        return this.model.$render();
      };

      UnitFloat.prototype.parser = function(value) {
        var quantity;
        if (!value) {
          return null;
        }
        quantity = value.toString().replace(/\./g, ',').replace(/[^-\d,]/g, '').replace(/[,](\d*)$/g, '.$10');
        quantity = parseFloat(quantity);
        if (!this.allowNegative) {
          quantity = this.getPositive(quantity);
        }
        if (isNaN(quantity)) {
          return null;
        }
        return this.round(quantity);
      };

      UnitFloat.prototype.formatter = function(value) {
        var filter, quantity;
        quantity = parseFloat(value);
        if (isNaN(quantity)) {
          return null;
        }
        quantity = this.round(quantity);
        if ((this.translateFn != null) && !this.filter) {
          value = this.translateFn({
            value: quantity
          });
        } else {
          filter = this.filter || ("unitFloat : " + (this.getPositive(this.precision)));
          value = this.applyFilter(quantity, filter);
        }
        return "" + (this.prefix || '') + value + (this.suffix || '');
      };

      UnitFloat.prototype.getPositive = function(value) {
        if (value == null) {
          value = 0;
        }
        return Math.max(value, 0);
      };

      UnitFloat.prototype.fix = function(value) {
        var ceiling, floor, max, min;
        floor = Math.min(this.floor, this.ceiling) || this.floor;
        ceiling = Math.max(this.floor, this.ceiling) || this.ceiling;
        min = Math.min(value, ceiling);
        if (!isNaN(min)) {
          value = min;
        }
        max = Math.max(value, floor);
        if (!isNaN(max)) {
          value = max;
        }
        return value;
      };

      UnitFloat.prototype.round = function(value) {
        return this.applyFilter(this.fix(value), "decimal : " + (this.getPositive(this.precision)));
      };

      UnitFloat.prototype.applyFilter = function(quantity, filter) {
        return this.$parse(quantity + " | " + filter)();
      };

      UnitFloat.prototype.render = function() {
        var ref, ref1;
        this.render = _.debounce((function(_this) {
          return function() {
            var val;
            val = _this.formatter(_this.parser(_this.model.$viewValue));
            if (_this.model.$viewValue === val) {
              return;
            }
            _this.model.$setViewValue(val);
            return _this.model.$render();
          };
        })(this), ((ref = this.model) != null ? (ref1 = ref.$options) != null ? ref1.debounce : void 0 : void 0) || 800);
        return this.render();
      };

      return UnitFloat;

    })(),
    controllerAs: 'UF',
    link: function(scope, element, attrs, ctrls) {
      var UF;
      UF = ctrls[0], UF.model = ctrls[1];
      UF.model.$parsers.unshift(UF.parser);
      UF.model.$formatters.unshift(UF.formatter);
      UF.bindEvents();
      scope.$watch('UF', function() {
        return UF.render();
      }, true);
      return scope.$on('$destroy', function() {
        return UF.destructor();
      });
    }
  };
});
;'use strict';
angular.module('touk.money.filters', []).filter('money', [
  '$filter', function($filter) {
    return function(quantity, precision, unit) {
      if (quantity == null) {
        quantity = 0;
      }
      if (precision == null) {
        precision = 2;
      }
      if (unit == null) {
        unit = ' zł';
      }
      return $filter('unitFloat')(quantity, precision, unit);
    };
  }
]).filter('unitFloat', [
  '$filter', function($filter) {
    return function(quantity, precision, unit) {
      if (quantity == null) {
        quantity = 0;
      }
      if (precision == null) {
        precision = 2;
      }
      if (unit == null) {
        unit = '';
      }
      if (angular.isString(quantity)) {
        return quantity;
      }
      quantity = $filter('decimal')(quantity, precision);
      quantity = quantity.toFixed(precision).toString().replace(/\./, ',');
      quantity = $filter('thousandsSeparate')(quantity);
      return ("" + quantity + unit).trim();
    };
  }
]).filter('decimal', [
  '$filter', function($filter) {
    return function(quantity, precision) {
      var m, s;
      if (quantity == null) {
        quantity = 0;
      }
      if (precision == null) {
        precision = 2;
      }
      m = Math.pow(10, precision);
      s = quantity < 0 ? -1 : 1;
      return s * (Math.round(Math.abs(quantity) * m) / m);
    };
  }
]).filter('thousandsSeparate', function() {
  return function(quantity, separator) {
    var thousandsRegex;
    if (quantity == null) {
      quantity = 0;
    }
    if (separator == null) {
      separator = ' ';
    }
    thousandsRegex = /(\d)(?:(?=\d+(?=[^\d.]))(?=(?:\d{3})+\b)|(?=\d+(?=\.))(?=(?:\d{3})+(?=\.)))/g;
    return (quantity + " ").replace(thousandsRegex, "$1" + separator).trim();
  };
});
;'use strict';
angular.module('touk.nip.directives', ['touk.nip.filters', 'touk.nip.validator']).directive('maskNip', [
  '$filter', function($filter) {
    return {
      restrict: 'A',
      require: 'ngModel',
      link: function(scope, element, attrs, ctrl) {
        var formatter, parser, ref;
        parser = function(value) {
          return value != null ? value.replace(/[^0-9]/g, '') : void 0;
        };
        formatter = function(value) {
          return $filter('maskNip')(value);
        };
        ctrl.$parsers.unshift(parser);
        ctrl.$formatters.push(formatter);
        return element.on('blur paste', _.debounce(function() {
          var val;
          val = formatter(parser(ctrl.$viewValue));
          if (ctrl.$viewValue === val) {
            return;
          }
          ctrl.$viewValue = val;
          return ctrl.$render();
        }, ((ref = ctrl.$options) != null ? ref.debounce : void 0) || 800));
      }
    };
  }
]).directive('validateNip', [
  'nip', function(validator) {
    return {
      restrict: 'A',
      require: 'ngModel',
      link: function(scope, element, attrs, ctrl) {
        return ctrl.$validators.nip = function(modelValue, viewValue) {
          var value;
          value = modelValue || viewValue;
          return ctrl.$isEmpty(value) || validator.validate(value);
        };
      }
    };
  }
]);
;'use strict';
angular.module('touk.nip.filters', []).filter('maskNip', function() {
  return function(value) {
    return value != null ? value.toString().replace(/[^0-9]/g, '').slice(0, 10).replace(/(\d{3}(?=\d\B)|\d{2}(?=\d))/g, '$1-') : void 0;
  };
});
;'use strict';
var Nip,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

angular.module('touk.nip.validator', []).service('nip', Nip = (function() {
  function Nip() {
    this.generate = bind(this.generate, this);
    this.validate = bind(this.validate, this);
    this.clean = bind(this.clean, this);
  }

  Nip.prototype.weights = [6, 5, 7, 2, 3, 4, 5, 6, 7];

  Nip.prototype.sum = function(chars) {
    var i, j, len, ref, sum, weight;
    sum = 0;
    ref = this.weights;
    for (i = j = 0, len = ref.length; j < len; i = ++j) {
      weight = ref[i];
      sum += weight * parseInt(chars[i]);
    }
    return sum % 11;
  };

  Nip.prototype.clean = function(nip) {
    return nip != null ? nip.toString().replace(/[\s-]/g, '') : void 0;
  };

  Nip.prototype.validate = function(nip) {
    var chars;
    nip = this.clean(nip);
    if (nip < 1) {
      return false;
    }
    if (!/^\d{10}$/.test(nip)) {
      return false;
    }
    chars = nip.toString().split('');
    if (parseInt(chars[9]) === this.sum(chars)) {
      return true;
    }
    return false;
  };

  Nip.prototype.generate = function() {
    var chars, i, j, sum;
    chars = [];
    for (i = j = 0; j <= 8; i = ++j) {
      chars[i] = Math.round(Math.random() * 9);
    }
    sum = this.sum(chars);
    if (sum === 10) {
      return this.generate();
    } else {
      chars[9] = sum;
      return chars.join('');
    }
  };

  return Nip;

})());
;'use strict';
angular.module('touk.nrb.directives', ['touk.nrb.filters', 'touk.nrb.validators']).directive('maskNrb', [
  '$filter', function($filter) {
    return {
      restrict: 'A',
      require: 'ngModel',
      link: function(scope, element, attrs, ctrl) {
        var formatter, parser, ref;
        parser = function(value) {
          return value != null ? value.replace(/[^0-9]/g, '') : void 0;
        };
        formatter = function(value) {
          return $filter('maskNrb')(value);
        };
        ctrl.$parsers.unshift(parser);
        ctrl.$formatters.push(formatter);
        return element.on('blur paste', _.debounce(function() {
          var val;
          val = formatter(parser(ctrl.$viewValue));
          if (ctrl.$viewValue === val) {
            return;
          }
          ctrl.$viewValue = val;
          return ctrl.$render();
        }, ((ref = ctrl.$options) != null ? ref.debounce : void 0) || 2000));
      }
    };
  }
]).directive('validateNrb', [
  'nrb', function(validator) {
    return {
      restrict: 'A',
      require: 'ngModel',
      link: function(scope, element, attrs, ctrl) {
        return ctrl.$validators.nrb = function(modelValue, viewValue) {
          var value;
          value = modelValue || viewValue;
          return ctrl.$isEmpty(value) || validator.validate(value);
        };
      }
    };
  }
]);
;'use strict';
angular.module('touk.nrb.filters', []).filter('maskNrb', function() {
  return function(value) {
    return value != null ? value.toString().replace(/[^0-9]/g, '').slice(0, 26).replace(/(^\d{2}(?=\d\B)|\d{4}(?=\d))/g, '$1 ') : void 0;
  };
});
;'use strict';
var Nrb,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

angular.module('touk.nrb.validators', []).service('nrb', Nrb = (function() {
  function Nrb() {
    this.generate = bind(this.generate, this);
    this.validate = bind(this.validate, this);
    this.clean = bind(this.clean, this);
  }

  Nrb.prototype.weights = [1, 10, 3, 30, 9, 90, 27, 76, 81, 34, 49, 5, 50, 15, 53, 45, 62, 38, 89, 17, 73, 51, 25, 56, 75, 71, 31, 19, 93, 57];

  Nrb.prototype.sum = function(chars) {
    var i, j, len, ref, sum, weight;
    sum = 0;
    ref = this.weights;
    for (i = j = 0, len = ref.length; j < len; i = ++j) {
      weight = ref[i];
      sum += weight * parseInt(chars[i]);
    }
    return sum % 97;
  };

  Nrb.prototype.clean = function(nrb) {
    return nrb != null ? nrb.toString().replace(/[^0-9]/g, '') : void 0;
  };

  Nrb.prototype.validate = function(nrb) {
    var chars;
    nrb = this.clean(nrb);
    if (!/^\d{26}$/.test(nrb)) {
      return false;
    }
    nrb = nrb.substring(2) + '2521' + nrb.substring(0, 2);
    chars = nrb.split('').reverse();
    if (this.sum(chars) === 1) {
      return true;
    }
    return false;
  };

  Nrb.prototype.generate = function() {
    var chars, i, j, nrb;
    chars = [];
    for (i = j = 0; j <= 25; i = ++j) {
      chars[i] = Math.round(Math.random() * 9);
    }
    nrb = chars.join('');
    if (!this.validate(nrb)) {
      return this.generate();
    } else {
      return nrb;
    }
  };

  return Nrb;

})());
;'use strict';
angular.module('touk.pesel.directives', ['touk.pesel.validators']).directive('validatePesel', [
  'pesel', function(validator) {
    return {
      restrict: 'A',
      require: 'ngModel',
      link: function(scope, element, attrs, ctrl) {
        return ctrl.$validators.pesel = function(modelValue, viewValue) {
          var value;
          value = modelValue || viewValue;
          return ctrl.$isEmpty(value) || validator.validate(value);
        };
      }
    };
  }
]);
;'use strict';
var Pesel,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

angular.module('touk.pesel.validators', []).service('pesel', Pesel = (function() {
  function Pesel() {
    this.date = bind(this.date, this);
    this.generate = bind(this.generate, this);
    this.validate = bind(this.validate, this);
  }

  Pesel.prototype.weights = [1, 3, 7, 9, 1, 3, 7, 9, 1, 3];

  Pesel.prototype.sum = function(chars) {
    var i, j, len, ref, sum, weight;
    sum = 0;
    ref = this.weights;
    for (i = j = 0, len = ref.length; j < len; i = ++j) {
      weight = ref[i];
      sum += weight * parseInt(chars[i]);
    }
    sum = sum % 10;
    if (sum !== 0) {
      sum = 10 - sum;
    }
    return sum;
  };

  Pesel.prototype.validate = function(pesel) {
    var chars;
    if (!/^\d{11}$/.test(pesel)) {
      return false;
    }
    if (!this.date(pesel)) {
      return false;
    }
    chars = pesel.toString().split('');
    if (parseInt(chars[10]) === this.sum(chars)) {
      return true;
    }
    return false;
  };

  Pesel.prototype.generate = function() {
    var chars, i, j, pesel;
    chars = [];
    for (i = j = 0; j <= 9; i = ++j) {
      chars[i] = Math.round(Math.random() * 9);
    }
    chars[2] = Math.round(Math.random() * 1);
    chars[10] = this.sum(chars);
    pesel = chars.join('');
    if (this.date(pesel)) {
      return pesel;
    } else {
      return this.generate();
    }
  };

  Pesel.prototype.date = function(pesel) {
    var cent, chars, dd, mm, yyyy;
    chars = pesel.toString().split('');
    cent = 18 + ((Math.floor(chars[2] / 2)) + 1) % 5;
    yyyy = parseInt(cent + chars[0] + chars[1]);
    mm = parseInt(chars[2] % 2 + chars[3]);
    dd = parseInt(chars[4] + chars[5]);
    if (((0 < mm && mm < 13)) && ((0 < dd && dd < 32))) {
      return new Date(yyyy, mm - 1, dd);
    } else {
      return null;
    }
  };

  return Pesel;

})());
;'use strict';
var slice = [].slice;

angular.module('touk.plurals.filters', ['smart']).run([
  'SmartPlurals', function(SmartPlurals) {
    SmartPlurals.defineRule("pl_custom", function(value, choices) {
      var mod10, mod100, ref;
      if (value === 1) {
        return 0;
      }
      if ((0 < (ref = value % 1) && ref < 1)) {
        return 3;
      }
      mod10 = value % 10;
      mod100 = value % 100;
      if (((2 <= mod10 && mod10 <= 4)) && !((12 <= mod100 && mod100 <= 14))) {
        return 1;
      }
      if (!((2 <= mod10 && mod10 <= 4)) || ((12 <= mod100 && mod100 <= 14))) {
        return 2;
      }
      return 3;
    });
    return SmartPlurals.setDefaultRule('pl_custom');
  }
]).filter('miesiace', [
  '$filter', function($filter) {
    return function(value, withoutValue) {
      var m, plurals;
      plurals = ['miesiąc', 'miesiące', 'miesięcy', 'miesiąca'];
      m = $filter('plural').apply(null, [value].concat(slice.call(plurals)));
      if (withoutValue) {
        return m;
      } else {
        return value + " " + m;
      }
    };
  }
]).filter('lata', [
  '$filter', function($filter) {
    return function(value, withoutValue) {
      var m, plurals;
      plurals = ['rok', 'lata', 'lat', 'roku'];
      m = $filter('plural').apply(null, [value].concat(slice.call(plurals)));
      if (withoutValue) {
        return m;
      } else {
        return value + " " + m;
      }
    };
  }
]);
;'use strict';
var PromisedFn,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

PromisedFn = (function() {
  function PromisedFn($element) {
    this.$element = $element;
    this.simulateDefault = bind(this.simulateDefault, this);
    this.shouldPreventDefault = bind(this.shouldPreventDefault, this);
    this.handleClick = bind(this.handleClick, this);
  }

  PromisedFn.prototype.handleClick = function(event) {
    if ((event.originalEvent || event).preventedDefault) {
      return;
    }
    if (this.shouldPreventDefault(event)) {
      return event.preventDefault();
    }
  };

  PromisedFn.prototype.shouldPreventDefault = function(options) {
    var promise, returnedValue;
    returnedValue = this.func();
    if (typeof returnedValue === 'function') {
      returnedValue = returnedValue();
    }
    if (returnedValue === true) {
      return false;
    }
    promise = (returnedValue != null ? returnedValue.$promise : void 0) || returnedValue;
    promise = promise != null ? typeof promise.then === "function" ? promise.then((function(_this) {
      return function() {
        return _this.simulateDefault(options);
      };
    })(this)) : void 0 : void 0;
    if (promise || !returnedValue) {
      return true;
    }
  };

  PromisedFn.prototype.simulateDefault = function(options) {
    var event;
    event = document.createEvent("MouseEvents");
    event.initMouseEvent("click", true, true, window, 0, 0, 0, 0, 0, options.ctrlKey, options.altKey, options.shiftKey, options.metaKey, options.button, null);
    event.preventedDefault = true;
    return this.$element[0].dispatchEvent(event);
  };

  return PromisedFn;

})();

angular.module('touk.promisedLink', []).controller('PromisedFnCtrl', ['$element', PromisedFn]).directive('promisedFn', function() {
  return {
    restrict: 'A',
    controller: 'PromisedFnCtrl as ctrl',
    bindToController: {
      func: '&promisedFn'
    },
    link: function(scope, element) {
      return element.on('click', scope.ctrl.handleClick);
    }
  };
});
;'use strict';
angular.module('touk.showErrors', []).directive('showErrors', function() {
  return {
    scope: true,
    link: function(scope, elm, attrs) {
      var addWatch, getControllers;
      scope.validators = [];
      getControllers = function() {
        var input, j, len, modelEls, results;
        modelEls = elm[0].querySelectorAll('[ng-model]');
        results = [];
        for (j = 0, len = modelEls.length; j < len; j++) {
          input = modelEls[j];
          results.push(angular.element(input).controller('ngModel'));
        }
        return results;
      };
      scope.$watchCollection(getControllers, function(controllers) {
        var ctrl, i, j, len, results;
        results = [];
        for (i = j = 0, len = controllers.length; j < len; i = ++j) {
          ctrl = controllers[i];
          results.push(addWatch(ctrl, i));
        }
        return results;
      });
      addWatch = function($controller, i) {
        return $controller != null ? $controller.$$hasErrorsWatch != null ? $controller.$$hasErrorsWatch : $controller.$$hasErrorsWatch = scope.$watch(function() {
          return $controller.$touched && $controller.$invalid;
        }, function(isInvalid) {
          return scope.validators[i] = isInvalid;
        }) : void 0;
      };
      return scope.$watchCollection('validators', function(vals) {
        scope.$hasErrors = _.any(vals);
        if (scope.$hasErrors) {
          elm.addClass('has-error');
          return;
        }
        return elm.removeClass('has-error');
      });
    }
  };
});
;'use strict';
angular.module('touk.text.directives', ['touk.text.validators']).directive('validateText', [
  'TextValidator', function(Validator) {
    return {
      restrict: 'A',
      require: 'ngModel',
      link: function(scope, element, attrs, ctrl) {
        return ctrl.$validators.text = function(modelValue, viewValue) {
          var value;
          value = modelValue || viewValue;
          return ctrl.$isEmpty(value) || new Validator().validate(value);
        };
      }
    };
  }
]);
;'use strict';
var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

angular.module('touk.text.validators', []).factory('DefaultValidator', function() {
  var DefaultValidator;
  return DefaultValidator = (function() {
    function DefaultValidator() {
      this.clean = bind(this.clean, this);
      this.validate = bind(this.validate, this);
      this.polish = "ąćęłńóśźż";
      this.german = "äéöüß";
      this.czech = "áčďéěíňóřšťúžýů";
      this.french = "'àâæçèéêëîïôùûü";
      this.digits = "0-9";
      this.special = " \\[\\]@%&\*#()=_+\\-/\\\\:;<>,.?!„”‘'`\"";
      this.letters = "a-z" + this.polish + this.german + this.czech + this.french;
      this.regex = "[^" + this.letters + this.digits + this.special + "]";
    }

    DefaultValidator.prototype.validate = function(text) {
      var re;
      re = new RegExp(this.regex, 'i');
      if (re.test(text)) {
        return false;
      }
      return true;
    };

    DefaultValidator.prototype.clean = function(text) {
      var re;
      re = new RegExp(this.regex, 'ig');
      return text = text != null ? text.replace(re, '') : void 0;
    };

    return DefaultValidator;

  })();
}).factory('TextValidator', [
  'DefaultValidator', function(DefaultValidator) {
    var TextValidator;
    return TextValidator = (function(superClass) {
      extend(TextValidator, superClass);

      function TextValidator() {
        TextValidator.__super__.constructor.call(this);
        this.regex = "[^" + this.letters + this.special + "]";
      }

      return TextValidator;

    })(DefaultValidator);
  }
]);
;'use strict';
angular.module('touk.zipcode.directives', ['touk.zipcode.filters']).directive('maskZipcode', [
  '$filter', function($filter) {
    return {
      restrict: 'A',
      require: 'ngModel',
      link: function(scope, element, attrs, ctrl) {
        var formatter, ref;
        formatter = function(value) {
          return $filter('maskZipcode')(value);
        };
        ctrl.$parsers.unshift(formatter);
        ctrl.$formatters.push(formatter);
        return element.on('blur paste', _.debounce(function() {
          var val;
          val = formatter(ctrl.$viewValue);
          if (ctrl.$viewValue === val) {
            return;
          }
          ctrl.$setViewValue(val);
          return ctrl.$render();
        }, ((ref = ctrl.$options) != null ? ref.debounce : void 0) || 100));
      }
    };
  }
]);
;'use strict';
angular.module('touk.zipcode.filters', []).filter('maskZipcode', function() {
  return function(value) {
    return value != null ? value.toString().replace(/[^0-9]/g, '').slice(0, 5).replace(/(\d{2})/, '$1-') : void 0;
  };
});
;
//# sourceMappingURL=app.js.map