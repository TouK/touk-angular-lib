## id
##### modules:  `touk.dowod.directives`, `touk.dowod.validators`
####`validateDowod` directive
appends polish Id validator to ng-model
`dowod` service
- `validate(id: string): boolean` - validate
- `generate(): string` - generate random valid string


## e-mail
##### modules:  `touk.email.directives`, `touk.email.validators`
####`validateEmail` directive
appends RFC e-mail validator to ng-model
####`EmailValidator` service
- `validate(id: string): boolean` - validate


## money
##### modules:  `touk.money.directives`, `touk.money.filters`
####`unitFloat` directive
- accepts:
	- `step: '=?'` - step for keyboard, default `1`
	- `allowNegative: '=?'` - default `true`
	- `precision: '=?'`
	- `max: '=?'`
	- `min: '=?'`
	- `filter: '@?'` - angular filter to modify format
	- `translateFn: '&?'` - external function to modify format (when no filter)
	- `prefix: '@?'`
	- `suffix: '@?'`
- formats value
- cleans input
- rounds value
- handles keyboard events (`up`, `down`, `shift+up,` `shift+down`)
####`thousandsSeparate` filter
`1 123 123`, `12 123`, `123`, etc.
#### `decimal` filter
round to precision (default `2`)
#### `unitFloat` filter
apply decimal and thousandsSeparate, append unit (defaults precision: `2`, unit: `none`)
#### `money` filter
apply unitFloat with default unit ` zł`


## nip
##### modules:  `touk.nip.directives`, `touk.nip.filters`, `touk.nip.validator`
####`maskNip` filter
clean and format NIP to common format
####`maskNip` directive
apply `maskNip` filter
####`validateNip` directive
appends NIP validator to ng-model
####`nip` service
- `clean(nip: string): string` - return digits only
- `validate(nip: string): boolean` - validate
- `generate(): string` - generate random valid string


## bank account number
##### modules:  `touk.nrb.directives`, `touk.nrb.validators`, `touk.nrb.filters`
#### `maskNrb` directive
readable bank account number
#### `validateNrb` directive
appends bank account number validator to ng-model
####`maskNrb` filter
readable bank account number
####`nrb` service
- `clean(nrb: string): string` - return digits only
- `validate(nrb: string): boolean` - validate
- `generate(): string` - generate random valid string


## pesel
##### modules:  `touk.pesel.directives`, `touk.pesel.validators`
####`validatePesel` directive
appends PESEL validator to ng-model
####`pesel` service
- `validate(pesel: string): boolean` - validate
- `generate(): string` - generate random valid string
- `date(pesel: string): Date` - get birdth date from PESEL


## zip
##### modules:  `touk.zip.directives`, `touk.zip.filters`
#### `maskZipcode` filter & directive
cleans polish zip code to `xx-xxx` format


## plurals
##### modules:  `touk.plurals.filters`
configure and use SmartPlurals
#### `miesiace` filter
`1 miesiąc`, `2 miesiące`, `5 miesięcy`, `0.5 miesiąca`
#### `lata` filter
`1 rok`, `2 lata`, `5 lat`, `2.5 roku`


## text
##### modules:  `touk.text.directives`, `touk.text.validators`
#### `DefaultValidator` service 
only some acceptable chars (polish, german, czech, french, digits and some specials)
- `validate(text: string): boolean` - validate
- `clean(text: string): string` - clean other chars
	- `TextValidator` - `DefaultValidator` without digits
####`validateText` directive
appends `TextValidator` validator to ng-model



## locale
##### modules:  `touk.locale.directive`, `touk.locale.service`
configuration and use of `pascalprecht.translate`, `tmh.dynamicLocale`, see code
#### `languageChangeSelect` directive


## image preloader
##### modules:  `touk.imagePreloader`
#### `ImagePreloader` service - see code


## other


##### modules:  `touk.showErrors`
`showErrors` directive
- monitors `ng-model` validators on children
- appends `$hasErrors` to scope
- appends `has-error` class to element


##### modules:  `touk.promisedLink`
`promisedFn` directive
- blocks click events on element until promise resolved or returned value
- accepts `&promisedFn` returning promise or value
- see at e2e test


##### modules:  `touk.applyFilter`
- appends simple `applyFilter` helper to `$scope` prototype
- `applyFilter(filter: string, value: string): string`
- (avoid injecting `$parse` or `$filter`)

