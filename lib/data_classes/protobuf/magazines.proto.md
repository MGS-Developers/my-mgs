# Magazine data structure

**How to construct a magazine, and a (brief) implementation guide for rendering.**

## Building a magazine

This section of the guide will discuss how to approach converting a magazine issue document from text into the `magazine.proto` format. It is assumed that you already have specified the magazine itself, as well as issue metadata -- this `proto` is only intended for specifying the actual issue contents (e.g. imagine it as an alternative to a `.pdf` file).

### Key concepts

If you are unfamiliar with the world magazine editing, there are a few key concepts which one needs to understand how this format is designed/operated semantically. In order to be as simple to use as possible, it is structured similarly to how a magazine layout may be structured in publishing software; therefore, much of the terminology is derived from there.

 - **Master** - a 'master' is a template for a page, which can be re-used and centrally edited to update in multiple places. Imagine it like a Flutter or React component, in that it renders elements based on the props it is given, and can be called multiple times. Just as a component can take children, a master can take `params`, which specify strings/images to insert in key places within the template.
 - **Global** - put simply, a 'global' is a little like a variable. They are defined in one place in the file/JSON tree, and can be imported in any reference. In this format, they currently behave similarly to `@mixin`s in `s[ac]ss`, in that they hold styling information which can be applied to anything which references it (but, if overridden by a formatting specifier lower in the tree, that is used instead - like `<style>` overriding classes), and that they can also make use of arguments passed to them.
 - **Section** - a section is a chapter of an issue, e.g. 'Reader submissions'. Although not every magazine may have sections, they are necessary to use for simplicity of formatting (since it is far simpler to _get around_ using them if you don't want to, than it is to manually implement them if they weren't built into the specification). An easy way to get around sections (if they are not needed for a given issue) is to specify a single section, without any color/other metadata, and setting the `title` of the section to match the title of the issue.
 - **Pages** - although this is fairly straightforward, it is important to keep in mind that in such a mobile environment, a 'page' refers to an entire article - individual articles are not to be paginated into `100vh` screens, but rendered as-is. The necessity for 'pages', as opposed to 'articles', is that some pages might _not_ be articles, but rather large images, infographics, crosswords/puzzles, etc..

### Implementing properties

#### Globals

Globals are specified at the top level of the `proto` tree, within the `repeated` property `globals`. Each of these corresponds to a global definition object, which looks like this:

```json
{
  "key": "global_name",
  
  // Refers to enum value - Text=0, Image=1.
  "acceptedType": 0,
  
  
}
```