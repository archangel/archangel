//
// Slugify string
//
// Change text to a slug string
//
// Example
//   slugifyString('HeLLo') // => 'hello'
//   slugifyString(' H E L L O ') // => 'hello'
//   slugifyString('David & Goliath') // => 'david-and-goliath'
//   slugifyString('hello----world') // => 'hello-world'
//   slugifyString('hello-!@#$%^&*()_+{}:"<>?`-=[]\;,./-world') // => 'hello-world'
//
export function slugifyString (value) {
  return value
    .toString()
    .trim() // Trim
    .toLowerCase() // Lower case
    .replace(/\s+/g, '-') // Spaces to dashes
    .replace(/&/g, '-and-') // Replace & with '-and-'
    .replace(/[^\w-]+/g, '-') // Non-alphanumeric characters to a dash
    .replace(/--+/g, '-') // Remove multiple dashes
    .replace(/^-+/, '') // Remove beginning dashes
    .replace(/-+$/, '') // Remove trailing dashes
}
