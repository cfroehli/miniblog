import $ from 'jquery';

// webpacker wraps imported code into his own function
// to allow a lazy loading but jQuery set the $ alias
// automatically only when it detects it's own location
// at global level and thus fail to do so inside the webpacker
// wrap function
// => restore the missing alias manually

//

window.$ = window.jQuery = $;
