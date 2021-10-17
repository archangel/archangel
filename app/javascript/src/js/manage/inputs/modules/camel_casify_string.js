//
// Camel case string
//
// Change text to a camel case string
//
// Example
//   camelCasifyString('HeLLo') // => 'hello'
//   camelCasifyString(' H e l l o ') // => 'hELLO'
//   camelCasifyString('David & Goliath') // => 'davidGoliath'
//   camelCasifyString('hello----world') // => 'helloWorld'
//   camelCasifyString('hello-!@#$%^&*()_+{}:"<>?`-=[]\;,./-world') // => 'helloWorld'
//
export function camelCasifyString (value) {
  return value
    .toString()
    .trim() // Trim
    .toLowerCase() // Lower case
    .replace(/[-_]+/g, ' ') // Replace dash and underscore with a space
    .replace(/[^\w\s]/g, ' ') // Replace any non alphanumeric characters with space
    .replace(/ (.)/g, ($1) => {
      return $1.toUpperCase()
    }) // Uppercase the first character in each group immediately following a space
    .replace(/\s+/g, '') // Remove remaining spaces
}
