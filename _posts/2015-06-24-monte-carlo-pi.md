---
layout: post
title: "Using Monte Carlo methods to estimate pi"
comments: true
date: "Wednesday, June 24, 2015"
featured_image: /images/hdf.gif
---

<head>
<meta charset="utf-8" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/require.js/2.1.10/require.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<style type="text/css">

/*

Original style from softwaremaniacs.org (c) Ivan Sagalaev <Maniac@SoftwareManiacs.Org>
Adapted from GitHub theme

*/
.highlight-base {
  color: #000000;
}
.highlight-variable {
  color: #000000;
}
.highlight-variable-2 {
  color: #1a1a1a;
}
.highlight-variable-3 {
  color: #333333;
}
.highlight-string {
  color: #BA2121;
}
.highlight-comment {
  color: #408080;
  font-style: italic;
}
.highlight-number {
  color: #080;
}
.highlight-atom {
  color: #88F;
}
.highlight-keyword {
  color: #008000;
  font-weight: bold;
}
.highlight-builtin {
  color: #008000;
}
.highlight-error {
  color: #f00;
}
.highlight-operator {
  color: #AA22FF;
  font-weight: bold;
}
.highlight-meta {
  color: #AA22FF;
}
/* previously not defined, copying from default codemirror */
.highlight-def {
  color: #00f;
}
.highlight-string-2 {
  color: #f50;
}
.highlight-qualifier {
  color: #555;
}
.highlight-bracket {
  color: #997;
}
.highlight-tag {
  color: #170;
}
.highlight-attribute {
  color: #00c;
}
.highlight-header {
  color: blue;
}
.highlight-quote {
  color: #090;
}
.highlight-link {
  color: #00c;
}
/* apply the same style to codemirror */
.cm-s-ipython span.cm-keyword {
  color: #008000;
  font-weight: bold;
}
.cm-s-ipython span.cm-atom {
  color: #88F;
}
.cm-s-ipython span.cm-number {
  color: #080;
}
.cm-s-ipython span.cm-def {
  color: #00f;
}
.cm-s-ipython span.cm-variable {
  color: #000000;
}
.cm-s-ipython span.cm-operator {
  color: #AA22FF;
  font-weight: bold;
}
.cm-s-ipython span.cm-variable-2 {
  color: #1a1a1a;
}
.cm-s-ipython span.cm-variable-3 {
  color: #333333;
}
.cm-s-ipython span.cm-comment {
  color: #408080;
  font-style: italic;
}
.cm-s-ipython span.cm-string {
  color: #BA2121;
}
.cm-s-ipython span.cm-string-2 {
  color: #f50;
}
.cm-s-ipython span.cm-meta {
  color: #AA22FF;
}
.cm-s-ipython span.cm-qualifier {
  color: #555;
}
.cm-s-ipython span.cm-builtin {
  color: #008000;
}
.cm-s-ipython span.cm-bracket {
  color: #997;
}
.cm-s-ipython span.cm-tag {
  color: #170;
}
.cm-s-ipython span.cm-attribute {
  color: #00c;
}
.cm-s-ipython span.cm-header {
  color: blue;
}
.cm-s-ipython span.cm-quote {
  color: #090;
}
.cm-s-ipython span.cm-link {
  color: #00c;
}
.cm-s-ipython span.cm-error {
  color: #f00;
}
.cm-s-ipython span.cm-tab {
  background: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAMCAYAAAAkuj5RAAAAAXNSR0IArs4c6QAAAGFJREFUSMft1LsRQFAQheHPowAKoACx3IgEKtaEHujDjORSgWTH/ZOdnZOcM/sgk/kFFWY0qV8foQwS4MKBCS3qR6ixBJvElOobYAtivseIE120FaowJPN75GMu8j/LfMwNjh4HUpwg4LUAAAAASUVORK5CYII=);
  background-position: right;
  background-repeat: no-repeat;
}
div.output_wrapper {
  /* this position must be relative to enable descendents to be absolute within it */
  position: relative;
  /* Old browsers */
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-box-align: stretch;
  display: -moz-box;
  -moz-box-orient: vertical;
  -moz-box-align: stretch;
  display: box;
  box-orient: vertical;
  box-align: stretch;
  /* Modern browsers */
  display: flex;
  flex-direction: column;
  align-items: stretch;
  z-index: 1;
}
/* class for the output area when it should be height-limited */
div.output_scroll {
  /* ideally, this would be max-height, but FF barfs all over that */
  height: 24em;
  /* FF needs this *and the wrapper* to specify full width, or it will shrinkwrap */
  width: 100%;
  overflow: auto;
  border-radius: 2px;
  -webkit-box-shadow: inset 0 2px 8px rgba(0, 0, 0, 0.8);
  box-shadow: inset 0 2px 8px rgba(0, 0, 0, 0.8);
  display: block;
}
/* output div while it is collapsed */
div.output_collapsed {
  margin: 0px;
  padding: 0px;
  /* Old browsers */
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-box-align: stretch;
  display: -moz-box;
  -moz-box-orient: vertical;
  -moz-box-align: stretch;
  display: box;
  box-orient: vertical;
  box-align: stretch;
  /* Modern browsers */
  display: flex;
  flex-direction: column;
  align-items: stretch;
}
div.out_prompt_overlay {
  height: 100%;
  padding: 0px 0.4em;
  position: absolute;
  border-radius: 2px;
}
div.out_prompt_overlay:hover {
  /* use inner shadow to get border that is computed the same on WebKit/FF */
  -webkit-box-shadow: inset 0 0 1px #000000;
  box-shadow: inset 0 0 1px #000000;
  background: rgba(240, 240, 240, 0.5);
}
div.output_prompt {
  color: darkred;
}
/* This class is the outer container of all output sections. */
div.output_area {
  padding: 0px;
  page-break-inside: avoid;
  /* Old browsers */
  display: -webkit-box;
  -webkit-box-orient: horizontal;
  -webkit-box-align: stretch;
  display: -moz-box;
  -moz-box-orient: horizontal;
  -moz-box-align: stretch;
  display: box;
  box-orient: horizontal;
  box-align: stretch;
  /* Modern browsers */
  display: flex;
  flex-direction: row;
  align-items: stretch;
}
div.output_area .MathJax_Display {
  text-align: left !important;
}
div.output_area .rendered_html table {
  margin-left: 0;
  margin-right: 0;
}
div.output_area .rendered_html img {
  margin-left: 0;
  margin-right: 0;
}
div.output_area img,
div.output_area svg {
  max-width: 100%;
  height: auto;
}
div.output_area img.unconfined,
div.output_area svg.unconfined {
  max-width: none;
}
/* This is needed to protect the pre formating from global settings such
   as that of bootstrap */
.output {
  /* Old browsers */
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-box-align: stretch;
  display: -moz-box;
  -moz-box-orient: vertical;
  -moz-box-align: stretch;
  display: box;
  box-orient: vertical;
  box-align: stretch;
  /* Modern browsers */
  display: flex;
  flex-direction: column;
  align-items: stretch;
}
@media (max-width: 540px) {
  div.output_area {
    /* Old browsers */
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-box-align: stretch;
    display: -moz-box;
    -moz-box-orient: vertical;
    -moz-box-align: stretch;
    display: box;
    box-orient: vertical;
    box-align: stretch;
    /* Modern browsers */
    display: flex;
    flex-direction: column;
    align-items: stretch;
  }
}
div.output_area pre {
  margin: 0;
  padding: 0;
  border: 0;
  vertical-align: baseline;
  color: black;
  background-color: transparent;
  border-radius: 0;
}
/* This class is for the output subarea inside the output_area and after
   the prompt div. */
div.output_subarea {
  overflow-x: auto;
  padding: 0.4em;
  /* Old browsers */
  -webkit-box-flex: 1;
  -moz-box-flex: 1;
  box-flex: 1;
  /* Modern browsers */
  flex: 1;
  max-width: calc(100% - 14ex);
}
/* The rest of the output_* classes are for special styling of the different
   output types */
/* all text output has this class: */
div.output_text {
  text-align: left;
  color: #000000;
  /* This has to match that of the the CodeMirror class line-height below */
  line-height: 1.21429em;
}
/* stdout/stderr are 'text' as well as 'stream', but execute_result/error are *not* streams */
div.output_stderr {
  background: #fdd;
  /* very light red background for stderr */
}
div.output_latex {
  text-align: left;
}
/* Empty output_javascript divs should have no height */
div.output_javascript:empty {
  padding: 0;
}
.js-error {
  color: darkred;
}
/* raw_input styles */
div.raw_input_container {
  font-family: monospace;
  padding-top: 5px;
}
span.raw_input_prompt {
  /* nothing needed here */
}
input.raw_input {
  font-family: inherit;
  font-size: inherit;
  color: inherit;
  width: auto;
  /* make sure input baseline aligns with prompt */
  vertical-align: baseline;
  /* padding + margin = 0.5em between prompt and cursor */
  padding: 0em 0.25em;
  margin: 0em 0.25em;
}
input.raw_input:focus {
  box-shadow: none;
}
p.p-space {
  margin-bottom: 10px;
}
div.output_unrecognized {
  padding: 5px;
  font-weight: bold;
  color: red;
}
div.output_unrecognized a {
  color: inherit;
  text-decoration: none;
}
div.output_unrecognized a:hover {
  color: inherit;
  text-decoration: none;
}
.rendered_html {
  color: #000000;
  /* any extras will just be numbers: */
}
.rendered_html em {
  font-style: italic;
}
.rendered_html strong {
  font-weight: bold;
}
.rendered_html u {
  text-decoration: underline;
}
.rendered_html :link {
  text-decoration: underline;
}
.rendered_html :visited {
  text-decoration: underline;
}
.rendered_html h1 {
  font-size: 185.7%;
  margin: 1.08em 0 0 0;
  font-weight: bold;
  line-height: 1.0;
}
.rendered_html h2 {
  font-size: 157.1%;
  margin: 1.27em 0 0 0;
  font-weight: bold;
  line-height: 1.0;
}
.rendered_html h3 {
  font-size: 128.6%;
  margin: 1.55em 0 0 0;
  font-weight: bold;
  line-height: 1.0;
}
.rendered_html h4 {
  font-size: 100%;
  margin: 2em 0 0 0;
  font-weight: bold;
  line-height: 1.0;
}
.rendered_html h5 {
  font-size: 100%;
  margin: 2em 0 0 0;
  font-weight: bold;
  line-height: 1.0;
  font-style: italic;
}
.rendered_html h6 {
  font-size: 100%;
  margin: 2em 0 0 0;
  font-weight: bold;
  line-height: 1.0;
  font-style: italic;
}
.rendered_html h1:first-child {
  margin-top: 0.538em;
}
.rendered_html h2:first-child {
  margin-top: 0.636em;
}
.rendered_html h3:first-child {
  margin-top: 0.777em;
}
.rendered_html h4:first-child {
  margin-top: 1em;
}
.rendered_html h5:first-child {
  margin-top: 1em;
}
.rendered_html h6:first-child {
  margin-top: 1em;
}
.rendered_html ul {
  list-style: disc;
  margin: 0em 2em;
  padding-left: 0px;
}
.rendered_html ul ul {
  list-style: square;
  margin: 0em 2em;
}
.rendered_html ul ul ul {
  list-style: circle;
  margin: 0em 2em;
}
.rendered_html ol {
  list-style: decimal;
  margin: 0em 2em;
  padding-left: 0px;
}
.rendered_html ol ol {
  list-style: upper-alpha;
  margin: 0em 2em;
}
.rendered_html ol ol ol {
  list-style: lower-alpha;
  margin: 0em 2em;
}
.rendered_html ol ol ol ol {
  list-style: lower-roman;
  margin: 0em 2em;
}
.rendered_html ol ol ol ol ol {
  list-style: decimal;
  margin: 0em 2em;
}
.rendered_html * + ul {
  margin-top: 1em;
}
.rendered_html * + ol {
  margin-top: 1em;
}
.rendered_html hr {
  color: black;
  background-color: black;
}
.rendered_html pre {
  margin: 1em 2em;
}
.rendered_html pre,
.rendered_html code {
  border: 0;
  background-color: #ffffff;
  color: #000000;
  font-size: 100%;
  padding: 0px;
}
.rendered_html blockquote {
  margin: 1em 2em;
}
.rendered_html table {
  margin-left: auto;
  margin-right: auto;
  border: 1px solid black;
  border-collapse: collapse;
}
.rendered_html tr,
.rendered_html th,
.rendered_html td {
  border: 1px solid black;
  border-collapse: collapse;
  margin: 1em 2em;
}
.rendered_html td,
.rendered_html th {
  text-align: left;
  vertical-align: middle;
  padding: 4px;
}
.rendered_html th {
  font-weight: bold;
}
.rendered_html * + table {
  margin-top: 1em;
}
.rendered_html p {
  text-align: left;
}
.rendered_html * + p {
  margin-top: 1em;
}
.rendered_html img {
  display: block;
  margin-left: auto;
  margin-right: auto;
}
.rendered_html * + img {
  margin-top: 1em;
}
.rendered_html img,
.rendered_html svg {
  max-width: 100%;
  height: auto;
}
.rendered_html img.unconfined,
.rendered_html svg.unconfined {
  max-width: none;
}
div.text_cell {
  /* Old browsers */
  display: -webkit-box;
  -webkit-box-orient: horizontal;
  -webkit-box-align: stretch;
  display: -moz-box;
  -moz-box-orient: horizontal;
  -moz-box-align: stretch;
  display: box;
  box-orient: horizontal;
  box-align: stretch;
  /* Modern browsers */
  display: flex;
  flex-direction: row;
  align-items: stretch;
}
@media (max-width: 540px) {
  div.text_cell > div.prompt {
    display: none;
  }
}
div.text_cell_render {
  /*font-family: "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif;*/
  outline: none;
  resize: none;
  width: inherit;
  border-style: none;
  padding: 0.5em 0.5em 0.5em 0.4em;
  color: #000000;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
}
a.anchor-link:link {
  text-decoration: none;
  padding: 0px 20px;
  visibility: hidden;
}
h1:hover .anchor-link,
h2:hover .anchor-link,
h3:hover .anchor-link,
h4:hover .anchor-link,
h5:hover .anchor-link,
h6:hover .anchor-link {
  visibility: visible;
}
.text_cell.rendered .input_area {
  display: none;
}
.text_cell.rendered .rendered_html {
  overflow-x: auto;
}
.text_cell.unrendered .text_cell_render {
  display: none;
}
.cm-header-1,
.cm-header-2,
.cm-header-3,
.cm-header-4,
.cm-header-5,
.cm-header-6 {
  font-weight: bold;
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
}
.cm-header-1 {
  font-size: 185.7%;
}
.cm-header-2 {
  font-size: 157.1%;
}
.cm-header-3 {
  font-size: 128.6%;
}
.cm-header-4 {
  font-size: 110%;
}
.cm-header-5 {
  font-size: 100%;
  font-style: italic;
}
.cm-header-6 {
  font-size: 100%;
  font-style: italic;
}
.widget-interact > div,
.widget-interact > input {
  padding: 2.5px;
}
.widget-area {
  /*
    LESS file that styles IPython notebook widgets and the area they sit in.

    The widget area typically looks something like this:
     +------------------------------------------+
     | widget-area                              |
     |  +--------+---------------------------+  |
     |  | prompt | widget-subarea            |  |
     |  |        | +--------+  +--------+    |  |
     |  |        | | widget |  | widget |    |  |
     |  |        | +--------+  +--------+    |  |
     |  +--------+---------------------------+  |
     +------------------------------------------+
    */
  page-break-inside: avoid;
  /* Old browsers */
  display: -webkit-box;
  -webkit-box-orient: horizontal;
  -webkit-box-align: stretch;
  display: -moz-box;
  -moz-box-orient: horizontal;
  -moz-box-align: stretch;
  display: box;
  box-orient: horizontal;
  box-align: stretch;
  /* Modern browsers */
  display: flex;
  flex-direction: row;
  align-items: stretch;
}
.widget-area .widget-subarea {
  padding: 0.44em 0.4em 0.4em 1px;
  margin-left: 6px;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  /* Old browsers */
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-box-align: stretch;
  display: -moz-box;
  -moz-box-orient: vertical;
  -moz-box-align: stretch;
  display: box;
  box-orient: vertical;
  box-align: stretch;
  /* Modern browsers */
  display: flex;
  flex-direction: column;
  align-items: stretch;
  /* Old browsers */
  -webkit-box-flex: 2;
  -moz-box-flex: 2;
  box-flex: 2;
  /* Modern browsers */
  flex: 2;
  /* Old browsers */
  -webkit-box-align: start;
  -moz-box-align: start;
  box-align: start;
  /* Modern browsers */
  align-items: flex-start;
}
.widget-area.connection-problems .prompt:after {
  content: "\f127";
  font-family: 'FontAwesome';
  color: #d9534f;
  font-size: 14px;
  top: 3px;
  padding: 3px;
}
/* THE CLASSES BELOW CAN APPEAR ANYWHERE IN THE DOM (POSSIBLEY OUTSIDE OF
   THE WIDGET AREA). */
.slide-track {
  /* Slider Track */
  border: 1px solid #CCCCCC;
  background: #FFFFFF;
  border-radius: 2px;
  /* Round the corners of the slide track */
}
.widget-hslider {
  /* Horizontal jQuery Slider 

    Both the horizontal and vertical versions of the slider are characterized
    by a styled div that contains an invisible jQuery slide div which 
    contains a visible slider handle div.  This is requred so we can control
    how the slider is drawn and 'fix' the issue where the slide handle 
    doesn't stop at the end of the slide.

    Both horizontal and vertical sliders have this div nesting:
    +------------------------------------------+
    | widget-(h/v)slider                       |
    |  +--------+---------------------------+  |
    |  | ui-slider                          |  |
    |  |          +------------------+      |  |
    |  |          | ui-slider-handle |      |  |
    |  |          +------------------+      |  |
    |  +--------+---------------------------+  |
    +------------------------------------------+
    */
  /* Fix the padding of the slide track so the ui-slider is sized 
    correctly. */
  padding-left: 8px;
  padding-right: 2px;
  overflow: visible;
  /* Default size of the slider */
  width: 350px;
  height: 5px;
  max-height: 5px;
  margin-top: 13px;
  margin-bottom: 10px;
  /* Style the slider track */
  /* Slider Track */
  border: 1px solid #CCCCCC;
  background: #FFFFFF;
  border-radius: 2px;
  /* Round the corners of the slide track */
  /* Make the div a flex box (makes FF behave correctly). */
  /* Old browsers */
  display: -webkit-box;
  -webkit-box-orient: horizontal;
  -webkit-box-align: stretch;
  display: -moz-box;
  -moz-box-orient: horizontal;
  -moz-box-align: stretch;
  display: box;
  box-orient: horizontal;
  box-align: stretch;
  /* Modern browsers */
  display: flex;
  flex-direction: row;
  align-items: stretch;
}
.widget-hslider .ui-slider {
  /* Inner, invisible slide div */
  border: 0px;
  background: none;
  /* Old browsers */
  display: -webkit-box;
  -webkit-box-orient: horizontal;
  -webkit-box-align: stretch;
  display: -moz-box;
  -moz-box-orient: horizontal;
  -moz-box-align: stretch;
  display: box;
  box-orient: horizontal;
  box-align: stretch;
  /* Modern browsers */
  display: flex;
  flex-direction: row;
  align-items: stretch;
  /* Old browsers */
  -webkit-box-flex: 1;
  -moz-box-flex: 1;
  box-flex: 1;
  /* Modern browsers */
  flex: 1;
}
.widget-hslider .ui-slider .ui-slider-handle {
  width: 12px;
  height: 28px;
  margin-top: -8px;
  border-radius: 2px;
}
.widget-hslider .ui-slider .ui-slider-range {
  height: 12px;
  margin-top: -4px;
  background: #eeeeee;
}
.widget-vslider {
  /* Vertical jQuery Slider */
  /* Fix the padding of the slide track so the ui-slider is sized 
    correctly. */
  padding-bottom: 5px;
  overflow: visible;
  /* Default size of the slider */
  width: 5px;
  max-width: 5px;
  height: 250px;
  margin-left: 12px;
  /* Style the slider track */
  /* Slider Track */
  border: 1px solid #CCCCCC;
  background: #FFFFFF;
  border-radius: 2px;
  /* Round the corners of the slide track */
  /* Make the div a flex box (makes FF behave correctly). */
  /* Old browsers */
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-box-align: stretch;
  display: -moz-box;
  -moz-box-orient: vertical;
  -moz-box-align: stretch;
  display: box;
  box-orient: vertical;
  box-align: stretch;
  /* Modern browsers */
  display: flex;
  flex-direction: column;
  align-items: stretch;
}
.widget-vslider .ui-slider {
  /* Inner, invisible slide div */
  border: 0px;
  background: none;
  margin-left: -4px;
  margin-top: 5px;
  /* Old browsers */
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-box-align: stretch;
  display: -moz-box;
  -moz-box-orient: vertical;
  -moz-box-align: stretch;
  display: box;
  box-orient: vertical;
  box-align: stretch;
  /* Modern browsers */
  display: flex;
  flex-direction: column;
  align-items: stretch;
  /* Old browsers */
  -webkit-box-flex: 1;
  -moz-box-flex: 1;
  box-flex: 1;
  /* Modern browsers */
  flex: 1;
}
.widget-vslider .ui-slider .ui-slider-handle {
  width: 28px;
  height: 12px;
  margin-left: -9px;
  border-radius: 2px;
}
.widget-vslider .ui-slider .ui-slider-range {
  width: 12px;
  margin-left: -1px;
  background: #eeeeee;
}
.widget-text {
  /* String Textbox - used for TextBoxView and TextAreaView */
  width: 350px;
  margin: 0px;
}
.widget-listbox {
  /* Listbox */
  width: 350px;
  margin-bottom: 0px;
}
.widget-numeric-text {
  /* Single Line Textbox - used for IntTextView and FloatTextView */
  width: 150px;
  margin: 0px;
}
.widget-progress {
  /* Progress Bar */
  margin-top: 6px;
  min-width: 350px;
}
.widget-progress .progress-bar {
  /* Disable progress bar animation */
  -webkit-transition: none;
  -moz-transition: none;
  -ms-transition: none;
  -o-transition: none;
  transition: none;
}
.widget-combo-btn {
  /* ComboBox Main Button */
  /* Subtract 25px to account for the drop arrow button */
  min-width: 125px;
}
.widget_item .dropdown-menu li a {
  color: inherit;
}
.widget-hbox {
  /* Horizontal widgets */
  /* Old browsers */
  display: -webkit-box;
  -webkit-box-orient: horizontal;
  -webkit-box-align: stretch;
  display: -moz-box;
  -moz-box-orient: horizontal;
  -moz-box-align: stretch;
  display: box;
  box-orient: horizontal;
  box-align: stretch;
  /* Modern browsers */
  display: flex;
  flex-direction: row;
  align-items: stretch;
}
.widget-hbox input[type="checkbox"] {
  margin-top: 9px;
  margin-bottom: 10px;
}
.widget-hbox .widget-label {
  /* Horizontal Label */
  min-width: 10ex;
  padding-right: 8px;
  padding-top: 5px;
  text-align: right;
  vertical-align: text-top;
}
.widget-hbox .widget-readout {
  padding-left: 8px;
  padding-top: 5px;
  text-align: left;
  vertical-align: text-top;
}
.widget-vbox {
  /* Vertical widgets */
  /* Old browsers */
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-box-align: stretch;
  display: -moz-box;
  -moz-box-orient: vertical;
  -moz-box-align: stretch;
  display: box;
  box-orient: vertical;
  box-align: stretch;
  /* Modern browsers */
  display: flex;
  flex-direction: column;
  align-items: stretch;
}
.widget-vbox .widget-label {
  /* Vertical Label */
  padding-bottom: 5px;
  text-align: center;
  vertical-align: text-bottom;
}
.widget-vbox .widget-readout {
  /* Vertical Label */
  padding-top: 5px;
  text-align: center;
  vertical-align: text-top;
}
.widget-box {
  /* Box */
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  /* Old browsers */
  -webkit-box-align: start;
  -moz-box-align: start;
  box-align: start;
  /* Modern browsers */
  align-items: flex-start;
}
.widget-radio-box {
  /* Contains RadioButtonsWidget */
  /* Old browsers */
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-box-align: stretch;
  display: -moz-box;
  -moz-box-orient: vertical;
  -moz-box-align: stretch;
  display: box;
  box-orient: vertical;
  box-align: stretch;
  /* Modern browsers */
  display: flex;
  flex-direction: column;
  align-items: stretch;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  padding-top: 4px;
}
.widget-radio-box label {
  margin-top: 0px;
  margin-left: 20px;
}
/*!
*
* IPython notebook webapp
*
*/
@media (max-width: 767px) {
  .notebook_app {
    padding-left: 0px;
    padding-right: 0px;
  }
}
#ipython-main-app {
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  height: 100%;
}
div#notebook_panel {
  margin: 0px;
  padding: 0px;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  height: 100%;
}
#notebook {
  font-size: 14px;
  line-height: 20px;
  overflow-y: hidden;
  overflow-x: auto;
  width: 100%;
  /* This spaces the page away from the edge of the notebook area */
  padding-top: 20px;
  margin: 0px;
  outline: none;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  min-height: 100%;
}
@media not print {
  #notebook-container {
    padding: 15px;
    background-color: #ffffff;
    min-height: 0;
    -webkit-box-shadow: 0px 0px 12px 1px rgba(87, 87, 87, 0.2);
    box-shadow: 0px 0px 12px 1px rgba(87, 87, 87, 0.2);
  }
}
div.ui-widget-content {
  border: 1px solid #ababab;
  outline: none;
}
pre.dialog {
  background-color: #f7f7f7;
  border: 1px solid #ddd;
  border-radius: 2px;
  padding: 0.4em;
  padding-left: 2em;
}
p.dialog {
  padding: 0.2em;
}
/* Word-wrap output correctly.  This is the CSS3 spelling, though Firefox seems
   to not honor it correctly.  Webkit browsers (Chrome, rekonq, Safari) do.
 */
pre,
code,
kbd,
samp {
  white-space: pre-wrap;
}
#fonttest {
  font-family: monospace;
}
p {
  margin-bottom: 0;
}
.end_space {
  min-height: 100px;
  transition: height .2s ease;
}
.notebook_app #header {
  -webkit-box-shadow: 0px 0px 12px 1px rgba(87, 87, 87, 0.2);
  box-shadow: 0px 0px 12px 1px rgba(87, 87, 87, 0.2);
}
@media not print {
  .notebook_app {
    background-color: #eeeeee;
  }
}
/* CSS for the cell toolbar */
.celltoolbar {
  border: thin solid #CFCFCF;
  border-bottom: none;
  background: #EEE;
  border-radius: 2px 2px 0px 0px;
  width: 100%;
  height: 29px;
  padding-right: 4px;
  /* Old browsers */
  display: -webkit-box;
  -webkit-box-orient: horizontal;
  -webkit-box-align: stretch;
  display: -moz-box;
  -moz-box-orient: horizontal;
  -moz-box-align: stretch;
  display: box;
  box-orient: horizontal;
  box-align: stretch;
  /* Modern browsers */
  display: flex;
  flex-direction: row;
  align-items: stretch;
  /* Old browsers */
  -webkit-box-pack: end;
  -moz-box-pack: end;
  box-pack: end;
  /* Modern browsers */
  justify-content: flex-end;
}
@media print {
  .celltoolbar {
    display: none;
  }
}
.ctb_hideshow {
  display: none;
  vertical-align: bottom;
}
/* ctb_show is added to the ctb_hideshow div to show the cell toolbar.
   Cell toolbars are only shown when the ctb_global_show class is also set.
*/
.ctb_global_show .ctb_show.ctb_hideshow {
  display: block;
}
.ctb_global_show .ctb_show + .input_area,
.ctb_global_show .ctb_show + div.text_cell_input,
.ctb_global_show .ctb_show ~ div.text_cell_render {
  border-top-right-radius: 0px;
  border-top-left-radius: 0px;
}
.ctb_global_show .ctb_show ~ div.text_cell_render {
  border: 1px solid #cfcfcf;
}
.celltoolbar {
  font-size: 87%;
  padding-top: 3px;
}
.celltoolbar select {
  display: block;
  width: 100%;
  height: 32px;
  padding: 6px 12px;
  font-size: 13px;
  line-height: 1.42857143;
  color: #555555;
  background-color: #ffffff;
  background-image: none;
  border: 1px solid #cccccc;
  border-radius: 2px;
  -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
  box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
  -webkit-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
  -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
  transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
  height: 30px;
  padding: 5px 10px;
  font-size: 12px;
  line-height: 1.5;
  border-radius: 1px;
  width: inherit;
  font-size: inherit;
  height: 22px;
  padding: 0px;
  display: inline-block;
}
.celltoolbar select:focus {
  border-color: #66afe9;
  outline: 0;
  -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, 0.6);
  box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, 0.6);
}
.celltoolbar select::-moz-placeholder {
  color: #999999;
  opacity: 1;
}
.celltoolbar select:-ms-input-placeholder {
  color: #999999;
}
.celltoolbar select::-webkit-input-placeholder {
  color: #999999;
}
.celltoolbar select[disabled],
.celltoolbar select[readonly],
fieldset[disabled] .celltoolbar select {
  cursor: not-allowed;
  background-color: #eeeeee;
  opacity: 1;
}
textarea.celltoolbar select {
  height: auto;
}
select.celltoolbar select {
  height: 30px;
  line-height: 30px;
}
textarea.celltoolbar select,
select[multiple].celltoolbar select {
  height: auto;
}
.celltoolbar label {
  margin-left: 5px;
  margin-right: 5px;
}
.completions {
  position: absolute;
  z-index: 10;
  overflow: hidden;
  border: 1px solid #ababab;
  border-radius: 2px;
  -webkit-box-shadow: 0px 6px 10px -1px #adadad;
  box-shadow: 0px 6px 10px -1px #adadad;
}
.completions select {
  background: white;
  outline: none;
  border: none;
  padding: 0px;
  margin: 0px;
  overflow: auto;
  font-family: monospace;
  font-size: 110%;
  color: #000000;
  width: auto;
}
.completions select option.context {
  color: #286090;
}
#kernel_logo_widget {
  float: right !important;
  float: right;
}
#kernel_logo_widget .current_kernel_logo {
  display: none;
  margin-top: -1px;
  margin-bottom: -1px;
  width: 32px;
  height: 32px;
}
#menubar {
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  margin-top: 1px;
}
#menubar .navbar {
  border-top: 1px;
  border-radius: 0px 0px 2px 2px;
  margin-bottom: 0px;
}
#menubar .navbar-toggle {
  float: left;
  padding-top: 7px;
  padding-bottom: 7px;
  border: none;
}
#menubar .navbar-collapse {
  clear: left;
}
.nav-wrapper {
  border-bottom: 1px solid #e7e7e7;
}
i.menu-icon {
  padding-top: 4px;
}
ul#help_menu li a {
  overflow: hidden;
  padding-right: 2.2em;
}
ul#help_menu li a i {
  margin-right: -1.2em;
}
.dropdown-submenu {
  position: relative;
}
.dropdown-submenu > .dropdown-menu {
  top: 0;
  left: 100%;
  margin-top: -6px;
  margin-left: -1px;
}
.dropdown-submenu:hover > .dropdown-menu {
  display: block;
}
.dropdown-submenu > a:after {
  display: inline-block;
  font: normal normal normal 14px/1 FontAwesome;
  font-size: inherit;
  text-rendering: auto;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  transform: translate(0, 0);
  display: block;
  content: "\f0da";
  float: right;
  color: #333333;
  margin-top: 2px;
  margin-right: -10px;
}
.dropdown-submenu > a:after.pull-left {
  margin-right: .3em;
}
.dropdown-submenu > a:after.pull-right {
  margin-left: .3em;
}
.dropdown-submenu:hover > a:after {
  color: #262626;
}
.dropdown-submenu.pull-left {
  float: none;
}
.dropdown-submenu.pull-left > .dropdown-menu {
  left: -100%;
  margin-left: 10px;
}
#notification_area {
  float: right !important;
  float: right;
  z-index: 10;
}
.indicator_area {
  float: right !important;
  float: right;
  color: #777777;
  margin-left: 5px;
  margin-right: 5px;
  width: 11px;
  z-index: 10;
  text-align: center;
  width: auto;
}
#kernel_indicator {
  float: right !important;
  float: right;
  color: #777777;
  margin-left: 5px;
  margin-right: 5px;
  width: 11px;
  z-index: 10;
  text-align: center;
  width: auto;
  border-left: 1px solid;
}
#kernel_indicator .kernel_indicator_name {
  padding-left: 5px;
  padding-right: 5px;
}
#modal_indicator {
  float: right !important;
  float: right;
  color: #777777;
  margin-left: 5px;
  margin-right: 5px;
  width: 11px;
  z-index: 10;
  text-align: center;
  width: auto;
}
#readonly-indicator {
  float: right !important;
  float: right;
  color: #777777;
  margin-left: 5px;
  margin-right: 5px;
  width: 11px;
  z-index: 10;
  text-align: center;
  width: auto;
  margin-top: 2px;
  margin-bottom: 0px;
  margin-left: 0px;
  margin-right: 0px;
  display: none;
}
.modal_indicator:before {
  width: 1.28571429em;
  text-align: center;
}
.edit_mode .modal_indicator:before {
  display: inline-block;
  font: normal normal normal 14px/1 FontAwesome;
  font-size: inherit;
  text-rendering: auto;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  transform: translate(0, 0);
  content: "\f040";
}
.edit_mode .modal_indicator:before.pull-left {
  margin-right: .3em;
}
.edit_mode .modal_indicator:before.pull-right {
  margin-left: .3em;
}
.command_mode .modal_indicator:before {
  display: inline-block;
  font: normal normal normal 14px/1 FontAwesome;
  font-size: inherit;
  text-rendering: auto;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  transform: translate(0, 0);
  content: ' ';
}
.command_mode .modal_indicator:before.pull-left {
  margin-right: .3em;
}
.command_mode .modal_indicator:before.pull-right {
  margin-left: .3em;
}
.kernel_idle_icon:before {
  display: inline-block;
  font: normal normal normal 14px/1 FontAwesome;
  font-size: inherit;
  text-rendering: auto;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  transform: translate(0, 0);
  content: "\f10c";
}
.kernel_idle_icon:before.pull-left {
  margin-right: .3em;
}
.kernel_idle_icon:before.pull-right {
  margin-left: .3em;
}
.kernel_busy_icon:before {
  display: inline-block;
  font: normal normal normal 14px/1 FontAwesome;
  font-size: inherit;
  text-rendering: auto;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  transform: translate(0, 0);
  content: "\f111";
}
.kernel_busy_icon:before.pull-left {
  margin-right: .3em;
}
.kernel_busy_icon:before.pull-right {
  margin-left: .3em;
}
.kernel_dead_icon:before {
  display: inline-block;
  font: normal normal normal 14px/1 FontAwesome;
  font-size: inherit;
  text-rendering: auto;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  transform: translate(0, 0);
  content: "\f1e2";
}
.kernel_dead_icon:before.pull-left {
  margin-right: .3em;
}
.kernel_dead_icon:before.pull-right {
  margin-left: .3em;
}
.kernel_disconnected_icon:before {
  display: inline-block;
  font: normal normal normal 14px/1 FontAwesome;
  font-size: inherit;
  text-rendering: auto;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  transform: translate(0, 0);
  content: "\f127";
}
.kernel_disconnected_icon:before.pull-left {
  margin-right: .3em;
}
.kernel_disconnected_icon:before.pull-right {
  margin-left: .3em;
}
.notification_widget {
  color: #777777;
  z-index: 10;
  background: rgba(240, 240, 240, 0.5);
  margin-right: 4px;
  color: #333333;
  background-color: #ffffff;
  border-color: #cccccc;
}
.notification_widget:hover,
.notification_widget:focus,
.notification_widget.focus,
.notification_widget:active,
.notification_widget.active,
.open > .dropdown-toggle.notification_widget {
  color: #333333;
  background-color: #e6e6e6;
  border-color: #adadad;
}
.notification_widget:active,
.notification_widget.active,
.open > .dropdown-toggle.notification_widget {
  background-image: none;
}
.notification_widget.disabled,
.notification_widget[disabled],
fieldset[disabled] .notification_widget,
.notification_widget.disabled:hover,
.notification_widget[disabled]:hover,
fieldset[disabled] .notification_widget:hover,
.notification_widget.disabled:focus,
.notification_widget[disabled]:focus,
fieldset[disabled] .notification_widget:focus,
.notification_widget.disabled.focus,
.notification_widget[disabled].focus,
fieldset[disabled] .notification_widget.focus,
.notification_widget.disabled:active,
.notification_widget[disabled]:active,
fieldset[disabled] .notification_widget:active,
.notification_widget.disabled.active,
.notification_widget[disabled].active,
fieldset[disabled] .notification_widget.active {
  background-color: #ffffff;
  border-color: #cccccc;
}
.notification_widget .badge {
  color: #ffffff;
  background-color: #333333;
}
.notification_widget.warning {
  color: #ffffff;
  background-color: #f0ad4e;
  border-color: #eea236;
}
.notification_widget.warning:hover,
.notification_widget.warning:focus,
.notification_widget.warning.focus,
.notification_widget.warning:active,
.notification_widget.warning.active,
.open > .dropdown-toggle.notification_widget.warning {
  color: #ffffff;
  background-color: #ec971f;
  border-color: #d58512;
}
.notification_widget.warning:active,
.notification_widget.warning.active,
.open > .dropdown-toggle.notification_widget.warning {
  background-image: none;
}
.notification_widget.warning.disabled,
.notification_widget.warning[disabled],
fieldset[disabled] .notification_widget.warning,
.notification_widget.warning.disabled:hover,
.notification_widget.warning[disabled]:hover,
fieldset[disabled] .notification_widget.warning:hover,
.notification_widget.warning.disabled:focus,
.notification_widget.warning[disabled]:focus,
fieldset[disabled] .notification_widget.warning:focus,
.notification_widget.warning.disabled.focus,
.notification_widget.warning[disabled].focus,
fieldset[disabled] .notification_widget.warning.focus,
.notification_widget.warning.disabled:active,
.notification_widget.warning[disabled]:active,
fieldset[disabled] .notification_widget.warning:active,
.notification_widget.warning.disabled.active,
.notification_widget.warning[disabled].active,
fieldset[disabled] .notification_widget.warning.active {
  background-color: #f0ad4e;
  border-color: #eea236;
}
.notification_widget.warning .badge {
  color: #f0ad4e;
  background-color: #ffffff;
}
.notification_widget.success {
  color: #ffffff;
  background-color: #5cb85c;
  border-color: #4cae4c;
}
.notification_widget.success:hover,
.notification_widget.success:focus,
.notification_widget.success.focus,
.notification_widget.success:active,
.notification_widget.success.active,
.open > .dropdown-toggle.notification_widget.success {
  color: #ffffff;
  background-color: #449d44;
  border-color: #398439;
}
.notification_widget.success:active,
.notification_widget.success.active,
.open > .dropdown-toggle.notification_widget.success {
  background-image: none;
}
.notification_widget.success.disabled,
.notification_widget.success[disabled],
fieldset[disabled] .notification_widget.success,
.notification_widget.success.disabled:hover,
.notification_widget.success[disabled]:hover,
fieldset[disabled] .notification_widget.success:hover,
.notification_widget.success.disabled:focus,
.notification_widget.success[disabled]:focus,
fieldset[disabled] .notification_widget.success:focus,
.notification_widget.success.disabled.focus,
.notification_widget.success[disabled].focus,
fieldset[disabled] .notification_widget.success.focus,
.notification_widget.success.disabled:active,
.notification_widget.success[disabled]:active,
fieldset[disabled] .notification_widget.success:active,
.notification_widget.success.disabled.active,
.notification_widget.success[disabled].active,
fieldset[disabled] .notification_widget.success.active {
  background-color: #5cb85c;
  border-color: #4cae4c;
}
.notification_widget.success .badge {
  color: #5cb85c;
  background-color: #ffffff;
}
.notification_widget.info {
  color: #ffffff;
  background-color: #5bc0de;
  border-color: #46b8da;
}
.notification_widget.info:hover,
.notification_widget.info:focus,
.notification_widget.info.focus,
.notification_widget.info:active,
.notification_widget.info.active,
.open > .dropdown-toggle.notification_widget.info {
  color: #ffffff;
  background-color: #31b0d5;
  border-color: #269abc;
}
.notification_widget.info:active,
.notification_widget.info.active,
.open > .dropdown-toggle.notification_widget.info {
  background-image: none;
}
.notification_widget.info.disabled,
.notification_widget.info[disabled],
fieldset[disabled] .notification_widget.info,
.notification_widget.info.disabled:hover,
.notification_widget.info[disabled]:hover,
fieldset[disabled] .notification_widget.info:hover,
.notification_widget.info.disabled:focus,
.notification_widget.info[disabled]:focus,
fieldset[disabled] .notification_widget.info:focus,
.notification_widget.info.disabled.focus,
.notification_widget.info[disabled].focus,
fieldset[disabled] .notification_widget.info.focus,
.notification_widget.info.disabled:active,
.notification_widget.info[disabled]:active,
fieldset[disabled] .notification_widget.info:active,
.notification_widget.info.disabled.active,
.notification_widget.info[disabled].active,
fieldset[disabled] .notification_widget.info.active {
  background-color: #5bc0de;
  border-color: #46b8da;
}
.notification_widget.info .badge {
  color: #5bc0de;
  background-color: #ffffff;
}
.notification_widget.danger {
  color: #ffffff;
  background-color: #d9534f;
  border-color: #d43f3a;
}
.notification_widget.danger:hover,
.notification_widget.danger:focus,
.notification_widget.danger.focus,
.notification_widget.danger:active,
.notification_widget.danger.active,
.open > .dropdown-toggle.notification_widget.danger {
  color: #ffffff;
  background-color: #c9302c;
  border-color: #ac2925;
}
.notification_widget.danger:active,
.notification_widget.danger.active,
.open > .dropdown-toggle.notification_widget.danger {
  background-image: none;
}
.notification_widget.danger.disabled,
.notification_widget.danger[disabled],
fieldset[disabled] .notification_widget.danger,
.notification_widget.danger.disabled:hover,
.notification_widget.danger[disabled]:hover,
fieldset[disabled] .notification_widget.danger:hover,
.notification_widget.danger.disabled:focus,
.notification_widget.danger[disabled]:focus,
fieldset[disabled] .notification_widget.danger:focus,
.notification_widget.danger.disabled.focus,
.notification_widget.danger[disabled].focus,
fieldset[disabled] .notification_widget.danger.focus,
.notification_widget.danger.disabled:active,
.notification_widget.danger[disabled]:active,
fieldset[disabled] .notification_widget.danger:active,
.notification_widget.danger.disabled.active,
.notification_widget.danger[disabled].active,
fieldset[disabled] .notification_widget.danger.active {
  background-color: #d9534f;
  border-color: #d43f3a;
}
.notification_widget.danger .badge {
  color: #d9534f;
  background-color: #ffffff;
}
div#pager {
  background-color: #ffffff;
  font-size: 14px;
  line-height: 20px;
  overflow: hidden;
  display: none;
  position: fixed;
  bottom: 0px;
  width: 100%;
  max-height: 50%;
  padding-top: 8px;
  -webkit-box-shadow: 0px 0px 12px 1px rgba(87, 87, 87, 0.2);
  box-shadow: 0px 0px 12px 1px rgba(87, 87, 87, 0.2);
  /* Display over codemirror */
  z-index: 100;
  /* Hack which prevents jquery ui resizable from changing top. */
  top: auto !important;
}
div#pager pre {
  line-height: 1.21429em;
  color: #000000;
  background-color: #f7f7f7;
  padding: 0.4em;
}
div#pager #pager-button-area {
  position: absolute;
  top: 8px;
  right: 20px;
}
div#pager #pager-contents {
  position: relative;
  overflow: auto;
  width: 100%;
  height: 100%;
}
div#pager #pager-contents #pager-container {
  position: relative;
  padding: 15px 0px;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
}
div#pager .ui-resizable-handle {
  top: 0px;
  height: 8px;
  background: #f7f7f7;
  border-top: 1px solid #cfcfcf;
  border-bottom: 1px solid #cfcfcf;
  /* This injects handle bars (a short, wide = symbol) for 
        the resize handle. */
}
div#pager .ui-resizable-handle::after {
  content: '';
  top: 2px;
  left: 50%;
  height: 3px;
  width: 30px;
  margin-left: -15px;
  position: absolute;
  border-top: 1px solid #cfcfcf;
}
.quickhelp {
  /* Old browsers */
  display: -webkit-box;
  -webkit-box-orient: horizontal;
  -webkit-box-align: stretch;
  display: -moz-box;
  -moz-box-orient: horizontal;
  -moz-box-align: stretch;
  display: box;
  box-orient: horizontal;
  box-align: stretch;
  /* Modern browsers */
  display: flex;
  flex-direction: row;
  align-items: stretch;
}
.shortcut_key {
  display: inline-block;
  width: 20ex;
  text-align: right;
  font-family: monospace;
}
.shortcut_descr {
  display: inline-block;
  /* Old browsers */
  -webkit-box-flex: 1;
  -moz-box-flex: 1;
  box-flex: 1;
  /* Modern browsers */
  flex: 1;
}
span.save_widget {
  margin-top: 6px;
}
span.save_widget span.filename {
  height: 1em;
  line-height: 1em;
  padding: 3px;
  margin-left: 16px;
  border: none;
  font-size: 146.5%;
  border-radius: 2px;
}
span.save_widget span.filename:hover {
  background-color: #e6e6e6;
}
span.checkpoint_status,
span.autosave_status {
  font-size: small;
}
@media (max-width: 767px) {
  span.save_widget {
    font-size: small;
  }
  span.checkpoint_status,
  span.autosave_status {
    display: none;
  }
}
@media (min-width: 768px) and (max-width: 991px) {
  span.checkpoint_status {
    display: none;
  }
  span.autosave_status {
    font-size: x-small;
  }
}
.toolbar {
  padding: 0px;
  margin-left: -5px;
  margin-top: 2px;
  margin-bottom: 5px;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
}
.toolbar select,
.toolbar label {
  width: auto;
  vertical-align: middle;
  margin-right: 2px;
  margin-bottom: 0px;
  display: inline;
  font-size: 92%;
  margin-left: 0.3em;
  margin-right: 0.3em;
  padding: 0px;
  padding-top: 3px;
}
.toolbar .btn {
  padding: 2px 8px;
}
.toolbar .btn-group {
  margin-top: 0px;
  margin-left: 5px;
}
#maintoolbar {
  margin-bottom: -3px;
  margin-top: -8px;
  border: 0px;
  min-height: 27px;
  margin-left: 0px;
  padding-top: 11px;
  padding-bottom: 3px;
}
#maintoolbar .navbar-text {
  float: none;
  vertical-align: middle;
  text-align: right;
  margin-left: 5px;
  margin-right: 0px;
  margin-top: 0px;
}
.select-xs {
  height: 24px;
}
/**
 * Primary styles
 *
 * Author: IPython Development Team
 */
/** WARNING IF YOU ARE EDITTING THIS FILE, if this is a .css file, It has a lot
 * of chance of beeing generated from the ../less/[samename].less file, you can
 * try to get back the less file by reverting somme commit in history
 **/
/*
 * We'll try to get something pretty, so we
 * have some strange css to have the scroll bar on
 * the left with fix button on the top right of the tooltip
 */
@-moz-keyframes fadeOut {
  from {
    opacity: 1;
  }
  to {
    opacity: 0;
  }
}
@-webkit-keyframes fadeOut {
  from {
    opacity: 1;
  }
  to {
    opacity: 0;
  }
}
@-moz-keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}
@-webkit-keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}
/*properties of tooltip after "expand"*/
.bigtooltip {
  overflow: auto;
  height: 200px;
  -webkit-transition-property: height;
  -webkit-transition-duration: 500ms;
  -moz-transition-property: height;
  -moz-transition-duration: 500ms;
  transition-property: height;
  transition-duration: 500ms;
}
/*properties of tooltip before "expand"*/
.smalltooltip {
  -webkit-transition-property: height;
  -webkit-transition-duration: 500ms;
  -moz-transition-property: height;
  -moz-transition-duration: 500ms;
  transition-property: height;
  transition-duration: 500ms;
  text-overflow: ellipsis;
  overflow: hidden;
  height: 80px;
}
.tooltipbuttons {
  position: absolute;
  padding-right: 15px;
  top: 0px;
  right: 0px;
}
.tooltiptext {
  /*avoid the button to overlap on some docstring*/
  padding-right: 30px;
}
.ipython_tooltip {
  max-width: 700px;
  /*fade-in animation when inserted*/
  -webkit-animation: fadeOut 400ms;
  -moz-animation: fadeOut 400ms;
  animation: fadeOut 400ms;
  -webkit-animation: fadeIn 400ms;
  -moz-animation: fadeIn 400ms;
  animation: fadeIn 400ms;
  vertical-align: middle;
  background-color: #f7f7f7;
  overflow: visible;
  border: #ababab 1px solid;
  outline: none;
  padding: 3px;
  margin: 0px;
  padding-left: 7px;
  font-family: monospace;
  min-height: 50px;
  -moz-box-shadow: 0px 6px 10px -1px #adadad;
  -webkit-box-shadow: 0px 6px 10px -1px #adadad;
  box-shadow: 0px 6px 10px -1px #adadad;
  border-radius: 2px;
  position: absolute;
  z-index: 1000;
}
.ipython_tooltip a {
  float: right;
}
.ipython_tooltip .tooltiptext pre {
  border: 0;
  border-radius: 0;
  font-size: 100%;
  background-color: #f7f7f7;
}
.pretooltiparrow {
  left: 0px;
  margin: 0px;
  top: -16px;
  width: 40px;
  height: 16px;
  overflow: hidden;
  position: absolute;
}
.pretooltiparrow:before {
  background-color: #f7f7f7;
  border: 1px #ababab solid;
  z-index: 11;
  content: "";
  position: absolute;
  left: 15px;
  top: 10px;
  width: 25px;
  height: 25px;
  -webkit-transform: rotate(45deg);
  -moz-transform: rotate(45deg);
  -ms-transform: rotate(45deg);
  -o-transform: rotate(45deg);
}
.terminal-app {
  background: #eeeeee;
}
.terminal-app #header {
  background: #ffffff;
  -webkit-box-shadow: 0px 0px 12px 1px rgba(87, 87, 87, 0.2);
  box-shadow: 0px 0px 12px 1px rgba(87, 87, 87, 0.2);
}
.terminal-app .terminal {
  float: left;
  font-family: monospace;
  color: white;
  background: black;
  padding: 0.4em;
  border-radius: 2px;
  -webkit-box-shadow: 0px 0px 12px 1px rgba(87, 87, 87, 0.4);
  box-shadow: 0px 0px 12px 1px rgba(87, 87, 87, 0.4);
}
.terminal-app .terminal,
.terminal-app .terminal dummy-screen {
  line-height: 1em;
  font-size: 14px;
}
.terminal-app .terminal-cursor {
  color: black;
  background: white;
}
.terminal-app #terminado-container {
  margin-top: 20px;
}
/*# sourceMappingURL=style.min.css.map */
    </style>
<style type="text/css">
    .highlight .hll { background-color: #ffffcc }
.highlight  { background: #f8f8f8; }
.highlight .c { color: #408080; font-style: italic } /* Comment */
.highlight .err { border: 1px solid #FF0000 } /* Error */
.highlight .k { color: #008000; font-weight: bold } /* Keyword */
.highlight .o { color: #666666 } /* Operator */
.highlight .cm { color: #408080; font-style: italic } /* Comment.Multiline */
.highlight .cp { color: #BC7A00 } /* Comment.Preproc */
.highlight .c1 { color: #408080; font-style: italic } /* Comment.Single */
.highlight .cs { color: #408080; font-style: italic } /* Comment.Special */
.highlight .gd { color: #A00000 } /* Generic.Deleted */
.highlight .ge { font-style: italic } /* Generic.Emph */
.highlight .gr { color: #FF0000 } /* Generic.Error */
.highlight .gh { color: #000080; font-weight: bold } /* Generic.Heading */
.highlight .gi { color: #00A000 } /* Generic.Inserted */
.highlight .go { color: #888888 } /* Generic.Output */
.highlight .gp { color: #000080; font-weight: bold } /* Generic.Prompt */
.highlight .gs { font-weight: bold } /* Generic.Strong */
.highlight .gu { color: #800080; font-weight: bold } /* Generic.Subheading */
.highlight .gt { color: #0044DD } /* Generic.Traceback */
.highlight .kc { color: #008000; font-weight: bold } /* Keyword.Constant */
.highlight .kd { color: #008000; font-weight: bold } /* Keyword.Declaration */
.highlight .kn { color: #008000; font-weight: bold } /* Keyword.Namespace */
.highlight .kp { color: #008000 } /* Keyword.Pseudo */
.highlight .kr { color: #008000; font-weight: bold } /* Keyword.Reserved */
.highlight .kt { color: #B00040 } /* Keyword.Type */
.highlight .m { color: #666666 } /* Literal.Number */
.highlight .s { color: #BA2121 } /* Literal.String */
.highlight .na { color: #7D9029 } /* Name.Attribute */
.highlight .nb { color: #008000 } /* Name.Builtin */
.highlight .nc { color: #0000FF; font-weight: bold } /* Name.Class */
.highlight .no { color: #880000 } /* Name.Constant */
.highlight .nd { color: #AA22FF } /* Name.Decorator */
.highlight .ni { color: #999999; font-weight: bold } /* Name.Entity */
.highlight .ne { color: #D2413A; font-weight: bold } /* Name.Exception */
.highlight .nf { color: #0000FF } /* Name.Function */
.highlight .nl { color: #A0A000 } /* Name.Label */
.highlight .nn { color: #0000FF; font-weight: bold } /* Name.Namespace */
.highlight .nt { color: #008000; font-weight: bold } /* Name.Tag */
.highlight .nv { color: #19177C } /* Name.Variable */
.highlight .ow { color: #AA22FF; font-weight: bold } /* Operator.Word */
.highlight .w { color: #bbbbbb } /* Text.Whitespace */
.highlight .mb { color: #666666 } /* Literal.Number.Bin */
.highlight .mf { color: #666666 } /* Literal.Number.Float */
.highlight .mh { color: #666666 } /* Literal.Number.Hex */
.highlight .mi { color: #666666 } /* Literal.Number.Integer */
.highlight .mo { color: #666666 } /* Literal.Number.Oct */
.highlight .sb { color: #BA2121 } /* Literal.String.Backtick */
.highlight .sc { color: #BA2121 } /* Literal.String.Char */
.highlight .sd { color: #BA2121; font-style: italic } /* Literal.String.Doc */
.highlight .s2 { color: #BA2121 } /* Literal.String.Double */
.highlight .se { color: #BB6622; font-weight: bold } /* Literal.String.Escape */
.highlight .sh { color: #BA2121 } /* Literal.String.Heredoc */
.highlight .si { color: #BB6688; font-weight: bold } /* Literal.String.Interpol */
.highlight .sx { color: #008000 } /* Literal.String.Other */
.highlight .sr { color: #BB6688 } /* Literal.String.Regex */
.highlight .s1 { color: #BA2121 } /* Literal.String.Single */
.highlight .ss { color: #19177C } /* Literal.String.Symbol */
.highlight .bp { color: #008000 } /* Name.Builtin.Pseudo */
.highlight .vc { color: #19177C } /* Name.Variable.Class */
.highlight .vg { color: #19177C } /* Name.Variable.Global */
.highlight .vi { color: #19177C } /* Name.Variable.Instance */
.highlight .il { color: #666666 } /* Literal.Number.Integer.Long */
    </style>




<!-- Loading mathjax macro -->
<!-- Load mathjax -->
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML"></script>
<!-- MathJax configuration -->
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
tex2jax: {
inlineMath: [ ['$','$'], ["\\(","\\)"] ],
displayMath: [ ['$$','$$'], ["\\[","\\]"] ],
processEscapes: true,
processEnvironments: true
},
// Center justify equations in code and markdown cells. Elsewhere
// we use CSS to left justify single line equations in code cells.
displayAlign: 'center',
"HTML-CSS": {
styles: {'.MathJax_Display': {"margin": 0}},
linebreaks: { automatic: true }
}
});
</script>
<!-- End of mathjax configuration -->

</head>
<body>
<div class="cell border-box-sizing text_cell rendered">
<div class="prompt input_prompt">
</div>
<div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>You've just bought a brand new computer. You excitedly rip open the packaging, carefully extract it from the box, remove the protective film from the screen (so satisfying) and, after 10 hours of charging, boot it up. It turns on fine, and everything seems to be functioning normally. It's only after a few minutes of use that you discover, to your horror, that the manufacturer has forgotten to store the constant \\(\pi\\) on the operating system. How are you going to play <a href="https://kerbalspaceprogram.com/en/">Kerbal space program</a> if you can't calculate the equations of motion of your rockets and space probes?!</p>
<p>One way around this is to use Monte Carlo methods, taking advantage of the law of large numbers to gain a reasonable approximation of pi to a few decimal places. In this post I'll demonstrate this using Julia (we'll conveniently ignore the fact that Julia has the number \\(\pi\\) in it), which I've just started learning and having a play with.</p>
<p>Take a square of side \\(a\\), centred on the origin. Now place a circle inside the square with radius \\(a/2\\), also centred on the origin. The area of the rectangle is \\(a^2\\), and the area of the circle is \\(\pi (a/2)^2\\).</p>


<div class="output_html rendered_html output_subarea output_execute_result">
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg"
     xmlns:xlink="http://www.w3.org/1999/xlink"
     xmlns:gadfly="http://www.gadflyjl.org/ns"
     version="1.2"
     width="100mm" height="100mm" viewBox="0 0 100 100"
     stroke="none"
     fill="#000000"
     stroke-width="0.3"
     font-size="3.88"

     id="fig-3c6b6271d428432bb093ba384495116a">
<g fill="#000000" id="fig-3c6b6271d428432bb093ba384495116a-element-1">
  <rect x="0" y="0" width="100" height="100"/>
</g>
<g fill="#FF6347" id="fig-3c6b6271d428432bb093ba384495116a-element-2">
  <circle cx="50" cy="50" r="50"/>
</g>
<script> <![CDATA[
(function(N){var k=/[\.\/]/,L=/\s*,\s*/,C=function(a,d){return a-d},a,v,y={n:{}},M=function(){for(var a=0,d=this.length;a<d;a++)if("undefined"!=typeof this[a])return this[a]},A=function(){for(var a=this.length;--a;)if("undefined"!=typeof this[a])return this[a]},w=function(k,d){k=String(k);var f=v,n=Array.prototype.slice.call(arguments,2),u=w.listeners(k),p=0,b,q=[],e={},l=[],r=a;l.firstDefined=M;l.lastDefined=A;a=k;for(var s=v=0,x=u.length;s<x;s++)"zIndex"in u[s]&&(q.push(u[s].zIndex),0>u[s].zIndex&&
(e[u[s].zIndex]=u[s]));for(q.sort(C);0>q[p];)if(b=e[q[p++] ],l.push(b.apply(d,n)),v)return v=f,l;for(s=0;s<x;s++)if(b=u[s],"zIndex"in b)if(b.zIndex==q[p]){l.push(b.apply(d,n));if(v)break;do if(p++,(b=e[q[p] ])&&l.push(b.apply(d,n)),v)break;while(b)}else e[b.zIndex]=b;else if(l.push(b.apply(d,n)),v)break;v=f;a=r;return l};w._events=y;w.listeners=function(a){a=a.split(k);var d=y,f,n,u,p,b,q,e,l=[d],r=[];u=0;for(p=a.length;u<p;u++){e=[];b=0;for(q=l.length;b<q;b++)for(d=l[b].n,f=[d[a[u] ],d["*"] ],n=2;n--;)if(d=
f[n])e.push(d),r=r.concat(d.f||[]);l=e}return r};w.on=function(a,d){a=String(a);if("function"!=typeof d)return function(){};for(var f=a.split(L),n=0,u=f.length;n<u;n++)(function(a){a=a.split(k);for(var b=y,f,e=0,l=a.length;e<l;e++)b=b.n,b=b.hasOwnProperty(a[e])&&b[a[e] ]||(b[a[e] ]={n:{}});b.f=b.f||[];e=0;for(l=b.f.length;e<l;e++)if(b.f[e]==d){f=!0;break}!f&&b.f.push(d)})(f[n]);return function(a){+a==+a&&(d.zIndex=+a)}};w.f=function(a){var d=[].slice.call(arguments,1);return function(){w.apply(null,
[a,null].concat(d).concat([].slice.call(arguments,0)))}};w.stop=function(){v=1};w.nt=function(k){return k?(new RegExp("(?:\\.|\\/|^)"+k+"(?:\\.|\\/|$)")).test(a):a};w.nts=function(){return a.split(k)};w.off=w.unbind=function(a,d){if(a){var f=a.split(L);if(1<f.length)for(var n=0,u=f.length;n<u;n++)w.off(f[n],d);else{for(var f=a.split(k),p,b,q,e,l=[y],n=0,u=f.length;n<u;n++)for(e=0;e<l.length;e+=q.length-2){q=[e,1];p=l[e].n;if("*"!=f[n])p[f[n] ]&&q.push(p[f[n] ]);else for(b in p)p.hasOwnProperty(b)&&
q.push(p[b]);l.splice.apply(l,q)}n=0;for(u=l.length;n<u;n++)for(p=l[n];p.n;){if(d){if(p.f){e=0;for(f=p.f.length;e<f;e++)if(p.f[e]==d){p.f.splice(e,1);break}!p.f.length&&delete p.f}for(b in p.n)if(p.n.hasOwnProperty(b)&&p.n[b].f){q=p.n[b].f;e=0;for(f=q.length;e<f;e++)if(q[e]==d){q.splice(e,1);break}!q.length&&delete p.n[b].f}}else for(b in delete p.f,p.n)p.n.hasOwnProperty(b)&&p.n[b].f&&delete p.n[b].f;p=p.n}}}else w._events=y={n:{}}};w.once=function(a,d){var f=function(){w.unbind(a,f);return d.apply(this,
arguments)};return w.on(a,f)};w.version="0.4.2";w.toString=function(){return"You are running Eve 0.4.2"};"undefined"!=typeof module&&module.exports?module.exports=w:"function"===typeof define&&define.amd?define("eve",[],function(){return w}):N.eve=w})(this);
(function(N,k){"function"===typeof define&&define.amd?define("Snap.svg",["eve"],function(L){return k(N,L)}):k(N,N.eve)})(this,function(N,k){var L=function(a){var k={},y=N.requestAnimationFrame||N.webkitRequestAnimationFrame||N.mozRequestAnimationFrame||N.oRequestAnimationFrame||N.msRequestAnimationFrame||function(a){setTimeout(a,16)},M=Array.isArray||function(a){return a instanceof Array||"[object Array]"==Object.prototype.toString.call(a)},A=0,w="M"+(+new Date).toString(36),z=function(a){if(null==
a)return this.s;var b=this.s-a;this.b+=this.dur*b;this.B+=this.dur*b;this.s=a},d=function(a){if(null==a)return this.spd;this.spd=a},f=function(a){if(null==a)return this.dur;this.s=this.s*a/this.dur;this.dur=a},n=function(){delete k[this.id];this.update();a("mina.stop."+this.id,this)},u=function(){this.pdif||(delete k[this.id],this.update(),this.pdif=this.get()-this.b)},p=function(){this.pdif&&(this.b=this.get()-this.pdif,delete this.pdif,k[this.id]=this)},b=function(){var a;if(M(this.start)){a=[];
for(var b=0,e=this.start.length;b<e;b++)a[b]=+this.start[b]+(this.end[b]-this.start[b])*this.easing(this.s)}else a=+this.start+(this.end-this.start)*this.easing(this.s);this.set(a)},q=function(){var l=0,b;for(b in k)if(k.hasOwnProperty(b)){var e=k[b],f=e.get();l++;e.s=(f-e.b)/(e.dur/e.spd);1<=e.s&&(delete k[b],e.s=1,l--,function(b){setTimeout(function(){a("mina.finish."+b.id,b)})}(e));e.update()}l&&y(q)},e=function(a,r,s,x,G,h,J){a={id:w+(A++).toString(36),start:a,end:r,b:s,s:0,dur:x-s,spd:1,get:G,
set:h,easing:J||e.linear,status:z,speed:d,duration:f,stop:n,pause:u,resume:p,update:b};k[a.id]=a;r=0;for(var K in k)if(k.hasOwnProperty(K)&&(r++,2==r))break;1==r&&y(q);return a};e.time=Date.now||function(){return+new Date};e.getById=function(a){return k[a]||null};e.linear=function(a){return a};e.easeout=function(a){return Math.pow(a,1.7)};e.easein=function(a){return Math.pow(a,0.48)};e.easeinout=function(a){if(1==a)return 1;if(0==a)return 0;var b=0.48-a/1.04,e=Math.sqrt(0.1734+b*b);a=e-b;a=Math.pow(Math.abs(a),
1/3)*(0>a?-1:1);b=-e-b;b=Math.pow(Math.abs(b),1/3)*(0>b?-1:1);a=a+b+0.5;return 3*(1-a)*a*a+a*a*a};e.backin=function(a){return 1==a?1:a*a*(2.70158*a-1.70158)};e.backout=function(a){if(0==a)return 0;a-=1;return a*a*(2.70158*a+1.70158)+1};e.elastic=function(a){return a==!!a?a:Math.pow(2,-10*a)*Math.sin(2*(a-0.075)*Math.PI/0.3)+1};e.bounce=function(a){a<1/2.75?a*=7.5625*a:a<2/2.75?(a-=1.5/2.75,a=7.5625*a*a+0.75):a<2.5/2.75?(a-=2.25/2.75,a=7.5625*a*a+0.9375):(a-=2.625/2.75,a=7.5625*a*a+0.984375);return a};
return N.mina=e}("undefined"==typeof k?function(){}:k),C=function(){function a(c,t){if(c){if(c.tagName)return x(c);if(y(c,"array")&&a.set)return a.set.apply(a,c);if(c instanceof e)return c;if(null==t)return c=G.doc.querySelector(c),x(c)}return new s(null==c?"100%":c,null==t?"100%":t)}function v(c,a){if(a){"#text"==c&&(c=G.doc.createTextNode(a.text||""));"string"==typeof c&&(c=v(c));if("string"==typeof a)return"xlink:"==a.substring(0,6)?c.getAttributeNS(m,a.substring(6)):"xml:"==a.substring(0,4)?c.getAttributeNS(la,
a.substring(4)):c.getAttribute(a);for(var da in a)if(a[h](da)){var b=J(a[da]);b?"xlink:"==da.substring(0,6)?c.setAttributeNS(m,da.substring(6),b):"xml:"==da.substring(0,4)?c.setAttributeNS(la,da.substring(4),b):c.setAttribute(da,b):c.removeAttribute(da)}}else c=G.doc.createElementNS(la,c);return c}function y(c,a){a=J.prototype.toLowerCase.call(a);return"finite"==a?isFinite(c):"array"==a&&(c instanceof Array||Array.isArray&&Array.isArray(c))?!0:"null"==a&&null===c||a==typeof c&&null!==c||"object"==
a&&c===Object(c)||$.call(c).slice(8,-1).toLowerCase()==a}function M(c){if("function"==typeof c||Object(c)!==c)return c;var a=new c.constructor,b;for(b in c)c[h](b)&&(a[b]=M(c[b]));return a}function A(c,a,b){function m(){var e=Array.prototype.slice.call(arguments,0),f=e.join("\u2400"),d=m.cache=m.cache||{},l=m.count=m.count||[];if(d[h](f)){a:for(var e=l,l=f,B=0,H=e.length;B<H;B++)if(e[B]===l){e.push(e.splice(B,1)[0]);break a}return b?b(d[f]):d[f]}1E3<=l.length&&delete d[l.shift()];l.push(f);d[f]=c.apply(a,
e);return b?b(d[f]):d[f]}return m}function w(c,a,b,m,e,f){return null==e?(c-=b,a-=m,c||a?(180*I.atan2(-a,-c)/C+540)%360:0):w(c,a,e,f)-w(b,m,e,f)}function z(c){return c%360*C/180}function d(c){var a=[];c=c.replace(/(?:^|\s)(\w+)\(([^)]+)\)/g,function(c,b,m){m=m.split(/\s*,\s*|\s+/);"rotate"==b&&1==m.length&&m.push(0,0);"scale"==b&&(2<m.length?m=m.slice(0,2):2==m.length&&m.push(0,0),1==m.length&&m.push(m[0],0,0));"skewX"==b?a.push(["m",1,0,I.tan(z(m[0])),1,0,0]):"skewY"==b?a.push(["m",1,I.tan(z(m[0])),
0,1,0,0]):a.push([b.charAt(0)].concat(m));return c});return a}function f(c,t){var b=O(c),m=new a.Matrix;if(b)for(var e=0,f=b.length;e<f;e++){var h=b[e],d=h.length,B=J(h[0]).toLowerCase(),H=h[0]!=B,l=H?m.invert():0,E;"t"==B&&2==d?m.translate(h[1],0):"t"==B&&3==d?H?(d=l.x(0,0),B=l.y(0,0),H=l.x(h[1],h[2]),l=l.y(h[1],h[2]),m.translate(H-d,l-B)):m.translate(h[1],h[2]):"r"==B?2==d?(E=E||t,m.rotate(h[1],E.x+E.width/2,E.y+E.height/2)):4==d&&(H?(H=l.x(h[2],h[3]),l=l.y(h[2],h[3]),m.rotate(h[1],H,l)):m.rotate(h[1],
h[2],h[3])):"s"==B?2==d||3==d?(E=E||t,m.scale(h[1],h[d-1],E.x+E.width/2,E.y+E.height/2)):4==d?H?(H=l.x(h[2],h[3]),l=l.y(h[2],h[3]),m.scale(h[1],h[1],H,l)):m.scale(h[1],h[1],h[2],h[3]):5==d&&(H?(H=l.x(h[3],h[4]),l=l.y(h[3],h[4]),m.scale(h[1],h[2],H,l)):m.scale(h[1],h[2],h[3],h[4])):"m"==B&&7==d&&m.add(h[1],h[2],h[3],h[4],h[5],h[6])}return m}function n(c,t){if(null==t){var m=!0;t="linearGradient"==c.type||"radialGradient"==c.type?c.node.getAttribute("gradientTransform"):"pattern"==c.type?c.node.getAttribute("patternTransform"):
c.node.getAttribute("transform");if(!t)return new a.Matrix;t=d(t)}else t=a._.rgTransform.test(t)?J(t).replace(/\.{3}|\u2026/g,c._.transform||aa):d(t),y(t,"array")&&(t=a.path?a.path.toString.call(t):J(t)),c._.transform=t;var b=f(t,c.getBBox(1));if(m)return b;c.matrix=b}function u(c){c=c.node.ownerSVGElement&&x(c.node.ownerSVGElement)||c.node.parentNode&&x(c.node.parentNode)||a.select("svg")||a(0,0);var t=c.select("defs"),t=null==t?!1:t.node;t||(t=r("defs",c.node).node);return t}function p(c){return c.node.ownerSVGElement&&
x(c.node.ownerSVGElement)||a.select("svg")}function b(c,a,m){function b(c){if(null==c)return aa;if(c==+c)return c;v(B,{width:c});try{return B.getBBox().width}catch(a){return 0}}function h(c){if(null==c)return aa;if(c==+c)return c;v(B,{height:c});try{return B.getBBox().height}catch(a){return 0}}function e(b,B){null==a?d[b]=B(c.attr(b)||0):b==a&&(d=B(null==m?c.attr(b)||0:m))}var f=p(c).node,d={},B=f.querySelector(".svg---mgr");B||(B=v("rect"),v(B,{x:-9E9,y:-9E9,width:10,height:10,"class":"svg---mgr",
fill:"none"}),f.appendChild(B));switch(c.type){case "rect":e("rx",b),e("ry",h);case "image":e("width",b),e("height",h);case "text":e("x",b);e("y",h);break;case "circle":e("cx",b);e("cy",h);e("r",b);break;case "ellipse":e("cx",b);e("cy",h);e("rx",b);e("ry",h);break;case "line":e("x1",b);e("x2",b);e("y1",h);e("y2",h);break;case "marker":e("refX",b);e("markerWidth",b);e("refY",h);e("markerHeight",h);break;case "radialGradient":e("fx",b);e("fy",h);break;case "tspan":e("dx",b);e("dy",h);break;default:e(a,
b)}f.removeChild(B);return d}function q(c){y(c,"array")||(c=Array.prototype.slice.call(arguments,0));for(var a=0,b=0,m=this.node;this[a];)delete this[a++];for(a=0;a<c.length;a++)"set"==c[a].type?c[a].forEach(function(c){m.appendChild(c.node)}):m.appendChild(c[a].node);for(var h=m.childNodes,a=0;a<h.length;a++)this[b++]=x(h[a]);return this}function e(c){if(c.snap in E)return E[c.snap];var a=this.id=V(),b;try{b=c.ownerSVGElement}catch(m){}this.node=c;b&&(this.paper=new s(b));this.type=c.tagName;this.anims=
{};this._={transform:[]};c.snap=a;E[a]=this;"g"==this.type&&(this.add=q);if(this.type in{g:1,mask:1,pattern:1})for(var e in s.prototype)s.prototype[h](e)&&(this[e]=s.prototype[e])}function l(c){this.node=c}function r(c,a){var b=v(c);a.appendChild(b);return x(b)}function s(c,a){var b,m,f,d=s.prototype;if(c&&"svg"==c.tagName){if(c.snap in E)return E[c.snap];var l=c.ownerDocument;b=new e(c);m=c.getElementsByTagName("desc")[0];f=c.getElementsByTagName("defs")[0];m||(m=v("desc"),m.appendChild(l.createTextNode("Created with Snap")),
b.node.appendChild(m));f||(f=v("defs"),b.node.appendChild(f));b.defs=f;for(var ca in d)d[h](ca)&&(b[ca]=d[ca]);b.paper=b.root=b}else b=r("svg",G.doc.body),v(b.node,{height:a,version:1.1,width:c,xmlns:la});return b}function x(c){return!c||c instanceof e||c instanceof l?c:c.tagName&&"svg"==c.tagName.toLowerCase()?new s(c):c.tagName&&"object"==c.tagName.toLowerCase()&&"image/svg+xml"==c.type?new s(c.contentDocument.getElementsByTagName("svg")[0]):new e(c)}a.version="0.3.0";a.toString=function(){return"Snap v"+
this.version};a._={};var G={win:N,doc:N.document};a._.glob=G;var h="hasOwnProperty",J=String,K=parseFloat,U=parseInt,I=Math,P=I.max,Q=I.min,Y=I.abs,C=I.PI,aa="",$=Object.prototype.toString,F=/^\s*((#[a-f\d]{6})|(#[a-f\d]{3})|rgba?\(\s*([\d\.]+%?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+%?(?:\s*,\s*[\d\.]+%?)?)\s*\)|hsba?\(\s*([\d\.]+(?:deg|\xb0|%)?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+(?:%?\s*,\s*[\d\.]+)?%?)\s*\)|hsla?\(\s*([\d\.]+(?:deg|\xb0|%)?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+(?:%?\s*,\s*[\d\.]+)?%?)\s*\))\s*$/i;a._.separator=
RegExp("[,\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]+");var S=RegExp("[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*"),X={hs:1,rg:1},W=RegExp("([a-z])[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029,]*((-?\\d*\\.?\\d*(?:e[\\-+]?\\d+)?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*)+)",
"ig"),ma=RegExp("([rstm])[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029,]*((-?\\d*\\.?\\d*(?:e[\\-+]?\\d+)?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*)+)","ig"),Z=RegExp("(-?\\d*\\.?\\d*(?:e[\\-+]?\\d+)?)[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*",
"ig"),na=0,ba="S"+(+new Date).toString(36),V=function(){return ba+(na++).toString(36)},m="http://www.w3.org/1999/xlink",la="http://www.w3.org/2000/svg",E={},ca=a.url=function(c){return"url('#"+c+"')"};a._.$=v;a._.id=V;a.format=function(){var c=/\{([^\}]+)\}/g,a=/(?:(?:^|\.)(.+?)(?=\[|\.|$|\()|\[('|")(.+?)\2\])(\(\))?/g,b=function(c,b,m){var h=m;b.replace(a,function(c,a,b,m,t){a=a||m;h&&(a in h&&(h=h[a]),"function"==typeof h&&t&&(h=h()))});return h=(null==h||h==m?c:h)+""};return function(a,m){return J(a).replace(c,
function(c,a){return b(c,a,m)})}}();a._.clone=M;a._.cacher=A;a.rad=z;a.deg=function(c){return 180*c/C%360};a.angle=w;a.is=y;a.snapTo=function(c,a,b){b=y(b,"finite")?b:10;if(y(c,"array"))for(var m=c.length;m--;){if(Y(c[m]-a)<=b)return c[m]}else{c=+c;m=a%c;if(m<b)return a-m;if(m>c-b)return a-m+c}return a};a.getRGB=A(function(c){if(!c||(c=J(c)).indexOf("-")+1)return{r:-1,g:-1,b:-1,hex:"none",error:1,toString:ka};if("none"==c)return{r:-1,g:-1,b:-1,hex:"none",toString:ka};!X[h](c.toLowerCase().substring(0,
2))&&"#"!=c.charAt()&&(c=T(c));if(!c)return{r:-1,g:-1,b:-1,hex:"none",error:1,toString:ka};var b,m,e,f,d;if(c=c.match(F)){c[2]&&(e=U(c[2].substring(5),16),m=U(c[2].substring(3,5),16),b=U(c[2].substring(1,3),16));c[3]&&(e=U((d=c[3].charAt(3))+d,16),m=U((d=c[3].charAt(2))+d,16),b=U((d=c[3].charAt(1))+d,16));c[4]&&(d=c[4].split(S),b=K(d[0]),"%"==d[0].slice(-1)&&(b*=2.55),m=K(d[1]),"%"==d[1].slice(-1)&&(m*=2.55),e=K(d[2]),"%"==d[2].slice(-1)&&(e*=2.55),"rgba"==c[1].toLowerCase().slice(0,4)&&(f=K(d[3])),
d[3]&&"%"==d[3].slice(-1)&&(f/=100));if(c[5])return d=c[5].split(S),b=K(d[0]),"%"==d[0].slice(-1)&&(b/=100),m=K(d[1]),"%"==d[1].slice(-1)&&(m/=100),e=K(d[2]),"%"==d[2].slice(-1)&&(e/=100),"deg"!=d[0].slice(-3)&&"\u00b0"!=d[0].slice(-1)||(b/=360),"hsba"==c[1].toLowerCase().slice(0,4)&&(f=K(d[3])),d[3]&&"%"==d[3].slice(-1)&&(f/=100),a.hsb2rgb(b,m,e,f);if(c[6])return d=c[6].split(S),b=K(d[0]),"%"==d[0].slice(-1)&&(b/=100),m=K(d[1]),"%"==d[1].slice(-1)&&(m/=100),e=K(d[2]),"%"==d[2].slice(-1)&&(e/=100),
"deg"!=d[0].slice(-3)&&"\u00b0"!=d[0].slice(-1)||(b/=360),"hsla"==c[1].toLowerCase().slice(0,4)&&(f=K(d[3])),d[3]&&"%"==d[3].slice(-1)&&(f/=100),a.hsl2rgb(b,m,e,f);b=Q(I.round(b),255);m=Q(I.round(m),255);e=Q(I.round(e),255);f=Q(P(f,0),1);c={r:b,g:m,b:e,toString:ka};c.hex="#"+(16777216|e|m<<8|b<<16).toString(16).slice(1);c.opacity=y(f,"finite")?f:1;return c}return{r:-1,g:-1,b:-1,hex:"none",error:1,toString:ka}},a);a.hsb=A(function(c,b,m){return a.hsb2rgb(c,b,m).hex});a.hsl=A(function(c,b,m){return a.hsl2rgb(c,
b,m).hex});a.rgb=A(function(c,a,b,m){if(y(m,"finite")){var e=I.round;return"rgba("+[e(c),e(a),e(b),+m.toFixed(2)]+")"}return"#"+(16777216|b|a<<8|c<<16).toString(16).slice(1)});var T=function(c){var a=G.doc.getElementsByTagName("head")[0]||G.doc.getElementsByTagName("svg")[0];T=A(function(c){if("red"==c.toLowerCase())return"rgb(255, 0, 0)";a.style.color="rgb(255, 0, 0)";a.style.color=c;c=G.doc.defaultView.getComputedStyle(a,aa).getPropertyValue("color");return"rgb(255, 0, 0)"==c?null:c});return T(c)},
qa=function(){return"hsb("+[this.h,this.s,this.b]+")"},ra=function(){return"hsl("+[this.h,this.s,this.l]+")"},ka=function(){return 1==this.opacity||null==this.opacity?this.hex:"rgba("+[this.r,this.g,this.b,this.opacity]+")"},D=function(c,b,m){null==b&&y(c,"object")&&"r"in c&&"g"in c&&"b"in c&&(m=c.b,b=c.g,c=c.r);null==b&&y(c,string)&&(m=a.getRGB(c),c=m.r,b=m.g,m=m.b);if(1<c||1<b||1<m)c/=255,b/=255,m/=255;return[c,b,m]},oa=function(c,b,m,e){c=I.round(255*c);b=I.round(255*b);m=I.round(255*m);c={r:c,
g:b,b:m,opacity:y(e,"finite")?e:1,hex:a.rgb(c,b,m),toString:ka};y(e,"finite")&&(c.opacity=e);return c};a.color=function(c){var b;y(c,"object")&&"h"in c&&"s"in c&&"b"in c?(b=a.hsb2rgb(c),c.r=b.r,c.g=b.g,c.b=b.b,c.opacity=1,c.hex=b.hex):y(c,"object")&&"h"in c&&"s"in c&&"l"in c?(b=a.hsl2rgb(c),c.r=b.r,c.g=b.g,c.b=b.b,c.opacity=1,c.hex=b.hex):(y(c,"string")&&(c=a.getRGB(c)),y(c,"object")&&"r"in c&&"g"in c&&"b"in c&&!("error"in c)?(b=a.rgb2hsl(c),c.h=b.h,c.s=b.s,c.l=b.l,b=a.rgb2hsb(c),c.v=b.b):(c={hex:"none"},
c.r=c.g=c.b=c.h=c.s=c.v=c.l=-1,c.error=1));c.toString=ka;return c};a.hsb2rgb=function(c,a,b,m){y(c,"object")&&"h"in c&&"s"in c&&"b"in c&&(b=c.b,a=c.s,c=c.h,m=c.o);var e,h,d;c=360*c%360/60;d=b*a;a=d*(1-Y(c%2-1));b=e=h=b-d;c=~~c;b+=[d,a,0,0,a,d][c];e+=[a,d,d,a,0,0][c];h+=[0,0,a,d,d,a][c];return oa(b,e,h,m)};a.hsl2rgb=function(c,a,b,m){y(c,"object")&&"h"in c&&"s"in c&&"l"in c&&(b=c.l,a=c.s,c=c.h);if(1<c||1<a||1<b)c/=360,a/=100,b/=100;var e,h,d;c=360*c%360/60;d=2*a*(0.5>b?b:1-b);a=d*(1-Y(c%2-1));b=e=
h=b-d/2;c=~~c;b+=[d,a,0,0,a,d][c];e+=[a,d,d,a,0,0][c];h+=[0,0,a,d,d,a][c];return oa(b,e,h,m)};a.rgb2hsb=function(c,a,b){b=D(c,a,b);c=b[0];a=b[1];b=b[2];var m,e;m=P(c,a,b);e=m-Q(c,a,b);c=((0==e?0:m==c?(a-b)/e:m==a?(b-c)/e+2:(c-a)/e+4)+360)%6*60/360;return{h:c,s:0==e?0:e/m,b:m,toString:qa}};a.rgb2hsl=function(c,a,b){b=D(c,a,b);c=b[0];a=b[1];b=b[2];var m,e,h;m=P(c,a,b);e=Q(c,a,b);h=m-e;c=((0==h?0:m==c?(a-b)/h:m==a?(b-c)/h+2:(c-a)/h+4)+360)%6*60/360;m=(m+e)/2;return{h:c,s:0==h?0:0.5>m?h/(2*m):h/(2-2*
m),l:m,toString:ra}};a.parsePathString=function(c){if(!c)return null;var b=a.path(c);if(b.arr)return a.path.clone(b.arr);var m={a:7,c:6,o:2,h:1,l:2,m:2,r:4,q:4,s:4,t:2,v:1,u:3,z:0},e=[];y(c,"array")&&y(c[0],"array")&&(e=a.path.clone(c));e.length||J(c).replace(W,function(c,a,b){var h=[];c=a.toLowerCase();b.replace(Z,function(c,a){a&&h.push(+a)});"m"==c&&2<h.length&&(e.push([a].concat(h.splice(0,2))),c="l",a="m"==a?"l":"L");"o"==c&&1==h.length&&e.push([a,h[0] ]);if("r"==c)e.push([a].concat(h));else for(;h.length>=
m[c]&&(e.push([a].concat(h.splice(0,m[c]))),m[c]););});e.toString=a.path.toString;b.arr=a.path.clone(e);return e};var O=a.parseTransformString=function(c){if(!c)return null;var b=[];y(c,"array")&&y(c[0],"array")&&(b=a.path.clone(c));b.length||J(c).replace(ma,function(c,a,m){var e=[];a.toLowerCase();m.replace(Z,function(c,a){a&&e.push(+a)});b.push([a].concat(e))});b.toString=a.path.toString;return b};a._.svgTransform2string=d;a._.rgTransform=RegExp("^[a-z][\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*-?\\.?\\d",
"i");a._.transform2matrix=f;a._unit2px=b;a._.getSomeDefs=u;a._.getSomeSVG=p;a.select=function(c){return x(G.doc.querySelector(c))};a.selectAll=function(c){c=G.doc.querySelectorAll(c);for(var b=(a.set||Array)(),m=0;m<c.length;m++)b.push(x(c[m]));return b};setInterval(function(){for(var c in E)if(E[h](c)){var a=E[c],b=a.node;("svg"!=a.type&&!b.ownerSVGElement||"svg"==a.type&&(!b.parentNode||"ownerSVGElement"in b.parentNode&&!b.ownerSVGElement))&&delete E[c]}},1E4);(function(c){function m(c){function a(c,
b){var m=v(c.node,b);(m=(m=m&&m.match(d))&&m[2])&&"#"==m.charAt()&&(m=m.substring(1))&&(f[m]=(f[m]||[]).concat(function(a){var m={};m[b]=ca(a);v(c.node,m)}))}function b(c){var a=v(c.node,"xlink:href");a&&"#"==a.charAt()&&(a=a.substring(1))&&(f[a]=(f[a]||[]).concat(function(a){c.attr("xlink:href","#"+a)}))}var e=c.selectAll("*"),h,d=/^\s*url\(("|'|)(.*)\1\)\s*$/;c=[];for(var f={},l=0,E=e.length;l<E;l++){h=e[l];a(h,"fill");a(h,"stroke");a(h,"filter");a(h,"mask");a(h,"clip-path");b(h);var t=v(h.node,
"id");t&&(v(h.node,{id:h.id}),c.push({old:t,id:h.id}))}l=0;for(E=c.length;l<E;l++)if(e=f[c[l].old])for(h=0,t=e.length;h<t;h++)e[h](c[l].id)}function e(c,a,b){return function(m){m=m.slice(c,a);1==m.length&&(m=m[0]);return b?b(m):m}}function d(c){return function(){var a=c?"<"+this.type:"",b=this.node.attributes,m=this.node.childNodes;if(c)for(var e=0,h=b.length;e<h;e++)a+=" "+b[e].name+'="'+b[e].value.replace(/"/g,'\\"')+'"';if(m.length){c&&(a+=">");e=0;for(h=m.length;e<h;e++)3==m[e].nodeType?a+=m[e].nodeValue:
1==m[e].nodeType&&(a+=x(m[e]).toString());c&&(a+="</"+this.type+">")}else c&&(a+="/>");return a}}c.attr=function(c,a){if(!c)return this;if(y(c,"string"))if(1<arguments.length){var b={};b[c]=a;c=b}else return k("snap.util.getattr."+c,this).firstDefined();for(var m in c)c[h](m)&&k("snap.util.attr."+m,this,c[m]);return this};c.getBBox=function(c){if(!a.Matrix||!a.path)return this.node.getBBox();var b=this,m=new a.Matrix;if(b.removed)return a._.box();for(;"use"==b.type;)if(c||(m=m.add(b.transform().localMatrix.translate(b.attr("x")||
0,b.attr("y")||0))),b.original)b=b.original;else var e=b.attr("xlink:href"),b=b.original=b.node.ownerDocument.getElementById(e.substring(e.indexOf("#")+1));var e=b._,h=a.path.get[b.type]||a.path.get.deflt;try{if(c)return e.bboxwt=h?a.path.getBBox(b.realPath=h(b)):a._.box(b.node.getBBox()),a._.box(e.bboxwt);b.realPath=h(b);b.matrix=b.transform().localMatrix;e.bbox=a.path.getBBox(a.path.map(b.realPath,m.add(b.matrix)));return a._.box(e.bbox)}catch(d){return a._.box()}};var f=function(){return this.string};
c.transform=function(c){var b=this._;if(null==c){var m=this;c=new a.Matrix(this.node.getCTM());for(var e=n(this),h=[e],d=new a.Matrix,l=e.toTransformString(),b=J(e)==J(this.matrix)?J(b.transform):l;"svg"!=m.type&&(m=m.parent());)h.push(n(m));for(m=h.length;m--;)d.add(h[m]);return{string:b,globalMatrix:c,totalMatrix:d,localMatrix:e,diffMatrix:c.clone().add(e.invert()),global:c.toTransformString(),total:d.toTransformString(),local:l,toString:f}}c instanceof a.Matrix?this.matrix=c:n(this,c);this.node&&
("linearGradient"==this.type||"radialGradient"==this.type?v(this.node,{gradientTransform:this.matrix}):"pattern"==this.type?v(this.node,{patternTransform:this.matrix}):v(this.node,{transform:this.matrix}));return this};c.parent=function(){return x(this.node.parentNode)};c.append=c.add=function(c){if(c){if("set"==c.type){var a=this;c.forEach(function(c){a.add(c)});return this}c=x(c);this.node.appendChild(c.node);c.paper=this.paper}return this};c.appendTo=function(c){c&&(c=x(c),c.append(this));return this};
c.prepend=function(c){if(c){if("set"==c.type){var a=this,b;c.forEach(function(c){b?b.after(c):a.prepend(c);b=c});return this}c=x(c);var m=c.parent();this.node.insertBefore(c.node,this.node.firstChild);this.add&&this.add();c.paper=this.paper;this.parent()&&this.parent().add();m&&m.add()}return this};c.prependTo=function(c){c=x(c);c.prepend(this);return this};c.before=function(c){if("set"==c.type){var a=this;c.forEach(function(c){var b=c.parent();a.node.parentNode.insertBefore(c.node,a.node);b&&b.add()});
this.parent().add();return this}c=x(c);var b=c.parent();this.node.parentNode.insertBefore(c.node,this.node);this.parent()&&this.parent().add();b&&b.add();c.paper=this.paper;return this};c.after=function(c){c=x(c);var a=c.parent();this.node.nextSibling?this.node.parentNode.insertBefore(c.node,this.node.nextSibling):this.node.parentNode.appendChild(c.node);this.parent()&&this.parent().add();a&&a.add();c.paper=this.paper;return this};c.insertBefore=function(c){c=x(c);var a=this.parent();c.node.parentNode.insertBefore(this.node,
c.node);this.paper=c.paper;a&&a.add();c.parent()&&c.parent().add();return this};c.insertAfter=function(c){c=x(c);var a=this.parent();c.node.parentNode.insertBefore(this.node,c.node.nextSibling);this.paper=c.paper;a&&a.add();c.parent()&&c.parent().add();return this};c.remove=function(){var c=this.parent();this.node.parentNode&&this.node.parentNode.removeChild(this.node);delete this.paper;this.removed=!0;c&&c.add();return this};c.select=function(c){return x(this.node.querySelector(c))};c.selectAll=
function(c){c=this.node.querySelectorAll(c);for(var b=(a.set||Array)(),m=0;m<c.length;m++)b.push(x(c[m]));return b};c.asPX=function(c,a){null==a&&(a=this.attr(c));return+b(this,c,a)};c.use=function(){var c,a=this.node.id;a||(a=this.id,v(this.node,{id:a}));c="linearGradient"==this.type||"radialGradient"==this.type||"pattern"==this.type?r(this.type,this.node.parentNode):r("use",this.node.parentNode);v(c.node,{"xlink:href":"#"+a});c.original=this;return c};var l=/\S+/g;c.addClass=function(c){var a=(c||
"").match(l)||[];c=this.node;var b=c.className.baseVal,m=b.match(l)||[],e,h,d;if(a.length){for(e=0;d=a[e++];)h=m.indexOf(d),~h||m.push(d);a=m.join(" ");b!=a&&(c.className.baseVal=a)}return this};c.removeClass=function(c){var a=(c||"").match(l)||[];c=this.node;var b=c.className.baseVal,m=b.match(l)||[],e,h;if(m.length){for(e=0;h=a[e++];)h=m.indexOf(h),~h&&m.splice(h,1);a=m.join(" ");b!=a&&(c.className.baseVal=a)}return this};c.hasClass=function(c){return!!~(this.node.className.baseVal.match(l)||[]).indexOf(c)};
c.toggleClass=function(c,a){if(null!=a)return a?this.addClass(c):this.removeClass(c);var b=(c||"").match(l)||[],m=this.node,e=m.className.baseVal,h=e.match(l)||[],d,f,E;for(d=0;E=b[d++];)f=h.indexOf(E),~f?h.splice(f,1):h.push(E);b=h.join(" ");e!=b&&(m.className.baseVal=b);return this};c.clone=function(){var c=x(this.node.cloneNode(!0));v(c.node,"id")&&v(c.node,{id:c.id});m(c);c.insertAfter(this);return c};c.toDefs=function(){u(this).appendChild(this.node);return this};c.pattern=c.toPattern=function(c,
a,b,m){var e=r("pattern",u(this));null==c&&(c=this.getBBox());y(c,"object")&&"x"in c&&(a=c.y,b=c.width,m=c.height,c=c.x);v(e.node,{x:c,y:a,width:b,height:m,patternUnits:"userSpaceOnUse",id:e.id,viewBox:[c,a,b,m].join(" ")});e.node.appendChild(this.node);return e};c.marker=function(c,a,b,m,e,h){var d=r("marker",u(this));null==c&&(c=this.getBBox());y(c,"object")&&"x"in c&&(a=c.y,b=c.width,m=c.height,e=c.refX||c.cx,h=c.refY||c.cy,c=c.x);v(d.node,{viewBox:[c,a,b,m].join(" "),markerWidth:b,markerHeight:m,
orient:"auto",refX:e||0,refY:h||0,id:d.id});d.node.appendChild(this.node);return d};var E=function(c,a,b,m){"function"!=typeof b||b.length||(m=b,b=L.linear);this.attr=c;this.dur=a;b&&(this.easing=b);m&&(this.callback=m)};a._.Animation=E;a.animation=function(c,a,b,m){return new E(c,a,b,m)};c.inAnim=function(){var c=[],a;for(a in this.anims)this.anims[h](a)&&function(a){c.push({anim:new E(a._attrs,a.dur,a.easing,a._callback),mina:a,curStatus:a.status(),status:function(c){return a.status(c)},stop:function(){a.stop()}})}(this.anims[a]);
return c};a.animate=function(c,a,b,m,e,h){"function"!=typeof e||e.length||(h=e,e=L.linear);var d=L.time();c=L(c,a,d,d+m,L.time,b,e);h&&k.once("mina.finish."+c.id,h);return c};c.stop=function(){for(var c=this.inAnim(),a=0,b=c.length;a<b;a++)c[a].stop();return this};c.animate=function(c,a,b,m){"function"!=typeof b||b.length||(m=b,b=L.linear);c instanceof E&&(m=c.callback,b=c.easing,a=b.dur,c=c.attr);var d=[],f=[],l={},t,ca,n,T=this,q;for(q in c)if(c[h](q)){T.equal?(n=T.equal(q,J(c[q])),t=n.from,ca=
n.to,n=n.f):(t=+T.attr(q),ca=+c[q]);var la=y(t,"array")?t.length:1;l[q]=e(d.length,d.length+la,n);d=d.concat(t);f=f.concat(ca)}t=L.time();var p=L(d,f,t,t+a,L.time,function(c){var a={},b;for(b in l)l[h](b)&&(a[b]=l[b](c));T.attr(a)},b);T.anims[p.id]=p;p._attrs=c;p._callback=m;k("snap.animcreated."+T.id,p);k.once("mina.finish."+p.id,function(){delete T.anims[p.id];m&&m.call(T)});k.once("mina.stop."+p.id,function(){delete T.anims[p.id]});return T};var T={};c.data=function(c,b){var m=T[this.id]=T[this.id]||
{};if(0==arguments.length)return k("snap.data.get."+this.id,this,m,null),m;if(1==arguments.length){if(a.is(c,"object")){for(var e in c)c[h](e)&&this.data(e,c[e]);return this}k("snap.data.get."+this.id,this,m[c],c);return m[c]}m[c]=b;k("snap.data.set."+this.id,this,b,c);return this};c.removeData=function(c){null==c?T[this.id]={}:T[this.id]&&delete T[this.id][c];return this};c.outerSVG=c.toString=d(1);c.innerSVG=d()})(e.prototype);a.parse=function(c){var a=G.doc.createDocumentFragment(),b=!0,m=G.doc.createElement("div");
c=J(c);c.match(/^\s*<\s*svg(?:\s|>)/)||(c="<svg>"+c+"</svg>",b=!1);m.innerHTML=c;if(c=m.getElementsByTagName("svg")[0])if(b)a=c;else for(;c.firstChild;)a.appendChild(c.firstChild);m.innerHTML=aa;return new l(a)};l.prototype.select=e.prototype.select;l.prototype.selectAll=e.prototype.selectAll;a.fragment=function(){for(var c=Array.prototype.slice.call(arguments,0),b=G.doc.createDocumentFragment(),m=0,e=c.length;m<e;m++){var h=c[m];h.node&&h.node.nodeType&&b.appendChild(h.node);h.nodeType&&b.appendChild(h);
"string"==typeof h&&b.appendChild(a.parse(h).node)}return new l(b)};a._.make=r;a._.wrap=x;s.prototype.el=function(c,a){var b=r(c,this.node);a&&b.attr(a);return b};k.on("snap.util.getattr",function(){var c=k.nt(),c=c.substring(c.lastIndexOf(".")+1),a=c.replace(/[A-Z]/g,function(c){return"-"+c.toLowerCase()});return pa[h](a)?this.node.ownerDocument.defaultView.getComputedStyle(this.node,null).getPropertyValue(a):v(this.node,c)});var pa={"alignment-baseline":0,"baseline-shift":0,clip:0,"clip-path":0,
"clip-rule":0,color:0,"color-interpolation":0,"color-interpolation-filters":0,"color-profile":0,"color-rendering":0,cursor:0,direction:0,display:0,"dominant-baseline":0,"enable-background":0,fill:0,"fill-opacity":0,"fill-rule":0,filter:0,"flood-color":0,"flood-opacity":0,font:0,"font-family":0,"font-size":0,"font-size-adjust":0,"font-stretch":0,"font-style":0,"font-variant":0,"font-weight":0,"glyph-orientation-horizontal":0,"glyph-orientation-vertical":0,"image-rendering":0,kerning:0,"letter-spacing":0,
"lighting-color":0,marker:0,"marker-end":0,"marker-mid":0,"marker-start":0,mask:0,opacity:0,overflow:0,"pointer-events":0,"shape-rendering":0,"stop-color":0,"stop-opacity":0,stroke:0,"stroke-dasharray":0,"stroke-dashoffset":0,"stroke-linecap":0,"stroke-linejoin":0,"stroke-miterlimit":0,"stroke-opacity":0,"stroke-width":0,"text-anchor":0,"text-decoration":0,"text-rendering":0,"unicode-bidi":0,visibility:0,"word-spacing":0,"writing-mode":0};k.on("snap.util.attr",function(c){var a=k.nt(),b={},a=a.substring(a.lastIndexOf(".")+
1);b[a]=c;var m=a.replace(/-(\w)/gi,function(c,a){return a.toUpperCase()}),a=a.replace(/[A-Z]/g,function(c){return"-"+c.toLowerCase()});pa[h](a)?this.node.style[m]=null==c?aa:c:v(this.node,b)});a.ajax=function(c,a,b,m){var e=new XMLHttpRequest,h=V();if(e){if(y(a,"function"))m=b,b=a,a=null;else if(y(a,"object")){var d=[],f;for(f in a)a.hasOwnProperty(f)&&d.push(encodeURIComponent(f)+"="+encodeURIComponent(a[f]));a=d.join("&")}e.open(a?"POST":"GET",c,!0);a&&(e.setRequestHeader("X-Requested-With","XMLHttpRequest"),
e.setRequestHeader("Content-type","application/x-www-form-urlencoded"));b&&(k.once("snap.ajax."+h+".0",b),k.once("snap.ajax."+h+".200",b),k.once("snap.ajax."+h+".304",b));e.onreadystatechange=function(){4==e.readyState&&k("snap.ajax."+h+"."+e.status,m,e)};if(4==e.readyState)return e;e.send(a);return e}};a.load=function(c,b,m){a.ajax(c,function(c){c=a.parse(c.responseText);m?b.call(m,c):b(c)})};a.getElementByPoint=function(c,a){var b,m,e=G.doc.elementFromPoint(c,a);if(G.win.opera&&"svg"==e.tagName){b=
e;m=b.getBoundingClientRect();b=b.ownerDocument;var h=b.body,d=b.documentElement;b=m.top+(g.win.pageYOffset||d.scrollTop||h.scrollTop)-(d.clientTop||h.clientTop||0);m=m.left+(g.win.pageXOffset||d.scrollLeft||h.scrollLeft)-(d.clientLeft||h.clientLeft||0);h=e.createSVGRect();h.x=c-m;h.y=a-b;h.width=h.height=1;b=e.getIntersectionList(h,null);b.length&&(e=b[b.length-1])}return e?x(e):null};a.plugin=function(c){c(a,e,s,G,l)};return G.win.Snap=a}();C.plugin(function(a,k,y,M,A){function w(a,d,f,b,q,e){null==
d&&"[object SVGMatrix]"==z.call(a)?(this.a=a.a,this.b=a.b,this.c=a.c,this.d=a.d,this.e=a.e,this.f=a.f):null!=a?(this.a=+a,this.b=+d,this.c=+f,this.d=+b,this.e=+q,this.f=+e):(this.a=1,this.c=this.b=0,this.d=1,this.f=this.e=0)}var z=Object.prototype.toString,d=String,f=Math;(function(n){function k(a){return a[0]*a[0]+a[1]*a[1]}function p(a){var d=f.sqrt(k(a));a[0]&&(a[0]/=d);a[1]&&(a[1]/=d)}n.add=function(a,d,e,f,n,p){var k=[[],[],[] ],u=[[this.a,this.c,this.e],[this.b,this.d,this.f],[0,0,1] ];d=[[a,
e,n],[d,f,p],[0,0,1] ];a&&a instanceof w&&(d=[[a.a,a.c,a.e],[a.b,a.d,a.f],[0,0,1] ]);for(a=0;3>a;a++)for(e=0;3>e;e++){for(f=n=0;3>f;f++)n+=u[a][f]*d[f][e];k[a][e]=n}this.a=k[0][0];this.b=k[1][0];this.c=k[0][1];this.d=k[1][1];this.e=k[0][2];this.f=k[1][2];return this};n.invert=function(){var a=this.a*this.d-this.b*this.c;return new w(this.d/a,-this.b/a,-this.c/a,this.a/a,(this.c*this.f-this.d*this.e)/a,(this.b*this.e-this.a*this.f)/a)};n.clone=function(){return new w(this.a,this.b,this.c,this.d,this.e,
this.f)};n.translate=function(a,d){return this.add(1,0,0,1,a,d)};n.scale=function(a,d,e,f){null==d&&(d=a);(e||f)&&this.add(1,0,0,1,e,f);this.add(a,0,0,d,0,0);(e||f)&&this.add(1,0,0,1,-e,-f);return this};n.rotate=function(b,d,e){b=a.rad(b);d=d||0;e=e||0;var l=+f.cos(b).toFixed(9);b=+f.sin(b).toFixed(9);this.add(l,b,-b,l,d,e);return this.add(1,0,0,1,-d,-e)};n.x=function(a,d){return a*this.a+d*this.c+this.e};n.y=function(a,d){return a*this.b+d*this.d+this.f};n.get=function(a){return+this[d.fromCharCode(97+
a)].toFixed(4)};n.toString=function(){return"matrix("+[this.get(0),this.get(1),this.get(2),this.get(3),this.get(4),this.get(5)].join()+")"};n.offset=function(){return[this.e.toFixed(4),this.f.toFixed(4)]};n.determinant=function(){return this.a*this.d-this.b*this.c};n.split=function(){var b={};b.dx=this.e;b.dy=this.f;var d=[[this.a,this.c],[this.b,this.d] ];b.scalex=f.sqrt(k(d[0]));p(d[0]);b.shear=d[0][0]*d[1][0]+d[0][1]*d[1][1];d[1]=[d[1][0]-d[0][0]*b.shear,d[1][1]-d[0][1]*b.shear];b.scaley=f.sqrt(k(d[1]));
p(d[1]);b.shear/=b.scaley;0>this.determinant()&&(b.scalex=-b.scalex);var e=-d[0][1],d=d[1][1];0>d?(b.rotate=a.deg(f.acos(d)),0>e&&(b.rotate=360-b.rotate)):b.rotate=a.deg(f.asin(e));b.isSimple=!+b.shear.toFixed(9)&&(b.scalex.toFixed(9)==b.scaley.toFixed(9)||!b.rotate);b.isSuperSimple=!+b.shear.toFixed(9)&&b.scalex.toFixed(9)==b.scaley.toFixed(9)&&!b.rotate;b.noRotation=!+b.shear.toFixed(9)&&!b.rotate;return b};n.toTransformString=function(a){a=a||this.split();if(+a.shear.toFixed(9))return"m"+[this.get(0),
this.get(1),this.get(2),this.get(3),this.get(4),this.get(5)];a.scalex=+a.scalex.toFixed(4);a.scaley=+a.scaley.toFixed(4);a.rotate=+a.rotate.toFixed(4);return(a.dx||a.dy?"t"+[+a.dx.toFixed(4),+a.dy.toFixed(4)]:"")+(1!=a.scalex||1!=a.scaley?"s"+[a.scalex,a.scaley,0,0]:"")+(a.rotate?"r"+[+a.rotate.toFixed(4),0,0]:"")}})(w.prototype);a.Matrix=w;a.matrix=function(a,d,f,b,k,e){return new w(a,d,f,b,k,e)}});C.plugin(function(a,v,y,M,A){function w(h){return function(d){k.stop();d instanceof A&&1==d.node.childNodes.length&&
("radialGradient"==d.node.firstChild.tagName||"linearGradient"==d.node.firstChild.tagName||"pattern"==d.node.firstChild.tagName)&&(d=d.node.firstChild,b(this).appendChild(d),d=u(d));if(d instanceof v)if("radialGradient"==d.type||"linearGradient"==d.type||"pattern"==d.type){d.node.id||e(d.node,{id:d.id});var f=l(d.node.id)}else f=d.attr(h);else f=a.color(d),f.error?(f=a(b(this).ownerSVGElement).gradient(d))?(f.node.id||e(f.node,{id:f.id}),f=l(f.node.id)):f=d:f=r(f);d={};d[h]=f;e(this.node,d);this.node.style[h]=
x}}function z(a){k.stop();a==+a&&(a+="px");this.node.style.fontSize=a}function d(a){var b=[];a=a.childNodes;for(var e=0,f=a.length;e<f;e++){var l=a[e];3==l.nodeType&&b.push(l.nodeValue);"tspan"==l.tagName&&(1==l.childNodes.length&&3==l.firstChild.nodeType?b.push(l.firstChild.nodeValue):b.push(d(l)))}return b}function f(){k.stop();return this.node.style.fontSize}var n=a._.make,u=a._.wrap,p=a.is,b=a._.getSomeDefs,q=/^url\(#?([^)]+)\)$/,e=a._.$,l=a.url,r=String,s=a._.separator,x="";k.on("snap.util.attr.mask",
function(a){if(a instanceof v||a instanceof A){k.stop();a instanceof A&&1==a.node.childNodes.length&&(a=a.node.firstChild,b(this).appendChild(a),a=u(a));if("mask"==a.type)var d=a;else d=n("mask",b(this)),d.node.appendChild(a.node);!d.node.id&&e(d.node,{id:d.id});e(this.node,{mask:l(d.id)})}});(function(a){k.on("snap.util.attr.clip",a);k.on("snap.util.attr.clip-path",a);k.on("snap.util.attr.clipPath",a)})(function(a){if(a instanceof v||a instanceof A){k.stop();if("clipPath"==a.type)var d=a;else d=
n("clipPath",b(this)),d.node.appendChild(a.node),!d.node.id&&e(d.node,{id:d.id});e(this.node,{"clip-path":l(d.id)})}});k.on("snap.util.attr.fill",w("fill"));k.on("snap.util.attr.stroke",w("stroke"));var G=/^([lr])(?:\(([^)]*)\))?(.*)$/i;k.on("snap.util.grad.parse",function(a){a=r(a);var b=a.match(G);if(!b)return null;a=b[1];var e=b[2],b=b[3],e=e.split(/\s*,\s*/).map(function(a){return+a==a?+a:a});1==e.length&&0==e[0]&&(e=[]);b=b.split("-");b=b.map(function(a){a=a.split(":");var b={color:a[0]};a[1]&&
(b.offset=parseFloat(a[1]));return b});return{type:a,params:e,stops:b}});k.on("snap.util.attr.d",function(b){k.stop();p(b,"array")&&p(b[0],"array")&&(b=a.path.toString.call(b));b=r(b);b.match(/[ruo]/i)&&(b=a.path.toAbsolute(b));e(this.node,{d:b})})(-1);k.on("snap.util.attr.#text",function(a){k.stop();a=r(a);for(a=M.doc.createTextNode(a);this.node.firstChild;)this.node.removeChild(this.node.firstChild);this.node.appendChild(a)})(-1);k.on("snap.util.attr.path",function(a){k.stop();this.attr({d:a})})(-1);
k.on("snap.util.attr.class",function(a){k.stop();this.node.className.baseVal=a})(-1);k.on("snap.util.attr.viewBox",function(a){a=p(a,"object")&&"x"in a?[a.x,a.y,a.width,a.height].join(" "):p(a,"array")?a.join(" "):a;e(this.node,{viewBox:a});k.stop()})(-1);k.on("snap.util.attr.transform",function(a){this.transform(a);k.stop()})(-1);k.on("snap.util.attr.r",function(a){"rect"==this.type&&(k.stop(),e(this.node,{rx:a,ry:a}))})(-1);k.on("snap.util.attr.textpath",function(a){k.stop();if("text"==this.type){var d,
f;if(!a&&this.textPath){for(a=this.textPath;a.node.firstChild;)this.node.appendChild(a.node.firstChild);a.remove();delete this.textPath}else if(p(a,"string")?(d=b(this),a=u(d.parentNode).path(a),d.appendChild(a.node),d=a.id,a.attr({id:d})):(a=u(a),a instanceof v&&(d=a.attr("id"),d||(d=a.id,a.attr({id:d})))),d)if(a=this.textPath,f=this.node,a)a.attr({"xlink:href":"#"+d});else{for(a=e("textPath",{"xlink:href":"#"+d});f.firstChild;)a.appendChild(f.firstChild);f.appendChild(a);this.textPath=u(a)}}})(-1);
k.on("snap.util.attr.text",function(a){if("text"==this.type){for(var b=this.node,d=function(a){var b=e("tspan");if(p(a,"array"))for(var f=0;f<a.length;f++)b.appendChild(d(a[f]));else b.appendChild(M.doc.createTextNode(a));b.normalize&&b.normalize();return b};b.firstChild;)b.removeChild(b.firstChild);for(a=d(a);a.firstChild;)b.appendChild(a.firstChild)}k.stop()})(-1);k.on("snap.util.attr.fontSize",z)(-1);k.on("snap.util.attr.font-size",z)(-1);k.on("snap.util.getattr.transform",function(){k.stop();
return this.transform()})(-1);k.on("snap.util.getattr.textpath",function(){k.stop();return this.textPath})(-1);(function(){function b(d){return function(){k.stop();var b=M.doc.defaultView.getComputedStyle(this.node,null).getPropertyValue("marker-"+d);return"none"==b?b:a(M.doc.getElementById(b.match(q)[1]))}}function d(a){return function(b){k.stop();var d="marker"+a.charAt(0).toUpperCase()+a.substring(1);if(""==b||!b)this.node.style[d]="none";else if("marker"==b.type){var f=b.node.id;f||e(b.node,{id:b.id});
this.node.style[d]=l(f)}}}k.on("snap.util.getattr.marker-end",b("end"))(-1);k.on("snap.util.getattr.markerEnd",b("end"))(-1);k.on("snap.util.getattr.marker-start",b("start"))(-1);k.on("snap.util.getattr.markerStart",b("start"))(-1);k.on("snap.util.getattr.marker-mid",b("mid"))(-1);k.on("snap.util.getattr.markerMid",b("mid"))(-1);k.on("snap.util.attr.marker-end",d("end"))(-1);k.on("snap.util.attr.markerEnd",d("end"))(-1);k.on("snap.util.attr.marker-start",d("start"))(-1);k.on("snap.util.attr.markerStart",
d("start"))(-1);k.on("snap.util.attr.marker-mid",d("mid"))(-1);k.on("snap.util.attr.markerMid",d("mid"))(-1)})();k.on("snap.util.getattr.r",function(){if("rect"==this.type&&e(this.node,"rx")==e(this.node,"ry"))return k.stop(),e(this.node,"rx")})(-1);k.on("snap.util.getattr.text",function(){if("text"==this.type||"tspan"==this.type){k.stop();var a=d(this.node);return 1==a.length?a[0]:a}})(-1);k.on("snap.util.getattr.#text",function(){return this.node.textContent})(-1);k.on("snap.util.getattr.viewBox",
function(){k.stop();var b=e(this.node,"viewBox");if(b)return b=b.split(s),a._.box(+b[0],+b[1],+b[2],+b[3])})(-1);k.on("snap.util.getattr.points",function(){var a=e(this.node,"points");k.stop();if(a)return a.split(s)})(-1);k.on("snap.util.getattr.path",function(){var a=e(this.node,"d");k.stop();return a})(-1);k.on("snap.util.getattr.class",function(){return this.node.className.baseVal})(-1);k.on("snap.util.getattr.fontSize",f)(-1);k.on("snap.util.getattr.font-size",f)(-1)});C.plugin(function(a,v,y,
M,A){function w(a){return a}function z(a){return function(b){return+b.toFixed(3)+a}}var d={"+":function(a,b){return a+b},"-":function(a,b){return a-b},"/":function(a,b){return a/b},"*":function(a,b){return a*b}},f=String,n=/[a-z]+$/i,u=/^\s*([+\-\/*])\s*=\s*([\d.eE+\-]+)\s*([^\d\s]+)?\s*$/;k.on("snap.util.attr",function(a){if(a=f(a).match(u)){var b=k.nt(),b=b.substring(b.lastIndexOf(".")+1),q=this.attr(b),e={};k.stop();var l=a[3]||"",r=q.match(n),s=d[a[1] ];r&&r==l?a=s(parseFloat(q),+a[2]):(q=this.asPX(b),
a=s(this.asPX(b),this.asPX(b,a[2]+l)));isNaN(q)||isNaN(a)||(e[b]=a,this.attr(e))}})(-10);k.on("snap.util.equal",function(a,b){var q=f(this.attr(a)||""),e=f(b).match(u);if(e){k.stop();var l=e[3]||"",r=q.match(n),s=d[e[1] ];if(r&&r==l)return{from:parseFloat(q),to:s(parseFloat(q),+e[2]),f:z(r)};q=this.asPX(a);return{from:q,to:s(q,this.asPX(a,e[2]+l)),f:w}}})(-10)});C.plugin(function(a,v,y,M,A){var w=y.prototype,z=a.is;w.rect=function(a,d,k,p,b,q){var e;null==q&&(q=b);z(a,"object")&&"[object Object]"==
a?e=a:null!=a&&(e={x:a,y:d,width:k,height:p},null!=b&&(e.rx=b,e.ry=q));return this.el("rect",e)};w.circle=function(a,d,k){var p;z(a,"object")&&"[object Object]"==a?p=a:null!=a&&(p={cx:a,cy:d,r:k});return this.el("circle",p)};var d=function(){function a(){this.parentNode.removeChild(this)}return function(d,k){var p=M.doc.createElement("img"),b=M.doc.body;p.style.cssText="position:absolute;left:-9999em;top:-9999em";p.onload=function(){k.call(p);p.onload=p.onerror=null;b.removeChild(p)};p.onerror=a;
b.appendChild(p);p.src=d}}();w.image=function(f,n,k,p,b){var q=this.el("image");if(z(f,"object")&&"src"in f)q.attr(f);else if(null!=f){var e={"xlink:href":f,preserveAspectRatio:"none"};null!=n&&null!=k&&(e.x=n,e.y=k);null!=p&&null!=b?(e.width=p,e.height=b):d(f,function(){a._.$(q.node,{width:this.offsetWidth,height:this.offsetHeight})});a._.$(q.node,e)}return q};w.ellipse=function(a,d,k,p){var b;z(a,"object")&&"[object Object]"==a?b=a:null!=a&&(b={cx:a,cy:d,rx:k,ry:p});return this.el("ellipse",b)};
w.path=function(a){var d;z(a,"object")&&!z(a,"array")?d=a:a&&(d={d:a});return this.el("path",d)};w.group=w.g=function(a){var d=this.el("g");1==arguments.length&&a&&!a.type?d.attr(a):arguments.length&&d.add(Array.prototype.slice.call(arguments,0));return d};w.svg=function(a,d,k,p,b,q,e,l){var r={};z(a,"object")&&null==d?r=a:(null!=a&&(r.x=a),null!=d&&(r.y=d),null!=k&&(r.width=k),null!=p&&(r.height=p),null!=b&&null!=q&&null!=e&&null!=l&&(r.viewBox=[b,q,e,l]));return this.el("svg",r)};w.mask=function(a){var d=
this.el("mask");1==arguments.length&&a&&!a.type?d.attr(a):arguments.length&&d.add(Array.prototype.slice.call(arguments,0));return d};w.ptrn=function(a,d,k,p,b,q,e,l){if(z(a,"object"))var r=a;else arguments.length?(r={},null!=a&&(r.x=a),null!=d&&(r.y=d),null!=k&&(r.width=k),null!=p&&(r.height=p),null!=b&&null!=q&&null!=e&&null!=l&&(r.viewBox=[b,q,e,l])):r={patternUnits:"userSpaceOnUse"};return this.el("pattern",r)};w.use=function(a){return null!=a?(make("use",this.node),a instanceof v&&(a.attr("id")||
a.attr({id:ID()}),a=a.attr("id")),this.el("use",{"xlink:href":a})):v.prototype.use.call(this)};w.text=function(a,d,k){var p={};z(a,"object")?p=a:null!=a&&(p={x:a,y:d,text:k||""});return this.el("text",p)};w.line=function(a,d,k,p){var b={};z(a,"object")?b=a:null!=a&&(b={x1:a,x2:k,y1:d,y2:p});return this.el("line",b)};w.polyline=function(a){1<arguments.length&&(a=Array.prototype.slice.call(arguments,0));var d={};z(a,"object")&&!z(a,"array")?d=a:null!=a&&(d={points:a});return this.el("polyline",d)};
w.polygon=function(a){1<arguments.length&&(a=Array.prototype.slice.call(arguments,0));var d={};z(a,"object")&&!z(a,"array")?d=a:null!=a&&(d={points:a});return this.el("polygon",d)};(function(){function d(){return this.selectAll("stop")}function n(b,d){var f=e("stop"),k={offset:+d+"%"};b=a.color(b);k["stop-color"]=b.hex;1>b.opacity&&(k["stop-opacity"]=b.opacity);e(f,k);this.node.appendChild(f);return this}function u(){if("linearGradient"==this.type){var b=e(this.node,"x1")||0,d=e(this.node,"x2")||
1,f=e(this.node,"y1")||0,k=e(this.node,"y2")||0;return a._.box(b,f,math.abs(d-b),math.abs(k-f))}b=this.node.r||0;return a._.box((this.node.cx||0.5)-b,(this.node.cy||0.5)-b,2*b,2*b)}function p(a,d){function f(a,b){for(var d=(b-u)/(a-w),e=w;e<a;e++)h[e].offset=+(+u+d*(e-w)).toFixed(2);w=a;u=b}var n=k("snap.util.grad.parse",null,d).firstDefined(),p;if(!n)return null;n.params.unshift(a);p="l"==n.type.toLowerCase()?b.apply(0,n.params):q.apply(0,n.params);n.type!=n.type.toLowerCase()&&e(p.node,{gradientUnits:"userSpaceOnUse"});
var h=n.stops,n=h.length,u=0,w=0;n--;for(var v=0;v<n;v++)"offset"in h[v]&&f(v,h[v].offset);h[n].offset=h[n].offset||100;f(n,h[n].offset);for(v=0;v<=n;v++){var y=h[v];p.addStop(y.color,y.offset)}return p}function b(b,k,p,q,w){b=a._.make("linearGradient",b);b.stops=d;b.addStop=n;b.getBBox=u;null!=k&&e(b.node,{x1:k,y1:p,x2:q,y2:w});return b}function q(b,k,p,q,w,h){b=a._.make("radialGradient",b);b.stops=d;b.addStop=n;b.getBBox=u;null!=k&&e(b.node,{cx:k,cy:p,r:q});null!=w&&null!=h&&e(b.node,{fx:w,fy:h});
return b}var e=a._.$;w.gradient=function(a){return p(this.defs,a)};w.gradientLinear=function(a,d,e,f){return b(this.defs,a,d,e,f)};w.gradientRadial=function(a,b,d,e,f){return q(this.defs,a,b,d,e,f)};w.toString=function(){var b=this.node.ownerDocument,d=b.createDocumentFragment(),b=b.createElement("div"),e=this.node.cloneNode(!0);d.appendChild(b);b.appendChild(e);a._.$(e,{xmlns:"http://www.w3.org/2000/svg"});b=b.innerHTML;d.removeChild(d.firstChild);return b};w.clear=function(){for(var a=this.node.firstChild,
b;a;)b=a.nextSibling,"defs"!=a.tagName?a.parentNode.removeChild(a):w.clear.call({node:a}),a=b}})()});C.plugin(function(a,k,y,M){function A(a){var b=A.ps=A.ps||{};b[a]?b[a].sleep=100:b[a]={sleep:100};setTimeout(function(){for(var d in b)b[L](d)&&d!=a&&(b[d].sleep--,!b[d].sleep&&delete b[d])});return b[a]}function w(a,b,d,e){null==a&&(a=b=d=e=0);null==b&&(b=a.y,d=a.width,e=a.height,a=a.x);return{x:a,y:b,width:d,w:d,height:e,h:e,x2:a+d,y2:b+e,cx:a+d/2,cy:b+e/2,r1:F.min(d,e)/2,r2:F.max(d,e)/2,r0:F.sqrt(d*
d+e*e)/2,path:s(a,b,d,e),vb:[a,b,d,e].join(" ")}}function z(){return this.join(",").replace(N,"$1")}function d(a){a=C(a);a.toString=z;return a}function f(a,b,d,h,f,k,l,n,p){if(null==p)return e(a,b,d,h,f,k,l,n);if(0>p||e(a,b,d,h,f,k,l,n)<p)p=void 0;else{var q=0.5,O=1-q,s;for(s=e(a,b,d,h,f,k,l,n,O);0.01<Z(s-p);)q/=2,O+=(s<p?1:-1)*q,s=e(a,b,d,h,f,k,l,n,O);p=O}return u(a,b,d,h,f,k,l,n,p)}function n(b,d){function e(a){return+(+a).toFixed(3)}return a._.cacher(function(a,h,l){a instanceof k&&(a=a.attr("d"));
a=I(a);for(var n,p,D,q,O="",s={},c=0,t=0,r=a.length;t<r;t++){D=a[t];if("M"==D[0])n=+D[1],p=+D[2];else{q=f(n,p,D[1],D[2],D[3],D[4],D[5],D[6]);if(c+q>h){if(d&&!s.start){n=f(n,p,D[1],D[2],D[3],D[4],D[5],D[6],h-c);O+=["C"+e(n.start.x),e(n.start.y),e(n.m.x),e(n.m.y),e(n.x),e(n.y)];if(l)return O;s.start=O;O=["M"+e(n.x),e(n.y)+"C"+e(n.n.x),e(n.n.y),e(n.end.x),e(n.end.y),e(D[5]),e(D[6])].join();c+=q;n=+D[5];p=+D[6];continue}if(!b&&!d)return n=f(n,p,D[1],D[2],D[3],D[4],D[5],D[6],h-c)}c+=q;n=+D[5];p=+D[6]}O+=
D.shift()+D}s.end=O;return n=b?c:d?s:u(n,p,D[0],D[1],D[2],D[3],D[4],D[5],1)},null,a._.clone)}function u(a,b,d,e,h,f,k,l,n){var p=1-n,q=ma(p,3),s=ma(p,2),c=n*n,t=c*n,r=q*a+3*s*n*d+3*p*n*n*h+t*k,q=q*b+3*s*n*e+3*p*n*n*f+t*l,s=a+2*n*(d-a)+c*(h-2*d+a),t=b+2*n*(e-b)+c*(f-2*e+b),x=d+2*n*(h-d)+c*(k-2*h+d),c=e+2*n*(f-e)+c*(l-2*f+e);a=p*a+n*d;b=p*b+n*e;h=p*h+n*k;f=p*f+n*l;l=90-180*F.atan2(s-x,t-c)/S;return{x:r,y:q,m:{x:s,y:t},n:{x:x,y:c},start:{x:a,y:b},end:{x:h,y:f},alpha:l}}function p(b,d,e,h,f,n,k,l){a.is(b,
"array")||(b=[b,d,e,h,f,n,k,l]);b=U.apply(null,b);return w(b.min.x,b.min.y,b.max.x-b.min.x,b.max.y-b.min.y)}function b(a,b,d){return b>=a.x&&b<=a.x+a.width&&d>=a.y&&d<=a.y+a.height}function q(a,d){a=w(a);d=w(d);return b(d,a.x,a.y)||b(d,a.x2,a.y)||b(d,a.x,a.y2)||b(d,a.x2,a.y2)||b(a,d.x,d.y)||b(a,d.x2,d.y)||b(a,d.x,d.y2)||b(a,d.x2,d.y2)||(a.x<d.x2&&a.x>d.x||d.x<a.x2&&d.x>a.x)&&(a.y<d.y2&&a.y>d.y||d.y<a.y2&&d.y>a.y)}function e(a,b,d,e,h,f,n,k,l){null==l&&(l=1);l=(1<l?1:0>l?0:l)/2;for(var p=[-0.1252,
0.1252,-0.3678,0.3678,-0.5873,0.5873,-0.7699,0.7699,-0.9041,0.9041,-0.9816,0.9816],q=[0.2491,0.2491,0.2335,0.2335,0.2032,0.2032,0.1601,0.1601,0.1069,0.1069,0.0472,0.0472],s=0,c=0;12>c;c++)var t=l*p[c]+l,r=t*(t*(-3*a+9*d-9*h+3*n)+6*a-12*d+6*h)-3*a+3*d,t=t*(t*(-3*b+9*e-9*f+3*k)+6*b-12*e+6*f)-3*b+3*e,s=s+q[c]*F.sqrt(r*r+t*t);return l*s}function l(a,b,d){a=I(a);b=I(b);for(var h,f,l,n,k,s,r,O,x,c,t=d?0:[],w=0,v=a.length;w<v;w++)if(x=a[w],"M"==x[0])h=k=x[1],f=s=x[2];else{"C"==x[0]?(x=[h,f].concat(x.slice(1)),
h=x[6],f=x[7]):(x=[h,f,h,f,k,s,k,s],h=k,f=s);for(var G=0,y=b.length;G<y;G++)if(c=b[G],"M"==c[0])l=r=c[1],n=O=c[2];else{"C"==c[0]?(c=[l,n].concat(c.slice(1)),l=c[6],n=c[7]):(c=[l,n,l,n,r,O,r,O],l=r,n=O);var z;var K=x,B=c;z=d;var H=p(K),J=p(B);if(q(H,J)){for(var H=e.apply(0,K),J=e.apply(0,B),H=~~(H/8),J=~~(J/8),U=[],A=[],F={},M=z?0:[],P=0;P<H+1;P++){var C=u.apply(0,K.concat(P/H));U.push({x:C.x,y:C.y,t:P/H})}for(P=0;P<J+1;P++)C=u.apply(0,B.concat(P/J)),A.push({x:C.x,y:C.y,t:P/J});for(P=0;P<H;P++)for(K=
0;K<J;K++){var Q=U[P],L=U[P+1],B=A[K],C=A[K+1],N=0.001>Z(L.x-Q.x)?"y":"x",S=0.001>Z(C.x-B.x)?"y":"x",R;R=Q.x;var Y=Q.y,V=L.x,ea=L.y,fa=B.x,ga=B.y,ha=C.x,ia=C.y;if(W(R,V)<X(fa,ha)||X(R,V)>W(fa,ha)||W(Y,ea)<X(ga,ia)||X(Y,ea)>W(ga,ia))R=void 0;else{var $=(R*ea-Y*V)*(fa-ha)-(R-V)*(fa*ia-ga*ha),aa=(R*ea-Y*V)*(ga-ia)-(Y-ea)*(fa*ia-ga*ha),ja=(R-V)*(ga-ia)-(Y-ea)*(fa-ha);if(ja){var $=$/ja,aa=aa/ja,ja=+$.toFixed(2),ba=+aa.toFixed(2);R=ja<+X(R,V).toFixed(2)||ja>+W(R,V).toFixed(2)||ja<+X(fa,ha).toFixed(2)||
ja>+W(fa,ha).toFixed(2)||ba<+X(Y,ea).toFixed(2)||ba>+W(Y,ea).toFixed(2)||ba<+X(ga,ia).toFixed(2)||ba>+W(ga,ia).toFixed(2)?void 0:{x:$,y:aa}}else R=void 0}R&&F[R.x.toFixed(4)]!=R.y.toFixed(4)&&(F[R.x.toFixed(4)]=R.y.toFixed(4),Q=Q.t+Z((R[N]-Q[N])/(L[N]-Q[N]))*(L.t-Q.t),B=B.t+Z((R[S]-B[S])/(C[S]-B[S]))*(C.t-B.t),0<=Q&&1>=Q&&0<=B&&1>=B&&(z?M++:M.push({x:R.x,y:R.y,t1:Q,t2:B})))}z=M}else z=z?0:[];if(d)t+=z;else{H=0;for(J=z.length;H<J;H++)z[H].segment1=w,z[H].segment2=G,z[H].bez1=x,z[H].bez2=c;t=t.concat(z)}}}return t}
function r(a){var b=A(a);if(b.bbox)return C(b.bbox);if(!a)return w();a=I(a);for(var d=0,e=0,h=[],f=[],l,n=0,k=a.length;n<k;n++)l=a[n],"M"==l[0]?(d=l[1],e=l[2],h.push(d),f.push(e)):(d=U(d,e,l[1],l[2],l[3],l[4],l[5],l[6]),h=h.concat(d.min.x,d.max.x),f=f.concat(d.min.y,d.max.y),d=l[5],e=l[6]);a=X.apply(0,h);l=X.apply(0,f);h=W.apply(0,h);f=W.apply(0,f);f=w(a,l,h-a,f-l);b.bbox=C(f);return f}function s(a,b,d,e,h){if(h)return[["M",+a+ +h,b],["l",d-2*h,0],["a",h,h,0,0,1,h,h],["l",0,e-2*h],["a",h,h,0,0,1,
-h,h],["l",2*h-d,0],["a",h,h,0,0,1,-h,-h],["l",0,2*h-e],["a",h,h,0,0,1,h,-h],["z"] ];a=[["M",a,b],["l",d,0],["l",0,e],["l",-d,0],["z"] ];a.toString=z;return a}function x(a,b,d,e,h){null==h&&null==e&&(e=d);a=+a;b=+b;d=+d;e=+e;if(null!=h){var f=Math.PI/180,l=a+d*Math.cos(-e*f);a+=d*Math.cos(-h*f);var n=b+d*Math.sin(-e*f);b+=d*Math.sin(-h*f);d=[["M",l,n],["A",d,d,0,+(180<h-e),0,a,b] ]}else d=[["M",a,b],["m",0,-e],["a",d,e,0,1,1,0,2*e],["a",d,e,0,1,1,0,-2*e],["z"] ];d.toString=z;return d}function G(b){var e=
A(b);if(e.abs)return d(e.abs);Q(b,"array")&&Q(b&&b[0],"array")||(b=a.parsePathString(b));if(!b||!b.length)return[["M",0,0] ];var h=[],f=0,l=0,n=0,k=0,p=0;"M"==b[0][0]&&(f=+b[0][1],l=+b[0][2],n=f,k=l,p++,h[0]=["M",f,l]);for(var q=3==b.length&&"M"==b[0][0]&&"R"==b[1][0].toUpperCase()&&"Z"==b[2][0].toUpperCase(),s,r,w=p,c=b.length;w<c;w++){h.push(s=[]);r=b[w];p=r[0];if(p!=p.toUpperCase())switch(s[0]=p.toUpperCase(),s[0]){case "A":s[1]=r[1];s[2]=r[2];s[3]=r[3];s[4]=r[4];s[5]=r[5];s[6]=+r[6]+f;s[7]=+r[7]+
l;break;case "V":s[1]=+r[1]+l;break;case "H":s[1]=+r[1]+f;break;case "R":for(var t=[f,l].concat(r.slice(1)),u=2,v=t.length;u<v;u++)t[u]=+t[u]+f,t[++u]=+t[u]+l;h.pop();h=h.concat(P(t,q));break;case "O":h.pop();t=x(f,l,r[1],r[2]);t.push(t[0]);h=h.concat(t);break;case "U":h.pop();h=h.concat(x(f,l,r[1],r[2],r[3]));s=["U"].concat(h[h.length-1].slice(-2));break;case "M":n=+r[1]+f,k=+r[2]+l;default:for(u=1,v=r.length;u<v;u++)s[u]=+r[u]+(u%2?f:l)}else if("R"==p)t=[f,l].concat(r.slice(1)),h.pop(),h=h.concat(P(t,
q)),s=["R"].concat(r.slice(-2));else if("O"==p)h.pop(),t=x(f,l,r[1],r[2]),t.push(t[0]),h=h.concat(t);else if("U"==p)h.pop(),h=h.concat(x(f,l,r[1],r[2],r[3])),s=["U"].concat(h[h.length-1].slice(-2));else for(t=0,u=r.length;t<u;t++)s[t]=r[t];p=p.toUpperCase();if("O"!=p)switch(s[0]){case "Z":f=+n;l=+k;break;case "H":f=s[1];break;case "V":l=s[1];break;case "M":n=s[s.length-2],k=s[s.length-1];default:f=s[s.length-2],l=s[s.length-1]}}h.toString=z;e.abs=d(h);return h}function h(a,b,d,e){return[a,b,d,e,d,
e]}function J(a,b,d,e,h,f){var l=1/3,n=2/3;return[l*a+n*d,l*b+n*e,l*h+n*d,l*f+n*e,h,f]}function K(b,d,e,h,f,l,n,k,p,s){var r=120*S/180,q=S/180*(+f||0),c=[],t,x=a._.cacher(function(a,b,c){var d=a*F.cos(c)-b*F.sin(c);a=a*F.sin(c)+b*F.cos(c);return{x:d,y:a}});if(s)v=s[0],t=s[1],l=s[2],u=s[3];else{t=x(b,d,-q);b=t.x;d=t.y;t=x(k,p,-q);k=t.x;p=t.y;F.cos(S/180*f);F.sin(S/180*f);t=(b-k)/2;v=(d-p)/2;u=t*t/(e*e)+v*v/(h*h);1<u&&(u=F.sqrt(u),e*=u,h*=u);var u=e*e,w=h*h,u=(l==n?-1:1)*F.sqrt(Z((u*w-u*v*v-w*t*t)/
(u*v*v+w*t*t)));l=u*e*v/h+(b+k)/2;var u=u*-h*t/e+(d+p)/2,v=F.asin(((d-u)/h).toFixed(9));t=F.asin(((p-u)/h).toFixed(9));v=b<l?S-v:v;t=k<l?S-t:t;0>v&&(v=2*S+v);0>t&&(t=2*S+t);n&&v>t&&(v-=2*S);!n&&t>v&&(t-=2*S)}if(Z(t-v)>r){var c=t,w=k,G=p;t=v+r*(n&&t>v?1:-1);k=l+e*F.cos(t);p=u+h*F.sin(t);c=K(k,p,e,h,f,0,n,w,G,[t,c,l,u])}l=t-v;f=F.cos(v);r=F.sin(v);n=F.cos(t);t=F.sin(t);l=F.tan(l/4);e=4/3*e*l;l*=4/3*h;h=[b,d];b=[b+e*r,d-l*f];d=[k+e*t,p-l*n];k=[k,p];b[0]=2*h[0]-b[0];b[1]=2*h[1]-b[1];if(s)return[b,d,k].concat(c);
c=[b,d,k].concat(c).join().split(",");s=[];k=0;for(p=c.length;k<p;k++)s[k]=k%2?x(c[k-1],c[k],q).y:x(c[k],c[k+1],q).x;return s}function U(a,b,d,e,h,f,l,k){for(var n=[],p=[[],[] ],s,r,c,t,q=0;2>q;++q)0==q?(r=6*a-12*d+6*h,s=-3*a+9*d-9*h+3*l,c=3*d-3*a):(r=6*b-12*e+6*f,s=-3*b+9*e-9*f+3*k,c=3*e-3*b),1E-12>Z(s)?1E-12>Z(r)||(s=-c/r,0<s&&1>s&&n.push(s)):(t=r*r-4*c*s,c=F.sqrt(t),0>t||(t=(-r+c)/(2*s),0<t&&1>t&&n.push(t),s=(-r-c)/(2*s),0<s&&1>s&&n.push(s)));for(r=q=n.length;q--;)s=n[q],c=1-s,p[0][q]=c*c*c*a+3*
c*c*s*d+3*c*s*s*h+s*s*s*l,p[1][q]=c*c*c*b+3*c*c*s*e+3*c*s*s*f+s*s*s*k;p[0][r]=a;p[1][r]=b;p[0][r+1]=l;p[1][r+1]=k;p[0].length=p[1].length=r+2;return{min:{x:X.apply(0,p[0]),y:X.apply(0,p[1])},max:{x:W.apply(0,p[0]),y:W.apply(0,p[1])}}}function I(a,b){var e=!b&&A(a);if(!b&&e.curve)return d(e.curve);var f=G(a),l=b&&G(b),n={x:0,y:0,bx:0,by:0,X:0,Y:0,qx:null,qy:null},k={x:0,y:0,bx:0,by:0,X:0,Y:0,qx:null,qy:null},p=function(a,b,c){if(!a)return["C",b.x,b.y,b.x,b.y,b.x,b.y];a[0]in{T:1,Q:1}||(b.qx=b.qy=null);
switch(a[0]){case "M":b.X=a[1];b.Y=a[2];break;case "A":a=["C"].concat(K.apply(0,[b.x,b.y].concat(a.slice(1))));break;case "S":"C"==c||"S"==c?(c=2*b.x-b.bx,b=2*b.y-b.by):(c=b.x,b=b.y);a=["C",c,b].concat(a.slice(1));break;case "T":"Q"==c||"T"==c?(b.qx=2*b.x-b.qx,b.qy=2*b.y-b.qy):(b.qx=b.x,b.qy=b.y);a=["C"].concat(J(b.x,b.y,b.qx,b.qy,a[1],a[2]));break;case "Q":b.qx=a[1];b.qy=a[2];a=["C"].concat(J(b.x,b.y,a[1],a[2],a[3],a[4]));break;case "L":a=["C"].concat(h(b.x,b.y,a[1],a[2]));break;case "H":a=["C"].concat(h(b.x,
b.y,a[1],b.y));break;case "V":a=["C"].concat(h(b.x,b.y,b.x,a[1]));break;case "Z":a=["C"].concat(h(b.x,b.y,b.X,b.Y))}return a},s=function(a,b){if(7<a[b].length){a[b].shift();for(var c=a[b];c.length;)q[b]="A",l&&(u[b]="A"),a.splice(b++,0,["C"].concat(c.splice(0,6)));a.splice(b,1);v=W(f.length,l&&l.length||0)}},r=function(a,b,c,d,e){a&&b&&"M"==a[e][0]&&"M"!=b[e][0]&&(b.splice(e,0,["M",d.x,d.y]),c.bx=0,c.by=0,c.x=a[e][1],c.y=a[e][2],v=W(f.length,l&&l.length||0))},q=[],u=[],c="",t="",x=0,v=W(f.length,
l&&l.length||0);for(;x<v;x++){f[x]&&(c=f[x][0]);"C"!=c&&(q[x]=c,x&&(t=q[x-1]));f[x]=p(f[x],n,t);"A"!=q[x]&&"C"==c&&(q[x]="C");s(f,x);l&&(l[x]&&(c=l[x][0]),"C"!=c&&(u[x]=c,x&&(t=u[x-1])),l[x]=p(l[x],k,t),"A"!=u[x]&&"C"==c&&(u[x]="C"),s(l,x));r(f,l,n,k,x);r(l,f,k,n,x);var w=f[x],z=l&&l[x],y=w.length,U=l&&z.length;n.x=w[y-2];n.y=w[y-1];n.bx=$(w[y-4])||n.x;n.by=$(w[y-3])||n.y;k.bx=l&&($(z[U-4])||k.x);k.by=l&&($(z[U-3])||k.y);k.x=l&&z[U-2];k.y=l&&z[U-1]}l||(e.curve=d(f));return l?[f,l]:f}function P(a,
b){for(var d=[],e=0,h=a.length;h-2*!b>e;e+=2){var f=[{x:+a[e-2],y:+a[e-1]},{x:+a[e],y:+a[e+1]},{x:+a[e+2],y:+a[e+3]},{x:+a[e+4],y:+a[e+5]}];b?e?h-4==e?f[3]={x:+a[0],y:+a[1]}:h-2==e&&(f[2]={x:+a[0],y:+a[1]},f[3]={x:+a[2],y:+a[3]}):f[0]={x:+a[h-2],y:+a[h-1]}:h-4==e?f[3]=f[2]:e||(f[0]={x:+a[e],y:+a[e+1]});d.push(["C",(-f[0].x+6*f[1].x+f[2].x)/6,(-f[0].y+6*f[1].y+f[2].y)/6,(f[1].x+6*f[2].x-f[3].x)/6,(f[1].y+6*f[2].y-f[3].y)/6,f[2].x,f[2].y])}return d}y=k.prototype;var Q=a.is,C=a._.clone,L="hasOwnProperty",
N=/,?([a-z]),?/gi,$=parseFloat,F=Math,S=F.PI,X=F.min,W=F.max,ma=F.pow,Z=F.abs;M=n(1);var na=n(),ba=n(0,1),V=a._unit2px;a.path=A;a.path.getTotalLength=M;a.path.getPointAtLength=na;a.path.getSubpath=function(a,b,d){if(1E-6>this.getTotalLength(a)-d)return ba(a,b).end;a=ba(a,d,1);return b?ba(a,b).end:a};y.getTotalLength=function(){if(this.node.getTotalLength)return this.node.getTotalLength()};y.getPointAtLength=function(a){return na(this.attr("d"),a)};y.getSubpath=function(b,d){return a.path.getSubpath(this.attr("d"),
b,d)};a._.box=w;a.path.findDotsAtSegment=u;a.path.bezierBBox=p;a.path.isPointInsideBBox=b;a.path.isBBoxIntersect=q;a.path.intersection=function(a,b){return l(a,b)};a.path.intersectionNumber=function(a,b){return l(a,b,1)};a.path.isPointInside=function(a,d,e){var h=r(a);return b(h,d,e)&&1==l(a,[["M",d,e],["H",h.x2+10] ],1)%2};a.path.getBBox=r;a.path.get={path:function(a){return a.attr("path")},circle:function(a){a=V(a);return x(a.cx,a.cy,a.r)},ellipse:function(a){a=V(a);return x(a.cx||0,a.cy||0,a.rx,
a.ry)},rect:function(a){a=V(a);return s(a.x||0,a.y||0,a.width,a.height,a.rx,a.ry)},image:function(a){a=V(a);return s(a.x||0,a.y||0,a.width,a.height)},line:function(a){return"M"+[a.attr("x1")||0,a.attr("y1")||0,a.attr("x2"),a.attr("y2")]},polyline:function(a){return"M"+a.attr("points")},polygon:function(a){return"M"+a.attr("points")+"z"},deflt:function(a){a=a.node.getBBox();return s(a.x,a.y,a.width,a.height)}};a.path.toRelative=function(b){var e=A(b),h=String.prototype.toLowerCase;if(e.rel)return d(e.rel);
a.is(b,"array")&&a.is(b&&b[0],"array")||(b=a.parsePathString(b));var f=[],l=0,n=0,k=0,p=0,s=0;"M"==b[0][0]&&(l=b[0][1],n=b[0][2],k=l,p=n,s++,f.push(["M",l,n]));for(var r=b.length;s<r;s++){var q=f[s]=[],x=b[s];if(x[0]!=h.call(x[0]))switch(q[0]=h.call(x[0]),q[0]){case "a":q[1]=x[1];q[2]=x[2];q[3]=x[3];q[4]=x[4];q[5]=x[5];q[6]=+(x[6]-l).toFixed(3);q[7]=+(x[7]-n).toFixed(3);break;case "v":q[1]=+(x[1]-n).toFixed(3);break;case "m":k=x[1],p=x[2];default:for(var c=1,t=x.length;c<t;c++)q[c]=+(x[c]-(c%2?l:
n)).toFixed(3)}else for(f[s]=[],"m"==x[0]&&(k=x[1]+l,p=x[2]+n),q=0,c=x.length;q<c;q++)f[s][q]=x[q];x=f[s].length;switch(f[s][0]){case "z":l=k;n=p;break;case "h":l+=+f[s][x-1];break;case "v":n+=+f[s][x-1];break;default:l+=+f[s][x-2],n+=+f[s][x-1]}}f.toString=z;e.rel=d(f);return f};a.path.toAbsolute=G;a.path.toCubic=I;a.path.map=function(a,b){if(!b)return a;var d,e,h,f,l,n,k;a=I(a);h=0;for(l=a.length;h<l;h++)for(k=a[h],f=1,n=k.length;f<n;f+=2)d=b.x(k[f],k[f+1]),e=b.y(k[f],k[f+1]),k[f]=d,k[f+1]=e;return a};
a.path.toString=z;a.path.clone=d});C.plugin(function(a,v,y,C){var A=Math.max,w=Math.min,z=function(a){this.items=[];this.bindings={};this.length=0;this.type="set";if(a)for(var f=0,n=a.length;f<n;f++)a[f]&&(this[this.items.length]=this.items[this.items.length]=a[f],this.length++)};v=z.prototype;v.push=function(){for(var a,f,n=0,k=arguments.length;n<k;n++)if(a=arguments[n])f=this.items.length,this[f]=this.items[f]=a,this.length++;return this};v.pop=function(){this.length&&delete this[this.length--];
return this.items.pop()};v.forEach=function(a,f){for(var n=0,k=this.items.length;n<k&&!1!==a.call(f,this.items[n],n);n++);return this};v.animate=function(d,f,n,u){"function"!=typeof n||n.length||(u=n,n=L.linear);d instanceof a._.Animation&&(u=d.callback,n=d.easing,f=n.dur,d=d.attr);var p=arguments;if(a.is(d,"array")&&a.is(p[p.length-1],"array"))var b=!0;var q,e=function(){q?this.b=q:q=this.b},l=0,r=u&&function(){l++==this.length&&u.call(this)};return this.forEach(function(a,l){k.once("snap.animcreated."+
a.id,e);b?p[l]&&a.animate.apply(a,p[l]):a.animate(d,f,n,r)})};v.remove=function(){for(;this.length;)this.pop().remove();return this};v.bind=function(a,f,k){var u={};if("function"==typeof f)this.bindings[a]=f;else{var p=k||a;this.bindings[a]=function(a){u[p]=a;f.attr(u)}}return this};v.attr=function(a){var f={},k;for(k in a)if(this.bindings[k])this.bindings[k](a[k]);else f[k]=a[k];a=0;for(k=this.items.length;a<k;a++)this.items[a].attr(f);return this};v.clear=function(){for(;this.length;)this.pop()};
v.splice=function(a,f,k){a=0>a?A(this.length+a,0):a;f=A(0,w(this.length-a,f));var u=[],p=[],b=[],q;for(q=2;q<arguments.length;q++)b.push(arguments[q]);for(q=0;q<f;q++)p.push(this[a+q]);for(;q<this.length-a;q++)u.push(this[a+q]);var e=b.length;for(q=0;q<e+u.length;q++)this.items[a+q]=this[a+q]=q<e?b[q]:u[q-e];for(q=this.items.length=this.length-=f-e;this[q];)delete this[q++];return new z(p)};v.exclude=function(a){for(var f=0,k=this.length;f<k;f++)if(this[f]==a)return this.splice(f,1),!0;return!1};
v.insertAfter=function(a){for(var f=this.items.length;f--;)this.items[f].insertAfter(a);return this};v.getBBox=function(){for(var a=[],f=[],k=[],u=[],p=this.items.length;p--;)if(!this.items[p].removed){var b=this.items[p].getBBox();a.push(b.x);f.push(b.y);k.push(b.x+b.width);u.push(b.y+b.height)}a=w.apply(0,a);f=w.apply(0,f);k=A.apply(0,k);u=A.apply(0,u);return{x:a,y:f,x2:k,y2:u,width:k-a,height:u-f,cx:a+(k-a)/2,cy:f+(u-f)/2}};v.clone=function(a){a=new z;for(var f=0,k=this.items.length;f<k;f++)a.push(this.items[f].clone());
return a};v.toString=function(){return"Snap\u2018s set"};v.type="set";a.set=function(){var a=new z;arguments.length&&a.push.apply(a,Array.prototype.slice.call(arguments,0));return a}});C.plugin(function(a,v,y,C){function A(a){var b=a[0];switch(b.toLowerCase()){case "t":return[b,0,0];case "m":return[b,1,0,0,1,0,0];case "r":return 4==a.length?[b,0,a[2],a[3] ]:[b,0];case "s":return 5==a.length?[b,1,1,a[3],a[4] ]:3==a.length?[b,1,1]:[b,1]}}function w(b,d,f){d=q(d).replace(/\.{3}|\u2026/g,b);b=a.parseTransformString(b)||
[];d=a.parseTransformString(d)||[];for(var k=Math.max(b.length,d.length),p=[],v=[],h=0,w,z,y,I;h<k;h++){y=b[h]||A(d[h]);I=d[h]||A(y);if(y[0]!=I[0]||"r"==y[0].toLowerCase()&&(y[2]!=I[2]||y[3]!=I[3])||"s"==y[0].toLowerCase()&&(y[3]!=I[3]||y[4]!=I[4])){b=a._.transform2matrix(b,f());d=a._.transform2matrix(d,f());p=[["m",b.a,b.b,b.c,b.d,b.e,b.f] ];v=[["m",d.a,d.b,d.c,d.d,d.e,d.f] ];break}p[h]=[];v[h]=[];w=0;for(z=Math.max(y.length,I.length);w<z;w++)w in y&&(p[h][w]=y[w]),w in I&&(v[h][w]=I[w])}return{from:u(p),
to:u(v),f:n(p)}}function z(a){return a}function d(a){return function(b){return+b.toFixed(3)+a}}function f(b){return a.rgb(b[0],b[1],b[2])}function n(a){var b=0,d,f,k,n,h,p,q=[];d=0;for(f=a.length;d<f;d++){h="[";p=['"'+a[d][0]+'"'];k=1;for(n=a[d].length;k<n;k++)p[k]="val["+b++ +"]";h+=p+"]";q[d]=h}return Function("val","return Snap.path.toString.call(["+q+"])")}function u(a){for(var b=[],d=0,f=a.length;d<f;d++)for(var k=1,n=a[d].length;k<n;k++)b.push(a[d][k]);return b}var p={},b=/[a-z]+$/i,q=String;
p.stroke=p.fill="colour";v.prototype.equal=function(a,b){return k("snap.util.equal",this,a,b).firstDefined()};k.on("snap.util.equal",function(e,k){var r,s;r=q(this.attr(e)||"");var x=this;if(r==+r&&k==+k)return{from:+r,to:+k,f:z};if("colour"==p[e])return r=a.color(r),s=a.color(k),{from:[r.r,r.g,r.b,r.opacity],to:[s.r,s.g,s.b,s.opacity],f:f};if("transform"==e||"gradientTransform"==e||"patternTransform"==e)return k instanceof a.Matrix&&(k=k.toTransformString()),a._.rgTransform.test(k)||(k=a._.svgTransform2string(k)),
w(r,k,function(){return x.getBBox(1)});if("d"==e||"path"==e)return r=a.path.toCubic(r,k),{from:u(r[0]),to:u(r[1]),f:n(r[0])};if("points"==e)return r=q(r).split(a._.separator),s=q(k).split(a._.separator),{from:r,to:s,f:function(a){return a}};aUnit=r.match(b);s=q(k).match(b);return aUnit&&aUnit==s?{from:parseFloat(r),to:parseFloat(k),f:d(aUnit)}:{from:this.asPX(e),to:this.asPX(e,k),f:z}})});C.plugin(function(a,v,y,C){var A=v.prototype,w="createTouch"in C.doc;v="click dblclick mousedown mousemove mouseout mouseover mouseup touchstart touchmove touchend touchcancel".split(" ");
var z={mousedown:"touchstart",mousemove:"touchmove",mouseup:"touchend"},d=function(a,b){var d="y"==a?"scrollTop":"scrollLeft",e=b&&b.node?b.node.ownerDocument:C.doc;return e[d in e.documentElement?"documentElement":"body"][d]},f=function(){this.returnValue=!1},n=function(){return this.originalEvent.preventDefault()},u=function(){this.cancelBubble=!0},p=function(){return this.originalEvent.stopPropagation()},b=function(){if(C.doc.addEventListener)return function(a,b,e,f){var k=w&&z[b]?z[b]:b,l=function(k){var l=
d("y",f),q=d("x",f);if(w&&z.hasOwnProperty(b))for(var r=0,u=k.targetTouches&&k.targetTouches.length;r<u;r++)if(k.targetTouches[r].target==a||a.contains(k.targetTouches[r].target)){u=k;k=k.targetTouches[r];k.originalEvent=u;k.preventDefault=n;k.stopPropagation=p;break}return e.call(f,k,k.clientX+q,k.clientY+l)};b!==k&&a.addEventListener(b,l,!1);a.addEventListener(k,l,!1);return function(){b!==k&&a.removeEventListener(b,l,!1);a.removeEventListener(k,l,!1);return!0}};if(C.doc.attachEvent)return function(a,
b,e,h){var k=function(a){a=a||h.node.ownerDocument.window.event;var b=d("y",h),k=d("x",h),k=a.clientX+k,b=a.clientY+b;a.preventDefault=a.preventDefault||f;a.stopPropagation=a.stopPropagation||u;return e.call(h,a,k,b)};a.attachEvent("on"+b,k);return function(){a.detachEvent("on"+b,k);return!0}}}(),q=[],e=function(a){for(var b=a.clientX,e=a.clientY,f=d("y"),l=d("x"),n,p=q.length;p--;){n=q[p];if(w)for(var r=a.touches&&a.touches.length,u;r--;){if(u=a.touches[r],u.identifier==n.el._drag.id||n.el.node.contains(u.target)){b=
u.clientX;e=u.clientY;(a.originalEvent?a.originalEvent:a).preventDefault();break}}else a.preventDefault();b+=l;e+=f;k("snap.drag.move."+n.el.id,n.move_scope||n.el,b-n.el._drag.x,e-n.el._drag.y,b,e,a)}},l=function(b){a.unmousemove(e).unmouseup(l);for(var d=q.length,f;d--;)f=q[d],f.el._drag={},k("snap.drag.end."+f.el.id,f.end_scope||f.start_scope||f.move_scope||f.el,b);q=[]};for(y=v.length;y--;)(function(d){a[d]=A[d]=function(e,f){a.is(e,"function")&&(this.events=this.events||[],this.events.push({name:d,
f:e,unbind:b(this.node||document,d,e,f||this)}));return this};a["un"+d]=A["un"+d]=function(a){for(var b=this.events||[],e=b.length;e--;)if(b[e].name==d&&(b[e].f==a||!a)){b[e].unbind();b.splice(e,1);!b.length&&delete this.events;break}return this}})(v[y]);A.hover=function(a,b,d,e){return this.mouseover(a,d).mouseout(b,e||d)};A.unhover=function(a,b){return this.unmouseover(a).unmouseout(b)};var r=[];A.drag=function(b,d,f,h,n,p){function u(r,v,w){(r.originalEvent||r).preventDefault();this._drag.x=v;
this._drag.y=w;this._drag.id=r.identifier;!q.length&&a.mousemove(e).mouseup(l);q.push({el:this,move_scope:h,start_scope:n,end_scope:p});d&&k.on("snap.drag.start."+this.id,d);b&&k.on("snap.drag.move."+this.id,b);f&&k.on("snap.drag.end."+this.id,f);k("snap.drag.start."+this.id,n||h||this,v,w,r)}if(!arguments.length){var v;return this.drag(function(a,b){this.attr({transform:v+(v?"T":"t")+[a,b]})},function(){v=this.transform().local})}this._drag={};r.push({el:this,start:u});this.mousedown(u);return this};
A.undrag=function(){for(var b=r.length;b--;)r[b].el==this&&(this.unmousedown(r[b].start),r.splice(b,1),k.unbind("snap.drag.*."+this.id));!r.length&&a.unmousemove(e).unmouseup(l);return this}});C.plugin(function(a,v,y,C){y=y.prototype;var A=/^\s*url\((.+)\)/,w=String,z=a._.$;a.filter={};y.filter=function(d){var f=this;"svg"!=f.type&&(f=f.paper);d=a.parse(w(d));var k=a._.id(),u=z("filter");z(u,{id:k,filterUnits:"userSpaceOnUse"});u.appendChild(d.node);f.defs.appendChild(u);return new v(u)};k.on("snap.util.getattr.filter",
function(){k.stop();var d=z(this.node,"filter");if(d)return(d=w(d).match(A))&&a.select(d[1])});k.on("snap.util.attr.filter",function(d){if(d instanceof v&&"filter"==d.type){k.stop();var f=d.node.id;f||(z(d.node,{id:d.id}),f=d.id);z(this.node,{filter:a.url(f)})}d&&"none"!=d||(k.stop(),this.node.removeAttribute("filter"))});a.filter.blur=function(d,f){null==d&&(d=2);return a.format('<feGaussianBlur stdDeviation="{def}"/>',{def:null==f?d:[d,f]})};a.filter.blur.toString=function(){return this()};a.filter.shadow=
function(d,f,k,u,p){"string"==typeof k&&(p=u=k,k=4);"string"!=typeof u&&(p=u,u="#000");null==k&&(k=4);null==p&&(p=1);null==d&&(d=0,f=2);null==f&&(f=d);u=a.color(u||"#000");return a.format('<feGaussianBlur in="SourceAlpha" stdDeviation="{blur}"/><feOffset dx="{dx}" dy="{dy}" result="offsetblur"/><feFlood flood-color="{color}"/><feComposite in2="offsetblur" operator="in"/><feComponentTransfer><feFuncA type="linear" slope="{opacity}"/></feComponentTransfer><feMerge><feMergeNode/><feMergeNode in="SourceGraphic"/></feMerge>',
{color:u,dx:d,dy:f,blur:k,opacity:p})};a.filter.shadow.toString=function(){return this()};a.filter.grayscale=function(d){null==d&&(d=1);return a.format('<feColorMatrix type="matrix" values="{a} {b} {c} 0 0 {d} {e} {f} 0 0 {g} {b} {h} 0 0 0 0 0 1 0"/>',{a:0.2126+0.7874*(1-d),b:0.7152-0.7152*(1-d),c:0.0722-0.0722*(1-d),d:0.2126-0.2126*(1-d),e:0.7152+0.2848*(1-d),f:0.0722-0.0722*(1-d),g:0.2126-0.2126*(1-d),h:0.0722+0.9278*(1-d)})};a.filter.grayscale.toString=function(){return this()};a.filter.sepia=
function(d){null==d&&(d=1);return a.format('<feColorMatrix type="matrix" values="{a} {b} {c} 0 0 {d} {e} {f} 0 0 {g} {h} {i} 0 0 0 0 0 1 0"/>',{a:0.393+0.607*(1-d),b:0.769-0.769*(1-d),c:0.189-0.189*(1-d),d:0.349-0.349*(1-d),e:0.686+0.314*(1-d),f:0.168-0.168*(1-d),g:0.272-0.272*(1-d),h:0.534-0.534*(1-d),i:0.131+0.869*(1-d)})};a.filter.sepia.toString=function(){return this()};a.filter.saturate=function(d){null==d&&(d=1);return a.format('<feColorMatrix type="saturate" values="{amount}"/>',{amount:1-
d})};a.filter.saturate.toString=function(){return this()};a.filter.hueRotate=function(d){return a.format('<feColorMatrix type="hueRotate" values="{angle}"/>',{angle:d||0})};a.filter.hueRotate.toString=function(){return this()};a.filter.invert=function(d){null==d&&(d=1);return a.format('<feComponentTransfer><feFuncR type="table" tableValues="{amount} {amount2}"/><feFuncG type="table" tableValues="{amount} {amount2}"/><feFuncB type="table" tableValues="{amount} {amount2}"/></feComponentTransfer>',{amount:d,
amount2:1-d})};a.filter.invert.toString=function(){return this()};a.filter.brightness=function(d){null==d&&(d=1);return a.format('<feComponentTransfer><feFuncR type="linear" slope="{amount}"/><feFuncG type="linear" slope="{amount}"/><feFuncB type="linear" slope="{amount}"/></feComponentTransfer>',{amount:d})};a.filter.brightness.toString=function(){return this()};a.filter.contrast=function(d){null==d&&(d=1);return a.format('<feComponentTransfer><feFuncR type="linear" slope="{amount}" intercept="{amount2}"/><feFuncG type="linear" slope="{amount}" intercept="{amount2}"/><feFuncB type="linear" slope="{amount}" intercept="{amount2}"/></feComponentTransfer>',
{amount:d,amount2:0.5-d/2})};a.filter.contrast.toString=function(){return this()}});return C});

]]> </script>
</svg>
</div>
</div>
</div>
</div>

<div class="cell border-box-sizing text_cell rendered">
<div class="prompt input_prompt">
</div>
<div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>If we take any random point within the rectangle, then the probability that this point lies within the circle, $P(circle)$, is equal to the area of the circle relative to the area of the rectangle. i.e,</p>
<p>$$P(circle) = \frac{A_{circle}}{A_{square}} = \frac{\pi (a/2)^2}{a^2}$$</p>
<p>If we take $n$ points, then as $n$ gets very large the fraction of points that lie within the circle will converge to the probability of landing in the circle, $P(circle)$.</p>
<p>Expanding and rearranging our equation above for $\pi$,</p>
<p>$$\pi = 4\times P(circle)$$</p>
<p>Below is a Julia script for doing just this. $n$ samples from a bivariate uniform range $[0,1]$ are taken, and used as coordinates $(x,y)$ centred on the origin. For each coordinate a distance from the origin is calculated; if this exceeds the radius of the circle then it must lie outside, if not the point is within the circle. The sum of points in the circle is divided by the total number of points taken to give the probability of points in the circle. We can then use the equation above to estimate $\pi$.</p>
<p>The plot shows a sample of the coordinates generated, coloured by whether they lie in or out of the circle. It's interactive, which in this case is pretty pointless, but it's nice that it comes out of the box with IJulia notebooks. I used [JuliaBox](https://www.juliabox.org/), which is a neat online tool for running some basic Julia scripts, and getting a feel for the language.</p>

</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In&nbsp;[35]:</div>
<div class="inner_cell">
    <div class="input_area">
<div class=" highlight hl-julia"><pre><span class="n">n</span> <span class="o">=</span> <span class="mi">1000000</span>

<span class="n">df</span> <span class="o">=</span> <span class="n">DataFrame</span><span class="p">()</span>
<span class="n">df</span><span class="p">[:</span><span class="n">x</span><span class="p">]</span> <span class="o">=</span> <span class="mf">0.5</span> <span class="o">-</span> <span class="n">rand</span><span class="p">(</span><span class="n">n</span><span class="p">)</span>
<span class="n">df</span><span class="p">[:</span><span class="n">y</span><span class="p">]</span> <span class="o">=</span> <span class="mf">0.5</span> <span class="o">-</span> <span class="n">rand</span><span class="p">(</span><span class="n">n</span><span class="p">)</span>
<span class="n">df</span><span class="p">[:</span><span class="n">c</span><span class="p">]</span> <span class="o">=</span> <span class="n">Array</span><span class="p">(</span><span class="n">String</span><span class="p">,</span> <span class="n">n</span><span class="p">)</span>
<span class="n">df</span><span class="p">[:</span><span class="n">r</span><span class="p">]</span> <span class="o">=</span> <span class="n">Array</span><span class="p">(</span><span class="kt">Float64</span><span class="p">,</span> <span class="n">n</span><span class="p">)</span>

<span class="k">for</span> <span class="n">i</span> <span class="o">=</span> <span class="mi">1</span><span class="p">:</span><span class="n">n</span>
    <span class="n">df</span><span class="p">[</span><span class="n">i</span><span class="p">,:</span><span class="n">r</span><span class="p">]</span> <span class="o">=</span> <span class="p">(</span><span class="n">df</span><span class="p">[</span><span class="n">i</span><span class="p">,:</span><span class="n">x</span><span class="p">]</span><span class="o">^</span><span class="mi">2</span> <span class="o">+</span> <span class="n">df</span><span class="p">[</span><span class="n">i</span><span class="p">,:</span><span class="n">y</span><span class="p">]</span><span class="o">^</span><span class="mi">2</span><span class="p">)</span><span class="o">^.</span><span class="mi">5</span>
    <span class="k">if</span> <span class="n">df</span><span class="p">[</span><span class="n">i</span><span class="p">,:</span><span class="n">r</span><span class="p">]</span> <span class="o">&lt;</span> <span class="mf">0.5</span>
        <span class="n">df</span><span class="p">[</span><span class="n">i</span><span class="p">,:</span><span class="n">c</span><span class="p">]</span> <span class="o">=</span> <span class="s">&quot;in&quot;</span>
    <span class="k">else</span> 
        <span class="n">df</span><span class="p">[</span><span class="n">i</span><span class="p">,:</span><span class="n">c</span><span class="p">]</span> <span class="o">=</span> <span class="s">&quot;out&quot;</span>
    <span class="k">end</span>
<span class="k">end</span>

<span class="n">circle_df</span> <span class="o">=</span> <span class="n">DataFrame</span><span class="p">()</span>
<span class="n">circle_df</span><span class="p">[:</span><span class="n">c</span><span class="p">]</span> <span class="o">=</span> <span class="n">cos</span><span class="p">(</span><span class="o">-</span><span class="nb">pi</span><span class="p">:</span><span class="mf">0.01</span><span class="p">:</span><span class="nb">pi</span><span class="p">)</span><span class="o">/</span><span class="mi">2</span>
<span class="n">circle_df</span><span class="p">[:</span><span class="n">s</span><span class="p">]</span> <span class="o">=</span> <span class="n">sin</span><span class="p">(</span><span class="o">-</span><span class="nb">pi</span><span class="p">:</span><span class="mf">0.01</span><span class="p">:</span><span class="nb">pi</span><span class="p">)</span><span class="o">/</span><span class="mi">2</span>

<span class="n">set_default_plot_size</span><span class="p">(</span><span class="mi">15</span><span class="n">cm</span><span class="p">,</span><span class="mi">15</span><span class="n">cm</span><span class="p">)</span>

<span class="n">plot</span><span class="p">(</span><span class="n">df</span><span class="p">[</span><span class="n">sample</span><span class="p">(</span><span class="mi">1</span><span class="p">:</span><span class="n">size</span><span class="p">(</span><span class="n">df</span><span class="p">,</span> <span class="mi">1</span><span class="p">),</span> <span class="n">iceil</span><span class="p">(</span><span class="mf">0.001</span> <span class="o">*</span> <span class="n">size</span><span class="p">(</span><span class="n">df</span><span class="p">,</span> <span class="mi">1</span><span class="p">))),</span> <span class="p">:],</span> <span class="n">x</span><span class="o">=</span><span class="s">&quot;x&quot;</span><span class="p">,</span> <span class="n">y</span><span class="o">=</span><span class="s">&quot;y&quot;</span><span class="p">,</span> <span class="n">color</span><span class="o">=</span><span class="s">&quot;c&quot;</span><span class="p">,</span> <span class="n">Geom</span><span class="o">.</span><span class="n">point</span><span class="p">,</span><span class="n">Coord</span><span class="o">.</span><span class="n">cartesian</span><span class="p">(</span><span class="n">fixed</span><span class="o">=</span><span class="n">true</span><span class="p">),</span>
<span class="n">Guide</span><span class="o">.</span><span class="n">Annotation</span><span class="p">(</span><span class="n">compose</span><span class="p">(</span><span class="n">context</span><span class="p">(),</span><span class="n">circle</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span><span class="mi">0</span><span class="p">,</span><span class="mf">0.5</span><span class="p">),</span> <span class="n">fill</span><span class="p">(</span><span class="n">nothing</span><span class="p">),</span> <span class="n">stroke</span><span class="p">(</span><span class="s">&quot;orange&quot;</span><span class="p">))))</span>
</pre></div>

</div>
</div>
</div>

<div class="output_wrapper">
<div class="output">


<div class="output_area"><div class="prompt output_prompt">Out[35]:</div>

<div class="output_html rendered_html output_subarea output_execute_result">
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg"
     xmlns:xlink="http://www.w3.org/1999/xlink"
     xmlns:gadfly="http://www.gadflyjl.org/ns"
     version="1.2"
     width="150mm" height="150mm" viewBox="0 0 150 150"
     stroke="none"
     fill="#000000"
     stroke-width="0.3"
     font-size="3.88"

     id="fig-7ca6750e949147c1bff9e7479e97a43d">
<g class="plotroot xscalable yscalable" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1">
  <g font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" fill="#564A55" stroke="#000000" stroke-opacity="0.000" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-2">
    <text x="77.57" y="138.77" text-anchor="middle">x</text>
  </g>
  <g class="guide xlabels" font-size="2.82" font-family="'PT Sans Caption','Helvetica Neue','Helvetica',sans-serif" fill="#6C606B" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-3">
    <text x="-152.94" y="131.16" text-anchor="middle" gadfly:scale="1.0" visibility="hidden">-2.0</text>
    <text x="-95.31" y="131.16" text-anchor="middle" gadfly:scale="1.0" visibility="hidden">-1.5</text>
    <text x="-37.69" y="131.16" text-anchor="middle" gadfly:scale="1.0" visibility="hidden">-1.0</text>
    <text x="19.94" y="131.16" text-anchor="middle" gadfly:scale="1.0" visibility="visible">-0.5</text>
    <text x="77.57" y="131.16" text-anchor="middle" gadfly:scale="1.0" visibility="visible">0.0</text>
    <text x="135.19" y="131.16" text-anchor="middle" gadfly:scale="1.0" visibility="visible">0.5</text>
    <text x="192.82" y="131.16" text-anchor="middle" gadfly:scale="1.0" visibility="hidden">1.0</text>
    <text x="250.45" y="131.16" text-anchor="middle" gadfly:scale="1.0" visibility="hidden">1.5</text>
    <text x="308.07" y="131.16" text-anchor="middle" gadfly:scale="1.0" visibility="hidden">2.0</text>
    <text x="-95.31" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-1.50</text>
    <text x="-89.55" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-1.45</text>
    <text x="-83.79" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-1.40</text>
    <text x="-78.03" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-1.35</text>
    <text x="-72.26" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-1.30</text>
    <text x="-66.5" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-1.25</text>
    <text x="-60.74" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-1.20</text>
    <text x="-54.98" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-1.15</text>
    <text x="-49.21" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-1.10</text>
    <text x="-43.45" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-1.05</text>
    <text x="-37.69" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-1.00</text>
    <text x="-31.93" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.95</text>
    <text x="-26.16" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.90</text>
    <text x="-20.4" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.85</text>
    <text x="-14.64" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.80</text>
    <text x="-8.87" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.75</text>
    <text x="-3.11" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.70</text>
    <text x="2.65" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.65</text>
    <text x="8.41" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.60</text>
    <text x="14.18" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.55</text>
    <text x="19.94" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.50</text>
    <text x="25.7" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.45</text>
    <text x="31.46" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.40</text>
    <text x="37.23" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.35</text>
    <text x="42.99" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.30</text>
    <text x="48.75" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.25</text>
    <text x="54.52" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.20</text>
    <text x="60.28" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.15</text>
    <text x="66.04" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.10</text>
    <text x="71.8" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">-0.05</text>
    <text x="77.57" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.00</text>
    <text x="83.33" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.05</text>
    <text x="89.09" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.10</text>
    <text x="94.85" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.15</text>
    <text x="100.62" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.20</text>
    <text x="106.38" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.25</text>
    <text x="112.14" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.30</text>
    <text x="117.91" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.35</text>
    <text x="123.67" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.40</text>
    <text x="129.43" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.45</text>
    <text x="135.19" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.50</text>
    <text x="140.96" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.55</text>
    <text x="146.72" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.60</text>
    <text x="152.48" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.65</text>
    <text x="158.24" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.70</text>
    <text x="164.01" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.75</text>
    <text x="169.77" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.80</text>
    <text x="175.53" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.85</text>
    <text x="181.3" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.90</text>
    <text x="187.06" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">0.95</text>
    <text x="192.82" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">1.00</text>
    <text x="198.58" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">1.05</text>
    <text x="204.35" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">1.10</text>
    <text x="210.11" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">1.15</text>
    <text x="215.87" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">1.20</text>
    <text x="221.63" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">1.25</text>
    <text x="227.4" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">1.30</text>
    <text x="233.16" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">1.35</text>
    <text x="238.92" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">1.40</text>
    <text x="244.68" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">1.45</text>
    <text x="250.45" y="131.16" text-anchor="middle" gadfly:scale="10.0" visibility="hidden">1.50</text>
    <text x="-152.94" y="131.16" text-anchor="middle" gadfly:scale="0.5" visibility="hidden">-2</text>
    <text x="-37.69" y="131.16" text-anchor="middle" gadfly:scale="0.5" visibility="hidden">-1</text>
    <text x="77.57" y="131.16" text-anchor="middle" gadfly:scale="0.5" visibility="hidden">0</text>
    <text x="192.82" y="131.16" text-anchor="middle" gadfly:scale="0.5" visibility="hidden">1</text>
    <text x="308.07" y="131.16" text-anchor="middle" gadfly:scale="0.5" visibility="hidden">2</text>
    <text x="-95.31" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">-1.5</text>
    <text x="-83.79" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">-1.4</text>
    <text x="-72.26" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">-1.3</text>
    <text x="-60.74" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">-1.2</text>
    <text x="-49.21" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">-1.1</text>
    <text x="-37.69" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">-1.0</text>
    <text x="-26.16" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">-0.9</text>
    <text x="-14.64" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">-0.8</text>
    <text x="-3.11" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">-0.7</text>
    <text x="8.41" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">-0.6</text>
    <text x="19.94" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">-0.5</text>
    <text x="31.46" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">-0.4</text>
    <text x="42.99" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">-0.3</text>
    <text x="54.52" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">-0.2</text>
    <text x="66.04" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">-0.1</text>
    <text x="77.57" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">0.0</text>
    <text x="89.09" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">0.1</text>
    <text x="100.62" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">0.2</text>
    <text x="112.14" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">0.3</text>
    <text x="123.67" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">0.4</text>
    <text x="135.19" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">0.5</text>
    <text x="146.72" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">0.6</text>
    <text x="158.24" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">0.7</text>
    <text x="169.77" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">0.8</text>
    <text x="181.3" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">0.9</text>
    <text x="192.82" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">1.0</text>
    <text x="204.35" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">1.1</text>
    <text x="215.87" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">1.2</text>
    <text x="227.4" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">1.3</text>
    <text x="238.92" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">1.4</text>
    <text x="250.45" y="131.16" text-anchor="middle" gadfly:scale="5.0" visibility="hidden">1.5</text>
  </g>
  <g class="guide colorkey" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-4">
    <g fill="#4C404B" font-size="2.82" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-5">
      <text x="141.01" y="67.86" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-6" class="color_out">out</text>
      <text x="141.01" y="71.48" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-7" class="color_in">in</text>
    </g>
    <g stroke="#000000" stroke-opacity="0.000" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-8">
      <rect x="138.19" y="66.95" width="1.81" height="1.81" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-9" class="color_out" fill="#00BFFF"/>
      <rect x="138.19" y="70.58" width="1.81" height="1.81" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-10" class="color_in" fill="#D4CA3A"/>
    </g>
    <g fill="#362A35" font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" stroke="#000000" stroke-opacity="0.000" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-11">
      <text x="138.19" y="64.04" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-12">c</text>
    </g>
  </g>
  <g clip-path="url(#fig-7ca6750e949147c1bff9e7479e97a43d-element-14)" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-13">
    <g pointer-events="visible" opacity="1" fill="#000000" fill-opacity="0.000" stroke="#000000" stroke-opacity="0.000" class="guide background" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-15">
      <rect x="17.94" y="8.23" width="119.25" height="119.25" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-16"/>
    </g>
    <g class="guide ygridlines xfixed" stroke-dasharray="0.5,0.5" stroke-width="0.2" stroke="#D0D0E0" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-17">
      <path fill="none" d="M17.94,298.37 L 137.19 298.37" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-18" gadfly:scale="1.0" visibility="hidden"/>
      <path fill="none" d="M17.94,240.74 L 137.19 240.74" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-19" gadfly:scale="1.0" visibility="hidden"/>
      <path fill="none" d="M17.94,183.11 L 137.19 183.11" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-20" gadfly:scale="1.0" visibility="hidden"/>
      <path fill="none" d="M17.94,125.48 L 137.19 125.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-21" gadfly:scale="1.0" visibility="visible"/>
      <path fill="none" d="M17.94,67.86 L 137.19 67.86" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-22" gadfly:scale="1.0" visibility="visible"/>
      <path fill="none" d="M17.94,10.23 L 137.19 10.23" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-23" gadfly:scale="1.0" visibility="visible"/>
      <path fill="none" d="M17.94,-47.4 L 137.19 -47.4" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-24" gadfly:scale="1.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-105.02 L 137.19 -105.02" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-25" gadfly:scale="1.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-162.65 L 137.19 -162.65" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-26" gadfly:scale="1.0" visibility="hidden"/>
      <path fill="none" d="M17.94,240.74 L 137.19 240.74" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-27" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,234.98 L 137.19 234.98" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-28" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,229.21 L 137.19 229.21" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-29" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,223.45 L 137.19 223.45" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-30" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,217.69 L 137.19 217.69" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-31" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,211.93 L 137.19 211.93" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-32" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,206.16 L 137.19 206.16" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-33" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,200.4 L 137.19 200.4" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-34" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,194.64 L 137.19 194.64" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-35" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,188.87 L 137.19 188.87" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-36" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,183.11 L 137.19 183.11" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-37" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,177.35 L 137.19 177.35" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-38" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,171.59 L 137.19 171.59" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-39" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,165.82 L 137.19 165.82" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-40" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,160.06 L 137.19 160.06" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-41" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,154.3 L 137.19 154.3" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-42" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,148.54 L 137.19 148.54" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-43" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,142.77 L 137.19 142.77" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-44" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,137.01 L 137.19 137.01" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-45" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,131.25 L 137.19 131.25" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-46" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,125.48 L 137.19 125.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-47" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,119.72 L 137.19 119.72" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-48" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,113.96 L 137.19 113.96" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-49" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,108.2 L 137.19 108.2" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-50" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,102.43 L 137.19 102.43" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-51" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,96.67 L 137.19 96.67" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-52" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,90.91 L 137.19 90.91" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-53" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,85.15 L 137.19 85.15" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-54" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,79.38 L 137.19 79.38" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-55" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,73.62 L 137.19 73.62" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-56" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,67.86 L 137.19 67.86" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-57" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,62.09 L 137.19 62.09" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-58" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,56.33 L 137.19 56.33" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-59" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,50.57 L 137.19 50.57" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-60" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,44.81 L 137.19 44.81" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-61" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,39.04 L 137.19 39.04" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-62" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,33.28 L 137.19 33.28" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-63" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,27.52 L 137.19 27.52" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-64" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,21.76 L 137.19 21.76" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-65" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,15.99 L 137.19 15.99" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-66" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,10.23 L 137.19 10.23" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-67" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,4.47 L 137.19 4.47" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-68" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-1.3 L 137.19 -1.3" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-69" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-7.06 L 137.19 -7.06" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-70" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-12.82 L 137.19 -12.82" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-71" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-18.58 L 137.19 -18.58" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-72" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-24.35 L 137.19 -24.35" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-73" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-30.11 L 137.19 -30.11" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-74" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-35.87 L 137.19 -35.87" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-75" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-41.63 L 137.19 -41.63" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-76" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-47.4 L 137.19 -47.4" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-77" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-53.16 L 137.19 -53.16" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-78" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-58.92 L 137.19 -58.92" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-79" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-64.68 L 137.19 -64.68" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-80" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-70.45 L 137.19 -70.45" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-81" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-76.21 L 137.19 -76.21" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-82" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-81.97 L 137.19 -81.97" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-83" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-87.74 L 137.19 -87.74" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-84" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-93.5 L 137.19 -93.5" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-85" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-99.26 L 137.19 -99.26" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-86" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-105.02 L 137.19 -105.02" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-87" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M17.94,298.37 L 137.19 298.37" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-88" gadfly:scale="0.5" visibility="hidden"/>
      <path fill="none" d="M17.94,183.11 L 137.19 183.11" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-89" gadfly:scale="0.5" visibility="hidden"/>
      <path fill="none" d="M17.94,67.86 L 137.19 67.86" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-90" gadfly:scale="0.5" visibility="hidden"/>
      <path fill="none" d="M17.94,-47.4 L 137.19 -47.4" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-91" gadfly:scale="0.5" visibility="hidden"/>
      <path fill="none" d="M17.94,-162.65 L 137.19 -162.65" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-92" gadfly:scale="0.5" visibility="hidden"/>
      <path fill="none" d="M17.94,240.74 L 137.19 240.74" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-93" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,229.21 L 137.19 229.21" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-94" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,217.69 L 137.19 217.69" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-95" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,206.16 L 137.19 206.16" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-96" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,194.64 L 137.19 194.64" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-97" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,183.11 L 137.19 183.11" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-98" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,171.59 L 137.19 171.59" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-99" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,160.06 L 137.19 160.06" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-100" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,148.54 L 137.19 148.54" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-101" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,137.01 L 137.19 137.01" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-102" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,125.48 L 137.19 125.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-103" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,113.96 L 137.19 113.96" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-104" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,102.43 L 137.19 102.43" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-105" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,90.91 L 137.19 90.91" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-106" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,79.38 L 137.19 79.38" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-107" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,67.86 L 137.19 67.86" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-108" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,56.33 L 137.19 56.33" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-109" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,44.81 L 137.19 44.81" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-110" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,33.28 L 137.19 33.28" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-111" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,21.76 L 137.19 21.76" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-112" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,10.23 L 137.19 10.23" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-113" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-1.3 L 137.19 -1.3" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-114" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-12.82 L 137.19 -12.82" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-115" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-24.35 L 137.19 -24.35" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-116" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-35.87 L 137.19 -35.87" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-117" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-47.4 L 137.19 -47.4" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-118" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-58.92 L 137.19 -58.92" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-119" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-70.45 L 137.19 -70.45" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-120" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-81.97 L 137.19 -81.97" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-121" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-93.5 L 137.19 -93.5" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-122" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M17.94,-105.02 L 137.19 -105.02" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-123" gadfly:scale="5.0" visibility="hidden"/>
    </g>
    <g class="guide xgridlines yfixed" stroke-dasharray="0.5,0.5" stroke-width="0.2" stroke="#D0D0E0" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-124">
      <path fill="none" d="M-152.94,8.23 L -152.94 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-125" gadfly:scale="1.0" visibility="hidden"/>
      <path fill="none" d="M-95.31,8.23 L -95.31 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-126" gadfly:scale="1.0" visibility="hidden"/>
      <path fill="none" d="M-37.69,8.23 L -37.69 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-127" gadfly:scale="1.0" visibility="hidden"/>
      <path fill="none" d="M19.94,8.23 L 19.94 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-128" gadfly:scale="1.0" visibility="visible"/>
      <path fill="none" d="M77.57,8.23 L 77.57 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-129" gadfly:scale="1.0" visibility="visible"/>
      <path fill="none" d="M135.19,8.23 L 135.19 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-130" gadfly:scale="1.0" visibility="visible"/>
      <path fill="none" d="M192.82,8.23 L 192.82 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-131" gadfly:scale="1.0" visibility="hidden"/>
      <path fill="none" d="M250.45,8.23 L 250.45 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-132" gadfly:scale="1.0" visibility="hidden"/>
      <path fill="none" d="M308.07,8.23 L 308.07 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-133" gadfly:scale="1.0" visibility="hidden"/>
      <path fill="none" d="M-95.31,8.23 L -95.31 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-134" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M-89.55,8.23 L -89.55 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-135" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M-83.79,8.23 L -83.79 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-136" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M-78.03,8.23 L -78.03 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-137" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M-72.26,8.23 L -72.26 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-138" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M-66.5,8.23 L -66.5 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-139" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M-60.74,8.23 L -60.74 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-140" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M-54.98,8.23 L -54.98 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-141" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M-49.21,8.23 L -49.21 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-142" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M-43.45,8.23 L -43.45 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-143" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M-37.69,8.23 L -37.69 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-144" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M-31.93,8.23 L -31.93 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-145" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M-26.16,8.23 L -26.16 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-146" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M-20.4,8.23 L -20.4 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-147" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M-14.64,8.23 L -14.64 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-148" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M-8.87,8.23 L -8.87 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-149" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M-3.11,8.23 L -3.11 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-150" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M2.65,8.23 L 2.65 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-151" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M8.41,8.23 L 8.41 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-152" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M14.18,8.23 L 14.18 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-153" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M19.94,8.23 L 19.94 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-154" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M25.7,8.23 L 25.7 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-155" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M31.46,8.23 L 31.46 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-156" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M37.23,8.23 L 37.23 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-157" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M42.99,8.23 L 42.99 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-158" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M48.75,8.23 L 48.75 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-159" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M54.52,8.23 L 54.52 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-160" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M60.28,8.23 L 60.28 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-161" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M66.04,8.23 L 66.04 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-162" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M71.8,8.23 L 71.8 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-163" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M77.57,8.23 L 77.57 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-164" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M83.33,8.23 L 83.33 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-165" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M89.09,8.23 L 89.09 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-166" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M94.85,8.23 L 94.85 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-167" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M100.62,8.23 L 100.62 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-168" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M106.38,8.23 L 106.38 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-169" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M112.14,8.23 L 112.14 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-170" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M117.91,8.23 L 117.91 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-171" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M123.67,8.23 L 123.67 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-172" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M129.43,8.23 L 129.43 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-173" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M135.19,8.23 L 135.19 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-174" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M140.96,8.23 L 140.96 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-175" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M146.72,8.23 L 146.72 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-176" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M152.48,8.23 L 152.48 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-177" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M158.24,8.23 L 158.24 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-178" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M164.01,8.23 L 164.01 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-179" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M169.77,8.23 L 169.77 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-180" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M175.53,8.23 L 175.53 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-181" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M181.3,8.23 L 181.3 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-182" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M187.06,8.23 L 187.06 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-183" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M192.82,8.23 L 192.82 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-184" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M198.58,8.23 L 198.58 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-185" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M204.35,8.23 L 204.35 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-186" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M210.11,8.23 L 210.11 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-187" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M215.87,8.23 L 215.87 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-188" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M221.63,8.23 L 221.63 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-189" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M227.4,8.23 L 227.4 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-190" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M233.16,8.23 L 233.16 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-191" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M238.92,8.23 L 238.92 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-192" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M244.68,8.23 L 244.68 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-193" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M250.45,8.23 L 250.45 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-194" gadfly:scale="10.0" visibility="hidden"/>
      <path fill="none" d="M-152.94,8.23 L -152.94 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-195" gadfly:scale="0.5" visibility="hidden"/>
      <path fill="none" d="M-37.69,8.23 L -37.69 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-196" gadfly:scale="0.5" visibility="hidden"/>
      <path fill="none" d="M77.57,8.23 L 77.57 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-197" gadfly:scale="0.5" visibility="hidden"/>
      <path fill="none" d="M192.82,8.23 L 192.82 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-198" gadfly:scale="0.5" visibility="hidden"/>
      <path fill="none" d="M308.07,8.23 L 308.07 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-199" gadfly:scale="0.5" visibility="hidden"/>
      <path fill="none" d="M-95.31,8.23 L -95.31 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-200" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M-83.79,8.23 L -83.79 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-201" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M-72.26,8.23 L -72.26 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-202" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M-60.74,8.23 L -60.74 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-203" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M-49.21,8.23 L -49.21 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-204" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M-37.69,8.23 L -37.69 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-205" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M-26.16,8.23 L -26.16 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-206" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M-14.64,8.23 L -14.64 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-207" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M-3.11,8.23 L -3.11 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-208" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M8.41,8.23 L 8.41 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-209" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M19.94,8.23 L 19.94 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-210" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M31.46,8.23 L 31.46 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-211" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M42.99,8.23 L 42.99 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-212" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M54.52,8.23 L 54.52 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-213" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M66.04,8.23 L 66.04 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-214" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M77.57,8.23 L 77.57 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-215" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M89.09,8.23 L 89.09 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-216" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M100.62,8.23 L 100.62 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-217" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M112.14,8.23 L 112.14 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-218" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M123.67,8.23 L 123.67 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-219" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M135.19,8.23 L 135.19 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-220" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M146.72,8.23 L 146.72 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-221" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M158.24,8.23 L 158.24 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-222" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M169.77,8.23 L 169.77 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-223" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M181.3,8.23 L 181.3 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-224" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M192.82,8.23 L 192.82 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-225" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M204.35,8.23 L 204.35 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-226" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M215.87,8.23 L 215.87 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-227" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M227.4,8.23 L 227.4 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-228" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M238.92,8.23 L 238.92 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-229" gadfly:scale="5.0" visibility="hidden"/>
      <path fill="none" d="M250.45,8.23 L 250.45 127.48" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-230" gadfly:scale="5.0" visibility="hidden"/>
    </g>
    <g class="plotpanel" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-231">
      <g class="geometry" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-232">
        <g stroke-width="0.3" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-233">
          <circle cx="134.06" cy="84.16" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-234" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="65.77" cy="40.15" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-235" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="38.02" cy="109.58" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-236" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="79.61" cy="26.38" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-237" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="99.14" cy="44.14" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-238" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="58" cy="122.68" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-239" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="53.5" cy="113.79" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-240" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="102.63" cy="26.52" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-241" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="67.08" cy="108.63" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-242" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="88.53" cy="55.37" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-243" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="36.42" cy="93.56" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-244" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="87.34" cy="16.85" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-245" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="119.76" cy="63.34" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-246" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="104.86" cy="84.68" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-247" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="128.72" cy="100.49" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-248" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="49.07" cy="104.98" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-249" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="27.45" cy="111.96" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-250" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="118.1" cy="97.75" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-251" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="31.27" cy="24" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-252" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="75.07" cy="55.55" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-253" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="75.84" cy="60.08" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-254" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="28.69" cy="86.04" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-255" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="82.11" cy="74.36" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-256" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="104.61" cy="31.66" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-257" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="81.76" cy="82.83" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-258" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="29.29" cy="48.91" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-259" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="88.7" cy="104.12" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-260" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="64.22" cy="106.6" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-261" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="23.95" cy="91.32" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-262" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="20.28" cy="83.13" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-263" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="90.7" cy="84.64" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-264" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="95.69" cy="57.95" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-265" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="46.55" cy="63.17" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-266" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="38.5" cy="67.47" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-267" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="60.89" cy="68.44" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-268" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="47.89" cy="61.26" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-269" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="90.26" cy="116.61" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-270" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="81.67" cy="115.36" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-271" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="72.46" cy="101.87" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-272" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="39.3" cy="84.14" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-273" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="133.76" cy="32.47" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-274" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="71.62" cy="54.94" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-275" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="121.51" cy="65.7" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-276" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="127.21" cy="34.2" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-277" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="68.84" cy="107.27" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-278" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="118.35" cy="23.16" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-279" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="62.16" cy="63.84" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-280" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="89.09" cy="85.86" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-281" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="95.46" cy="43.14" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-282" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="27.66" cy="73.85" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-283" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="31.53" cy="24.84" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-284" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="41.14" cy="77.31" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-285" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="58.99" cy="27.95" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-286" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="120.89" cy="37.97" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-287" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="115.4" cy="31.11" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-288" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="42.49" cy="114.87" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-289" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="75.31" cy="107.89" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-290" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="30.4" cy="117.62" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-291" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="72.55" cy="11" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-292" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="67.92" cy="27.09" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-293" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="80.35" cy="28.17" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-294" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="75.37" cy="90.51" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-295" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="108.92" cy="68" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-296" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="22.89" cy="11.55" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-297" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="58.37" cy="43.62" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-298" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="25.89" cy="81.06" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-299" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="114.1" cy="110.2" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-300" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="102.67" cy="113.72" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-301" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="31.1" cy="19.3" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-302" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="106.32" cy="32.89" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-303" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="97.97" cy="14.79" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-304" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="33.44" cy="33.44" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-305" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="54.85" cy="65.11" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-306" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="45.77" cy="61.8" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-307" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="129.79" cy="70.35" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-308" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="37.21" cy="11.98" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-309" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="122.44" cy="26.14" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-310" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="105.16" cy="116.53" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-311" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="55.14" cy="37.27" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-312" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="93.13" cy="85.77" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-313" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="29.68" cy="62.25" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-314" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="39.33" cy="59.15" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-315" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="83.23" cy="91.75" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-316" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="35.95" cy="103.71" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-317" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="98.55" cy="27.18" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-318" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="119.86" cy="55.83" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-319" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="130.67" cy="91.6" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-320" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="55.4" cy="116.23" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-321" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="90.66" cy="94.05" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-322" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="22.71" cy="123.06" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-323" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="79.27" cy="39.17" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-324" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="37.86" cy="44.13" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-325" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="52.89" cy="23.87" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-326" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="132.81" cy="110.25" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-327" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="23.64" cy="94.58" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-328" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="134.54" cy="29.92" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-329" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="60.07" cy="100.51" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-330" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="127.65" cy="90.94" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-331" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="42.35" cy="63.42" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-332" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="24.18" cy="63.84" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-333" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="39.52" cy="11.34" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-334" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="52.71" cy="87.74" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-335" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="87.88" cy="32.74" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-336" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="89.81" cy="68.56" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-337" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="134.72" cy="114.92" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-338" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="57.69" cy="117.81" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-339" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="100.37" cy="92.8" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-340" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="80.98" cy="95.22" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-341" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="124.59" cy="97.27" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-342" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="110.52" cy="39.42" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-343" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="103.3" cy="112.33" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-344" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="124.14" cy="103.67" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-345" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="57.54" cy="102.12" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-346" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="94.93" cy="96.53" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-347" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="32.97" cy="58.86" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-348" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="87.26" cy="22.23" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-349" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="50.54" cy="91.42" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-350" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="107.1" cy="98.5" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-351" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="104.49" cy="53.43" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-352" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="33.7" cy="96.93" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-353" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="66.37" cy="79.14" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-354" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="115.16" cy="62.24" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-355" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="36.25" cy="60.53" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-356" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="90.63" cy="63" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-357" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="100.68" cy="116.93" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-358" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="95.7" cy="23.6" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-359" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="23.26" cy="96.53" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-360" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="54.07" cy="55.2" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-361" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="70.53" cy="39.3" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-362" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="46.4" cy="61.27" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-363" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="133.15" cy="99.11" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-364" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="91.42" cy="10.25" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-365" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="128.93" cy="39.92" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-366" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="110.75" cy="23.76" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-367" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="78.32" cy="12.14" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-368" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="134.86" cy="107.07" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-369" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="46.73" cy="95.23" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-370" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="63.17" cy="21.79" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-371" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="84.99" cy="112.75" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-372" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="111.44" cy="14.87" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-373" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="96.05" cy="26.85" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-374" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="101.95" cy="92.37" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-375" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="106.48" cy="25.39" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-376" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="109.33" cy="74.82" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-377" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="94.77" cy="10.46" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-378" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="78.81" cy="55.63" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-379" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="42.72" cy="97.54" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-380" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="109.83" cy="86.13" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-381" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="120.99" cy="38.82" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-382" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="110.46" cy="86.99" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-383" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="27.6" cy="96.24" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-384" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="130.2" cy="66.61" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-385" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="37.41" cy="112.12" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-386" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="92.12" cy="96.37" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-387" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="123.99" cy="33.83" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-388" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="25.13" cy="11.56" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-389" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="49.21" cy="76.11" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-390" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="120.19" cy="12.7" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-391" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="22.18" cy="69.07" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-392" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="26.19" cy="62.72" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-393" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="60.63" cy="54.82" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-394" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="106.39" cy="89.32" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-395" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="117.78" cy="35.04" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-396" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="32.78" cy="42.53" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-397" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="30.76" cy="29.6" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-398" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="53.47" cy="20.54" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-399" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="76.08" cy="112.93" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-400" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="99.85" cy="95.28" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-401" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="31.26" cy="56.99" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-402" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="105.34" cy="108.46" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-403" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="38.57" cy="87.35" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-404" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="34.08" cy="13.28" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-405" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="47.61" cy="41.53" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-406" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="89.45" cy="16.7" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-407" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="88.54" cy="11.16" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-408" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="126.84" cy="28.73" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-409" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="61.49" cy="87.64" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-410" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="44.67" cy="63.04" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-411" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="33.96" cy="110.42" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-412" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="37.87" cy="65.4" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-413" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="38.62" cy="94.47" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-414" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="54.46" cy="89.24" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-415" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="104.45" cy="42.46" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-416" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="104.35" cy="73.76" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-417" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="58.62" cy="94.3" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-418" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="30.2" cy="61.98" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-419" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="85.19" cy="27.4" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-420" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="29.41" cy="45.83" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-421" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="57.89" cy="116.57" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-422" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="97.67" cy="117.18" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-423" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="43.5" cy="124.47" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-424" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="110.62" cy="100.06" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-425" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="111.14" cy="93.18" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-426" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="58.04" cy="78.17" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-427" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="68.73" cy="121.92" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-428" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="79.47" cy="79.12" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-429" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="29.27" cy="116.82" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-430" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="68.93" cy="78.45" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-431" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="132.88" cy="114.2" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-432" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="81.95" cy="42.97" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-433" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="25.21" cy="117.92" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-434" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="48.76" cy="99.02" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-435" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="72.61" cy="88.25" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-436" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="57.92" cy="25.72" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-437" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="36.94" cy="81.75" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-438" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="103.01" cy="15.49" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-439" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="93.21" cy="67.33" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-440" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="105.32" cy="25" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-441" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="93.8" cy="90.05" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-442" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="31.99" cy="37.97" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-443" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="112.37" cy="12.95" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-444" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="84.63" cy="56.42" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-445" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="53.65" cy="39.61" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-446" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="96.79" cy="23.78" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-447" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="93.63" cy="87.62" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-448" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="112.24" cy="104.62" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-449" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="37.23" cy="14.44" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-450" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="101.09" cy="102.97" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-451" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="83.91" cy="95.49" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-452" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="116.66" cy="49.84" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-453" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="46.46" cy="18.09" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-454" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="128.71" cy="81.87" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-455" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="129.11" cy="12.93" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-456" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="101.61" cy="92.04" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-457" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="28.76" cy="97.29" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-458" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="125.66" cy="120.85" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-459" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="124.45" cy="122.23" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-460" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="121.62" cy="81.3" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-461" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="97.24" cy="98.59" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-462" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="47.09" cy="94.32" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-463" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="74.57" cy="57.01" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-464" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="29.96" cy="95.75" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-465" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="27.84" cy="95.21" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-466" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="130.07" cy="96.93" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-467" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="38.52" cy="71.16" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-468" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="84.58" cy="61.97" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-469" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="91.27" cy="77.48" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-470" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="31.62" cy="117.07" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-471" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="50.3" cy="72.09" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-472" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="85.84" cy="86.82" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-473" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="122.1" cy="89.86" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-474" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="22.35" cy="85.02" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-475" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="92.72" cy="118.8" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-476" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="127.55" cy="41.47" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-477" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="124.92" cy="59.48" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-478" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="48.52" cy="94.59" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-479" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="95.15" cy="86.65" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-480" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="105.67" cy="32.1" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-481" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="72.7" cy="88.55" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-482" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="107.41" cy="116.23" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-483" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="71.81" cy="87.31" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-484" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="77.89" cy="43.66" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-485" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="29.72" cy="83.15" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-486" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="39.75" cy="86.15" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-487" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="55.99" cy="48.14" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-488" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="68.58" cy="100.4" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-489" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="114.79" cy="19.35" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-490" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="24.07" cy="125.23" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-491" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="52.07" cy="54.94" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-492" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="134.34" cy="66.23" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-493" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="70.61" cy="77.19" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-494" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="26.6" cy="72.3" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-495" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="115.1" cy="35.28" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-496" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="54.28" cy="24.41" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-497" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="82.83" cy="118.23" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-498" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="25.6" cy="121.51" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-499" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="110.37" cy="111.51" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-500" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="78.78" cy="40.12" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-501" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="47.64" cy="61.47" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-502" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="103.97" cy="98.51" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-503" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="37.38" cy="68.21" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-504" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="109.99" cy="98.4" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-505" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="40.63" cy="107.04" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-506" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="63.64" cy="74.63" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-507" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="89.13" cy="121.03" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-508" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="50.28" cy="71.09" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-509" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="89.77" cy="111.21" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-510" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="90.16" cy="23.02" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-511" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="107.44" cy="103.5" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-512" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="111.33" cy="42.39" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-513" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="99.7" cy="67.37" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-514" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="75.67" cy="80.52" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-515" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="76" cy="28.7" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-516" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="131.35" cy="47.38" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-517" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="80.44" cy="101.67" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-518" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="66.75" cy="88.27" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-519" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="38.9" cy="72.55" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-520" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="64.54" cy="106.45" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-521" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="49.15" cy="45.78" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-522" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="91.02" cy="32.26" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-523" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="87.19" cy="55.29" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-524" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="37.86" cy="88.61" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-525" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="37.38" cy="56.86" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-526" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="47.13" cy="65.16" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-527" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="30.13" cy="22.09" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-528" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="131.68" cy="22.25" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-529" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="84.86" cy="51.07" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-530" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="58.17" cy="65.4" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-531" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="69.37" cy="76.28" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-532" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="29.29" cy="102.99" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-533" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="126.7" cy="82.11" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-534" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="85.52" cy="67.43" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-535" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="23.85" cy="82.12" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-536" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="91.94" cy="23.39" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-537" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="39.57" cy="115.57" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-538" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="119.27" cy="83.49" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-539" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="21.65" cy="97.12" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-540" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="98.9" cy="57.39" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-541" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="33.23" cy="81.81" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-542" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="100.27" cy="95.16" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-543" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="66.94" cy="86.64" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-544" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="90.81" cy="104.17" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-545" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="55.38" cy="12.65" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-546" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="105.98" cy="32.91" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-547" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="95.08" cy="75.14" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-548" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="133.95" cy="26.85" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-549" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="79.31" cy="92.99" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-550" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="79.86" cy="26.54" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-551" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="28.1" cy="121.28" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-552" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="27.15" cy="33.03" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-553" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="22.31" cy="17.96" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-554" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="70.49" cy="100.4" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-555" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="65.82" cy="14.45" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-556" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="97.25" cy="42.7" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-557" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="92.73" cy="50.9" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-558" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="123.55" cy="60.44" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-559" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="132.67" cy="75.18" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-560" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="41.04" cy="105.76" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-561" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="56.79" cy="104.29" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-562" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="51.55" cy="40.28" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-563" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="39.46" cy="117.61" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-564" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="124.8" cy="95.33" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-565" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="21.94" cy="106.36" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-566" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="60.21" cy="103.98" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-567" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="64.92" cy="43.11" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-568" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="53.49" cy="101.82" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-569" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="77.04" cy="112.02" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-570" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="112.62" cy="66.87" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-571" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="79.82" cy="78.96" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-572" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="84.87" cy="70.06" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-573" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="36.62" cy="111.38" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-574" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="93.28" cy="14.82" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-575" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="66.94" cy="89.04" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-576" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="69.49" cy="72.04" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-577" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="94.5" cy="42.92" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-578" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="94.61" cy="102.04" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-579" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="21.15" cy="92.14" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-580" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="68.8" cy="27.25" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-581" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="88.87" cy="123.83" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-582" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="90.82" cy="30.36" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-583" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="35.33" cy="54.15" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-584" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="111.6" cy="15.2" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-585" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="66.95" cy="98.34" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-586" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="73.39" cy="59.61" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-587" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="114.91" cy="38.26" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-588" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="60.26" cy="82.18" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-589" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="48.05" cy="40.06" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-590" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="87.29" cy="124.28" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-591" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="78.75" cy="35.41" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-592" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="70.58" cy="65.25" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-593" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="67.59" cy="41.14" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-594" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="24.17" cy="112.85" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-595" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="91.45" cy="75.99" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-596" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="123.26" cy="70.94" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-597" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="116.02" cy="79.6" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-598" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="39.61" cy="97.37" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-599" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="24.45" cy="72.38" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-600" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="116.88" cy="81.28" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-601" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="29.51" cy="102.46" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-602" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="103.42" cy="13.92" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-603" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="129.77" cy="100.16" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-604" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="89.69" cy="44.77" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-605" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="73.5" cy="69.18" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-606" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="41.15" cy="52.44" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-607" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="55.65" cy="70.41" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-608" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="67.8" cy="118.58" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-609" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="39.47" cy="50.57" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-610" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="35.55" cy="36.76" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-611" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="46.36" cy="83.58" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-612" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="103.99" cy="17.64" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-613" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="100.13" cy="42.01" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-614" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="100.08" cy="94.63" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-615" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="95.63" cy="89.55" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-616" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="64.35" cy="75.15" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-617" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="26.9" cy="95.04" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-618" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="22.57" cy="100.99" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-619" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="110.69" cy="102.15" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-620" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="105.59" cy="24.28" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-621" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="110.31" cy="101.49" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-622" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="42.61" cy="81.41" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-623" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="30.8" cy="45" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-624" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="41.57" cy="104.92" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-625" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="73.72" cy="59.37" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-626" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="86.56" cy="37.75" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-627" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="111.15" cy="65.58" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-628" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="61.38" cy="104.93" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-629" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="20.96" cy="26.43" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-630" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="48.37" cy="70.18" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-631" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="61.13" cy="90.33" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-632" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="90.97" cy="26.43" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-633" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="71.14" cy="42.66" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-634" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="67.93" cy="89.81" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-635" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="124.41" cy="78.23" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-636" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="58.34" cy="67.3" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-637" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="29.67" cy="40.34" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-638" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="62.23" cy="40.98" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-639" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="67.5" cy="14.9" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-640" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="77.07" cy="18.37" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-641" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="133.11" cy="64.32" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-642" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="48.88" cy="81.88" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-643" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="34.31" cy="71.52" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-644" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="32.18" cy="46.63" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-645" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="38.35" cy="93.61" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-646" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="128.11" cy="92.75" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-647" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="118.18" cy="67.06" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-648" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="36.55" cy="86.01" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-649" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="56.1" cy="70.64" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-650" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="44.82" cy="73.76" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-651" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="73.57" cy="18.63" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-652" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="98.27" cy="70.76" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-653" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="79.92" cy="90.91" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-654" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="79.35" cy="77.17" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-655" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="29.11" cy="61.5" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-656" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="104.5" cy="34.36" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-657" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="34.47" cy="61.43" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-658" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="100.98" cy="118" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-659" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="62.76" cy="57.89" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-660" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="119.35" cy="22.26" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-661" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="85.64" cy="84.71" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-662" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="50.54" cy="100.38" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-663" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="88.19" cy="108" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-664" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="107.78" cy="110.98" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-665" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="54.43" cy="124.63" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-666" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="123.34" cy="68.93" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-667" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="133.67" cy="56.59" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-668" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="45.16" cy="111.02" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-669" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="80.92" cy="97.37" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-670" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="77.81" cy="53.57" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-671" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="110.52" cy="91.35" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-672" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="94.49" cy="15.2" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-673" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="49.55" cy="66.63" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-674" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="68.95" cy="65.17" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-675" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="71.52" cy="103.08" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-676" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="23.49" cy="14.22" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-677" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="55.86" cy="63.72" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-678" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="103.86" cy="51.59" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-679" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="128.25" cy="43.49" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-680" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="59.43" cy="13.5" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-681" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="67.2" cy="36.59" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-682" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="90.43" cy="32.24" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-683" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="90.6" cy="13.49" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-684" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="50.7" cy="13.22" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-685" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="20.43" cy="102.58" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-686" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="101.97" cy="57.34" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-687" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="77.59" cy="13" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-688" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="97.91" cy="43.69" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-689" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="41.85" cy="74.99" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-690" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="23.48" cy="55.27" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-691" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="106.02" cy="94.08" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-692" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="114.38" cy="42.11" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-693" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="23.98" cy="89.41" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-694" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="20.54" cy="111.87" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-695" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="94.22" cy="116.6" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-696" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="94.49" cy="86.49" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-697" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="96.98" cy="112.51" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-698" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="75.17" cy="64.3" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-699" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="25.02" cy="96.99" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-700" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="52.15" cy="96.85" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-701" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="120.71" cy="120.61" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-702" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="39.73" cy="71.62" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-703" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="48.06" cy="84.27" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-704" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="44.58" cy="43.11" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-705" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="127.63" cy="50.33" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-706" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="79.94" cy="82.11" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-707" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="84.52" cy="106.47" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-708" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="101.3" cy="31.11" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-709" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="108.75" cy="51.36" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-710" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="97.79" cy="119.88" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-711" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="80.94" cy="96.27" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-712" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="125.6" cy="21.81" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-713" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="74.51" cy="119.42" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-714" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="46.2" cy="103.18" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-715" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="105.65" cy="62.27" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-716" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="95.42" cy="73.28" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-717" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="20.86" cy="19.13" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-718" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="72.83" cy="13.23" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-719" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="62.1" cy="43.79" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-720" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="42.54" cy="58.9" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-721" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="32.97" cy="95.29" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-722" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="95.3" cy="95.77" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-723" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="24.07" cy="57.95" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-724" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="24.96" cy="105.62" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-725" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="59.28" cy="98.58" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-726" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="33.63" cy="76.24" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-727" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="27.39" cy="11.75" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-728" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="71.24" cy="47.95" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-729" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="43.17" cy="73.82" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-730" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="84.42" cy="35.32" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-731" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="48.84" cy="121.6" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-732" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="86.73" cy="100.05" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-733" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="132.36" cy="56.86" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-734" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="112.01" cy="64.58" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-735" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="112.31" cy="78.84" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-736" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="124.73" cy="83.82" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-737" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="39.38" cy="17.84" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-738" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="111.43" cy="106.88" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-739" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="32.82" cy="88.11" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-740" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="46.66" cy="38.91" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-741" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="121.09" cy="25.99" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-742" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="118.27" cy="93.8" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-743" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="41.36" cy="79.72" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-744" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="95.1" cy="102.81" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-745" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="39.37" cy="124.05" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-746" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="61.58" cy="61.14" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-747" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="129.8" cy="71.34" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-748" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="20.3" cy="40.19" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-749" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="78.79" cy="37.53" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-750" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="87.07" cy="81.31" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-751" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="66.57" cy="46.42" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-752" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="108.26" cy="64.11" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-753" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="89.63" cy="72.37" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-754" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="44.91" cy="94.58" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-755" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="111.13" cy="116.17" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-756" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="46.34" cy="66.51" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-757" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="78.09" cy="54.63" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-758" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="60.84" cy="100.9" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-759" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="108.11" cy="34.97" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-760" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="124.76" cy="92.88" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-761" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="118.5" cy="65.85" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-762" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="118.2" cy="112.99" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-763" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="35.21" cy="34.43" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-764" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="53.56" cy="69.69" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-765" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="111.56" cy="117.77" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-766" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="96.08" cy="26.98" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-767" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="53.6" cy="74.27" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-768" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="132.28" cy="42.97" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-769" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="23.71" cy="50.01" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-770" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="121.54" cy="99.67" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-771" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="72.83" cy="120.91" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-772" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="91.54" cy="71.01" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-773" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="70.62" cy="108.08" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-774" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="55.02" cy="54.31" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-775" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="72.61" cy="32.59" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-776" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="65.23" cy="113.06" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-777" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="116.75" cy="60.42" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-778" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="27.58" cy="121.6" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-779" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="48.8" cy="41.69" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-780" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="101.99" cy="116.84" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-781" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="105.6" cy="63.02" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-782" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="134.97" cy="112.7" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-783" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="130.51" cy="92.2" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-784" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="84.02" cy="88.23" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-785" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="131.36" cy="65.58" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-786" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="132.87" cy="111.61" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-787" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="115.33" cy="57.56" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-788" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="24.44" cy="80.22" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-789" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="21.37" cy="80.39" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-790" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="77.82" cy="120.01" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-791" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="122.41" cy="11.29" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-792" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="49.26" cy="123.36" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-793" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="105.11" cy="98.36" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-794" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="43.38" cy="11.06" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-795" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="32.05" cy="59.61" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-796" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="94.82" cy="51.23" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-797" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="50.66" cy="113.44" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-798" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="117.64" cy="24.23" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-799" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="93.49" cy="63.21" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-800" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="25.77" cy="59.94" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-801" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="68.43" cy="112.84" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-802" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="62.92" cy="24.47" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-803" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="88.78" cy="77.13" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-804" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="118.3" cy="40.57" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-805" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="35.82" cy="71.38" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-806" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="115.41" cy="72.51" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-807" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="103.33" cy="58.54" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-808" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="105.92" cy="89.52" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-809" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="129.51" cy="111.89" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-810" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="62.25" cy="104.58" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-811" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="79.98" cy="80.22" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-812" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="119.67" cy="94.58" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-813" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="125.23" cy="89.68" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-814" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="86.18" cy="98.4" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-815" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="108.93" cy="98.22" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-816" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="91.06" cy="12.07" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-817" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="99.09" cy="59.16" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-818" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="52.79" cy="20.12" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-819" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="67.06" cy="46.84" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-820" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="109.13" cy="89.28" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-821" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="26.34" cy="67.62" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-822" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="123.95" cy="97.56" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-823" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="89.45" cy="72.69" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-824" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="29.07" cy="70.27" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-825" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="108.68" cy="103.32" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-826" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="80.72" cy="19.96" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-827" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="124.12" cy="109.94" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-828" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="112" cy="122.35" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-829" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="107.19" cy="109.98" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-830" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="63.71" cy="15.69" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-831" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="57.22" cy="73.79" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-832" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="112.89" cy="110.6" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-833" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="134.88" cy="108.75" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-834" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="39.93" cy="12.2" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-835" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="92.86" cy="83.82" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-836" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="28.29" cy="11.15" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-837" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="28.75" cy="79.97" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-838" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="105.31" cy="46.68" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-839" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="104.28" cy="95.45" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-840" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="69.86" cy="86.21" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-841" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="83.71" cy="121.7" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-842" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="131.8" cy="112.39" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-843" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="52.86" cy="99.71" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-844" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="66.66" cy="19.06" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-845" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="131.7" cy="89.02" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-846" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="71.74" cy="64.71" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-847" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="67.22" cy="97.17" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-848" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="130.29" cy="31.69" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-849" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="36.85" cy="85.74" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-850" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="92.34" cy="58.59" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-851" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="84.41" cy="104.98" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-852" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="78.01" cy="63.48" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-853" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="42.26" cy="124.45" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-854" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="38.66" cy="96.7" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-855" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="84.52" cy="78.4" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-856" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="104.72" cy="81.22" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-857" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="120.46" cy="49.11" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-858" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="42.98" cy="60.11" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-859" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="71.16" cy="13.48" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-860" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="31.45" cy="96.93" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-861" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="37.79" cy="93.13" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-862" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="64.02" cy="114.58" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-863" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="21.71" cy="77.76" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-864" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="104.14" cy="116.62" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-865" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="96.25" cy="25.02" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-866" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="89.22" cy="62.8" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-867" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="22.86" cy="116.05" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-868" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="80.16" cy="88.06" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-869" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="62.97" cy="21.39" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-870" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="25.48" cy="71.87" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-871" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="44.08" cy="61.63" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-872" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="95.33" cy="117.17" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-873" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="89.65" cy="97.91" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-874" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="119.45" cy="71.96" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-875" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="48.34" cy="119.89" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-876" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="78.64" cy="100.25" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-877" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="90.31" cy="112.89" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-878" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="79.1" cy="18.7" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-879" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="38.55" cy="16.59" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-880" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="39.05" cy="125.18" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-881" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="80.69" cy="67.83" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-882" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="84.27" cy="82.46" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-883" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="107.68" cy="62.52" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-884" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="76.62" cy="48.16" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-885" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="94.43" cy="63.24" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-886" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="25.27" cy="36.12" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-887" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="131.31" cy="36.98" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-888" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="110.33" cy="109.6" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-889" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="41.5" cy="10.78" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-890" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="75.43" cy="108.39" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-891" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="81.79" cy="99.78" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-892" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="43.09" cy="93.34" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-893" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="58.73" cy="111.33" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-894" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="128.02" cy="56.65" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-895" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="51.38" cy="61.84" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-896" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="50.06" cy="34.32" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-897" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="38.92" cy="15.68" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-898" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="106.19" cy="69.74" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-899" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="26.7" cy="16.99" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-900" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="71.76" cy="24.81" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-901" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="83.17" cy="90.67" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-902" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="101.61" cy="64.68" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-903" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="62.11" cy="37.22" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-904" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="20.13" cy="44.61" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-905" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="70.39" cy="54.93" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-906" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="87.92" cy="52.47" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-907" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="69.64" cy="84.21" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-908" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="55.86" cy="47.67" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-909" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="89.41" cy="57.36" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-910" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="63.56" cy="98.54" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-911" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="118.9" cy="54.31" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-912" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="46.04" cy="123.89" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-913" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="108.07" cy="41.24" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-914" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="74.93" cy="51.43" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-915" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="131.32" cy="82.8" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-916" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="23.65" cy="101.71" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-917" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="77.15" cy="25.85" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-918" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="92.39" cy="96.28" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-919" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="22.49" cy="50.03" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-920" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="61.97" cy="123.2" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-921" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="113.73" cy="12.23" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-922" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="105.97" cy="82.79" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-923" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="31.59" cy="111.99" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-924" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="25.46" cy="49.62" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-925" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="24.3" cy="58.54" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-926" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="133" cy="84.74" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-927" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="133.28" cy="52.63" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-928" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="95.91" cy="103.9" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-929" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="58.29" cy="85.57" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-930" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="53.56" cy="43.16" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-931" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="102.98" cy="21.89" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-932" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="121.32" cy="53.16" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-933" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="100.97" cy="25.17" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-934" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="78.59" cy="103.92" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-935" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="48.15" cy="29.69" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-936" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="101.26" cy="25.48" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-937" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="28.23" cy="11.12" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-938" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="60.84" cy="39.82" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-939" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="95.42" cy="83.31" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-940" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="63.64" cy="81.26" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-941" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="21.18" cy="116.41" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-942" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="101.44" cy="107.47" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-943" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="126.43" cy="22.16" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-944" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="51.46" cy="118.69" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-945" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="97.17" cy="112.7" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-946" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="94.85" cy="61.77" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-947" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="29.26" cy="100.27" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-948" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="77.85" cy="74.26" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-949" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="86.79" cy="77.95" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-950" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="46.01" cy="21.57" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-951" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="116.98" cy="64.71" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-952" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="79.94" cy="119.45" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-953" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="31.11" cy="28.76" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-954" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="28.74" cy="99.94" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-955" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="85.85" cy="79.25" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-956" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="45" cy="55.77" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-957" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="112.24" cy="41.71" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-958" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="107.78" cy="67.29" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-959" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="91.29" cy="59.84" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-960" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="33" cy="87.6" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-961" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="85.27" cy="81.47" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-962" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="37.03" cy="35.6" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-963" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="57.96" cy="107.22" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-964" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="46.75" cy="96.84" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-965" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="130.67" cy="70.15" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-966" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="94.94" cy="120.73" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-967" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="89.32" cy="116.24" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-968" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="103.21" cy="11.06" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-969" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="29.33" cy="88.13" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-970" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="48.97" cy="107.27" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-971" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="49.03" cy="107.13" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-972" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="99.07" cy="77.22" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-973" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="35.43" cy="48.05" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-974" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="117.78" cy="26.28" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-975" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="90.24" cy="112.78" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-976" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="83.54" cy="58.3" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-977" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="36.7" cy="76.16" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-978" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="57.3" cy="109.92" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-979" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="35.17" cy="61.33" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-980" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="125.38" cy="85.64" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-981" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="28.97" cy="42.42" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-982" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="91.16" cy="106.05" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-983" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="36.02" cy="15.59" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-984" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="57.78" cy="29.87" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-985" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="122.11" cy="66.54" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-986" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="80.87" cy="75.72" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-987" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="82.59" cy="58.06" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-988" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="111.89" cy="34.29" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-989" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="132.02" cy="33.81" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-990" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="67.47" cy="32.74" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-991" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="105.06" cy="63.51" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-992" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="38.59" cy="66.53" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-993" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="25.38" cy="86.6" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-994" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="60.75" cy="16.63" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-995" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="35.09" cy="61.75" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-996" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="80.53" cy="29.29" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-997" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="95.47" cy="79.64" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-998" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="88.45" cy="76.94" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-999" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="84.83" cy="53.32" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1000" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="96.16" cy="88.49" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1001" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="76.58" cy="119.26" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1002" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="26.12" cy="95.28" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1003" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="90.12" cy="13.86" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1004" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="62" cy="120.18" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1005" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="129.05" cy="23.72" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1006" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="40.65" cy="22.14" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1007" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="103.14" cy="104.71" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1008" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="106.21" cy="67.67" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1009" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="123.18" cy="24.02" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1010" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="62.66" cy="64.36" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1011" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="87.75" cy="114.99" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1012" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="106.39" cy="23.34" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1013" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="70.5" cy="80.3" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1014" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="111.73" cy="99.14" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1015" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="104.64" cy="46.8" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1016" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="20.23" cy="48.07" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1017" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="34.67" cy="24.62" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1018" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="81.27" cy="23.83" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1019" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="134.43" cy="109.05" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1020" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="92.18" cy="44.22" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1021" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="70.13" cy="40.03" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1022" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="129.08" cy="53.47" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1023" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="82.29" cy="105.75" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1024" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="113.56" cy="119.61" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1025" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="24.93" cy="18.49" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1026" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="75.67" cy="80.95" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1027" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="52.11" cy="60.95" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1028" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="56.55" cy="11.43" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1029" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="114.28" cy="80.43" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1030" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="100.68" cy="22.73" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1031" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="55.28" cy="112.28" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1032" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="27.18" cy="50.57" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1033" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="133.96" cy="95.76" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1034" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="87.86" cy="54.66" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1035" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="31.7" cy="62.36" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1036" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="87.45" cy="36.31" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1037" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="26.77" cy="24.44" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1038" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="73.27" cy="110.01" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1039" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="36.39" cy="92.02" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1040" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="118.32" cy="56.43" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1041" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="67.86" cy="31.89" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1042" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="56.01" cy="32.34" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1043" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="31.28" cy="32.35" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1044" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="131.84" cy="110.58" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1045" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="104.63" cy="90.86" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1046" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="104.9" cy="59.89" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1047" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="80.51" cy="13.71" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1048" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="131.23" cy="32.6" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1049" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="73.34" cy="27.44" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1050" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="96.14" cy="110.02" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1051" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="104.71" cy="33.76" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1052" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="93.18" cy="78.89" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1053" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="83.16" cy="50.55" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1054" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="108.03" cy="93.91" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1055" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="69.61" cy="83.27" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1056" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="124.95" cy="59.3" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1057" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="89.23" cy="62.51" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1058" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="107.5" cy="27.22" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1059" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="131.39" cy="95.27" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1060" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="50.71" cy="110.57" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1061" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="90.96" cy="85.1" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1062" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="117.03" cy="28.72" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1063" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="57.53" cy="77.55" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1064" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="57.26" cy="70.43" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1065" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="123.2" cy="109.72" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1066" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="20.28" cy="114.67" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1067" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="85.32" cy="30.17" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1068" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="67.36" cy="41.99" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1069" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="129.62" cy="43.09" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1070" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="55.17" cy="110.76" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1071" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="24.98" cy="83.93" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1072" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="38.41" cy="85.26" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1073" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="96.42" cy="38.22" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1074" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="55.38" cy="50.26" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1075" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="122.41" cy="121.52" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1076" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="103.87" cy="85.99" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1077" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="90.03" cy="95.63" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1078" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="51.82" cy="58.59" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1079" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="41.38" cy="57.09" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1080" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="88.29" cy="20.68" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1081" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="127.8" cy="53.78" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1082" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="33.54" cy="73.88" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1083" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="124.61" cy="116.64" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1084" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="82.69" cy="48.46" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1085" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="98.5" cy="92.23" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1086" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="129.42" cy="80.19" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1087" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="89.39" cy="13.65" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1088" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="62.94" cy="16.98" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1089" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="38.14" cy="105.08" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1090" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="51.4" cy="62.63" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1091" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="86.02" cy="64.26" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1092" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="115.07" cy="87.3" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1093" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="41.54" cy="50.35" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1094" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="108.64" cy="26.06" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1095" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="87.25" cy="104.28" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1096" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="122.09" cy="48.53" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1097" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="128.52" cy="63.55" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1098" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="81.24" cy="22.59" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1099" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="127.02" cy="31.53" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1100" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="60.73" cy="21.67" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1101" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="123" cy="89.84" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1102" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="40.95" cy="32.8" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1103" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="105.29" cy="77.79" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1104" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="36.9" cy="113.95" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1105" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="91.52" cy="88.95" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1106" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="29.74" cy="122.98" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1107" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="79.2" cy="94.52" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1108" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="107.77" cy="101.03" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1109" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="28.46" cy="63.76" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1110" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="70.4" cy="59.84" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1111" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="69.59" cy="101.75" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1112" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="59.22" cy="24.14" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1113" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="97.22" cy="103.99" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1114" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="91.28" cy="14.25" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1115" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="56.1" cy="76.93" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1116" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="55.89" cy="46.41" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1117" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="119.14" cy="94.87" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1118" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="112.42" cy="22.87" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1119" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="131.46" cy="14.39" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1120" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="134.06" cy="58.04" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1121" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="50.16" cy="35.37" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1122" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="48.73" cy="63.78" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1123" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="69.81" cy="23.27" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1124" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="65.61" cy="111.76" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1125" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="74.12" cy="103.99" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1126" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="88.5" cy="54.54" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1127" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="41.63" cy="31.63" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1128" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="119.63" cy="115.82" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1129" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="41.66" cy="84.78" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1130" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="39.53" cy="97.43" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1131" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="86.66" cy="72.2" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1132" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="104.4" cy="115.51" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1133" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="47.96" cy="41.69" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1134" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="59.51" cy="17.3" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1135" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="24.83" cy="40.79" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1136" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="27.68" cy="102.58" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1137" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="105.25" cy="24.55" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1138" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="46.75" cy="110.5" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1139" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="58.36" cy="99.65" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1140" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="122.79" cy="64.35" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1141" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="59.34" cy="121.14" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1142" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="64.19" cy="76.48" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1143" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="102.66" cy="39.21" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1144" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="60.98" cy="69.08" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1145" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="26.04" cy="118.54" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1146" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="40.83" cy="32.36" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1147" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="60.23" cy="38.37" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1148" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="72.33" cy="57" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1149" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="133.97" cy="121.88" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1150" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="115.68" cy="26.36" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1151" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="64.45" cy="96.32" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1152" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="25.38" cy="12.36" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1153" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="131.73" cy="94.91" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1154" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="34.9" cy="108.7" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1155" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="62.92" cy="48.83" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1156" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="54.08" cy="16.23" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1157" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="72.33" cy="105.81" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1158" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="59.35" cy="114.49" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1159" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="31.08" cy="63.89" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1160" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="62.64" cy="80.99" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1161" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="23.91" cy="72.41" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1162" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="37.66" cy="74.56" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1163" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="105.44" cy="37.74" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1164" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="126.44" cy="13.98" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1165" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="94.75" cy="24.79" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1166" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="106.34" cy="27.23" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1167" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="35.15" cy="11.22" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1168" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="116.21" cy="17.79" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1169" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="84.18" cy="62.29" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1170" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="103.7" cy="85.97" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1171" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="94.04" cy="50.48" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1172" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="131.61" cy="21.44" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1173" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="47.38" cy="14.64" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1174" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="57.79" cy="49.34" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1175" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="130.16" cy="100.7" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1176" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="32.52" cy="89.56" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1177" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="120.49" cy="24.91" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1178" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="105.29" cy="114.67" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1179" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="57.82" cy="19.59" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1180" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="56.5" cy="81.09" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1181" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="130.09" cy="96.07" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1182" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="65.74" cy="38.63" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1183" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="99.78" cy="111.18" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1184" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="28.39" cy="48.04" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1185" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="109.04" cy="90.54" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1186" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="72.07" cy="91.72" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1187" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="113.09" cy="76.9" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1188" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="51.32" cy="105.47" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1189" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="125.79" cy="105.34" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1190" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="44.5" cy="35.15" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1191" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="118.43" cy="93.44" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1192" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="72.96" cy="33.59" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1193" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="95.7" cy="54.28" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1194" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="126.26" cy="21" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1195" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="72.96" cy="120.04" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1196" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="25.77" cy="34.02" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1197" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="97.7" cy="17.91" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1198" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="66.63" cy="111.68" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1199" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="67.14" cy="53.57" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1200" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="132.45" cy="90.78" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1201" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="80.17" cy="51.37" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1202" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="51.12" cy="101.48" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1203" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="48.93" cy="101.48" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1204" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="113.32" cy="86.4" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1205" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="46.92" cy="75.74" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1206" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="123.65" cy="24.95" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1207" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="25.75" cy="10.36" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1208" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="106.1" cy="106.71" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1209" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="90.39" cy="115.22" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1210" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="106.26" cy="115.64" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1211" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="42.85" cy="26.45" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1212" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="119.45" cy="81.93" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1213" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="37.65" cy="77.68" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1214" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="109.07" cy="48.87" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1215" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="129.11" cy="56.03" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1216" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="133.11" cy="16.91" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1217" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="67.88" cy="54.04" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1218" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="116.74" cy="32.55" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1219" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="110.45" cy="26.45" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1220" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="122.8" cy="118.66" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1221" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="22.51" cy="47.67" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1222" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="119.29" cy="51.44" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1223" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="101.3" cy="44.02" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1224" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="103.35" cy="85.6" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1225" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="43.79" cy="122.57" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1226" class="color_out" stroke="#FFFFFF" fill="#00BFFF"/>
          <circle cx="130.75" cy="52" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1227" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="66.34" cy="67.5" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1228" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="76.57" cy="40.48" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1229" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="98.1" cy="29.85" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1230" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="78.16" cy="92.49" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1231" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="57.77" cy="94.81" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1232" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
          <circle cx="75.87" cy="19.24" r="0.9" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1233" class="color_in" stroke="#FFFFFF" fill="#D4CA3A"/>
        </g>
      </g>
    </g>
    <g opacity="0" class="guide zoomslider" stroke="#000000" stroke-opacity="0.000" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1234">
      <g fill="#EAEAEA" stroke-width="0.3" stroke-opacity="0" stroke="#6A6A6A" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1235">
        <rect x="130.19" y="11.23" width="4" height="4" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1236"/>
        <g class="button_logo" fill="#6A6A6A" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1237">
          <path d="M130.99,12.83 L 131.79 12.83 131.79 12.03 132.59 12.03 132.59 12.83 133.39 12.83 133.39 13.63 132.59 13.63 132.59 14.43 131.79 14.43 131.79 13.63 130.99 13.63 z" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1238"/>
        </g>
      </g>
      <g fill="#EAEAEA" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1239">
        <rect x="110.69" y="11.23" width="19" height="4" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1240"/>
      </g>
      <g class="zoomslider_thumb" fill="#6A6A6A" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1241">
        <rect x="119.19" y="11.23" width="2" height="4" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1242"/>
      </g>
      <g fill="#EAEAEA" stroke-width="0.3" stroke-opacity="0" stroke="#6A6A6A" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1243">
        <rect x="106.19" y="11.23" width="4" height="4" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1244"/>
        <g class="button_logo" fill="#6A6A6A" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1245">
          <path d="M106.99,12.83 L 109.39 12.83 109.39 13.63 106.99 13.63 z" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1246"/>
        </g>
      </g>
    </g>
    <g class="geometry" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1247">
      <g stroke="#FFA500" fill="#000000" fill-opacity="0.000" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1248">
        <circle cx="77.57" cy="67.86" r="57.63" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1249"/>
      </g>
    </g>
  </g>
  <g class="guide ylabels" font-size="2.82" font-family="'PT Sans Caption','Helvetica Neue','Helvetica',sans-serif" fill="#6C606B" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1250">
    <text x="16.94" y="298.37" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1251" gadfly:scale="1.0" visibility="hidden">-2.0</text>
    <text x="16.94" y="240.74" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1252" gadfly:scale="1.0" visibility="hidden">-1.5</text>
    <text x="16.94" y="183.11" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1253" gadfly:scale="1.0" visibility="hidden">-1.0</text>
    <text x="16.94" y="125.48" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1254" gadfly:scale="1.0" visibility="visible">-0.5</text>
    <text x="16.94" y="67.86" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1255" gadfly:scale="1.0" visibility="visible">0.0</text>
    <text x="16.94" y="10.23" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1256" gadfly:scale="1.0" visibility="visible">0.5</text>
    <text x="16.94" y="-47.4" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1257" gadfly:scale="1.0" visibility="hidden">1.0</text>
    <text x="16.94" y="-105.02" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1258" gadfly:scale="1.0" visibility="hidden">1.5</text>
    <text x="16.94" y="-162.65" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1259" gadfly:scale="1.0" visibility="hidden">2.0</text>
    <text x="16.94" y="240.74" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1260" gadfly:scale="10.0" visibility="hidden">-1.50</text>
    <text x="16.94" y="234.98" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1261" gadfly:scale="10.0" visibility="hidden">-1.45</text>
    <text x="16.94" y="229.21" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1262" gadfly:scale="10.0" visibility="hidden">-1.40</text>
    <text x="16.94" y="223.45" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1263" gadfly:scale="10.0" visibility="hidden">-1.35</text>
    <text x="16.94" y="217.69" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1264" gadfly:scale="10.0" visibility="hidden">-1.30</text>
    <text x="16.94" y="211.93" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1265" gadfly:scale="10.0" visibility="hidden">-1.25</text>
    <text x="16.94" y="206.16" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1266" gadfly:scale="10.0" visibility="hidden">-1.20</text>
    <text x="16.94" y="200.4" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1267" gadfly:scale="10.0" visibility="hidden">-1.15</text>
    <text x="16.94" y="194.64" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1268" gadfly:scale="10.0" visibility="hidden">-1.10</text>
    <text x="16.94" y="188.87" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1269" gadfly:scale="10.0" visibility="hidden">-1.05</text>
    <text x="16.94" y="183.11" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1270" gadfly:scale="10.0" visibility="hidden">-1.00</text>
    <text x="16.94" y="177.35" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1271" gadfly:scale="10.0" visibility="hidden">-0.95</text>
    <text x="16.94" y="171.59" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1272" gadfly:scale="10.0" visibility="hidden">-0.90</text>
    <text x="16.94" y="165.82" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1273" gadfly:scale="10.0" visibility="hidden">-0.85</text>
    <text x="16.94" y="160.06" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1274" gadfly:scale="10.0" visibility="hidden">-0.80</text>
    <text x="16.94" y="154.3" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1275" gadfly:scale="10.0" visibility="hidden">-0.75</text>
    <text x="16.94" y="148.54" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1276" gadfly:scale="10.0" visibility="hidden">-0.70</text>
    <text x="16.94" y="142.77" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1277" gadfly:scale="10.0" visibility="hidden">-0.65</text>
    <text x="16.94" y="137.01" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1278" gadfly:scale="10.0" visibility="hidden">-0.60</text>
    <text x="16.94" y="131.25" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1279" gadfly:scale="10.0" visibility="hidden">-0.55</text>
    <text x="16.94" y="125.48" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1280" gadfly:scale="10.0" visibility="hidden">-0.50</text>
    <text x="16.94" y="119.72" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1281" gadfly:scale="10.0" visibility="hidden">-0.45</text>
    <text x="16.94" y="113.96" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1282" gadfly:scale="10.0" visibility="hidden">-0.40</text>
    <text x="16.94" y="108.2" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1283" gadfly:scale="10.0" visibility="hidden">-0.35</text>
    <text x="16.94" y="102.43" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1284" gadfly:scale="10.0" visibility="hidden">-0.30</text>
    <text x="16.94" y="96.67" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1285" gadfly:scale="10.0" visibility="hidden">-0.25</text>
    <text x="16.94" y="90.91" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1286" gadfly:scale="10.0" visibility="hidden">-0.20</text>
    <text x="16.94" y="85.15" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1287" gadfly:scale="10.0" visibility="hidden">-0.15</text>
    <text x="16.94" y="79.38" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1288" gadfly:scale="10.0" visibility="hidden">-0.10</text>
    <text x="16.94" y="73.62" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1289" gadfly:scale="10.0" visibility="hidden">-0.05</text>
    <text x="16.94" y="67.86" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1290" gadfly:scale="10.0" visibility="hidden">0.00</text>
    <text x="16.94" y="62.09" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1291" gadfly:scale="10.0" visibility="hidden">0.05</text>
    <text x="16.94" y="56.33" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1292" gadfly:scale="10.0" visibility="hidden">0.10</text>
    <text x="16.94" y="50.57" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1293" gadfly:scale="10.0" visibility="hidden">0.15</text>
    <text x="16.94" y="44.81" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1294" gadfly:scale="10.0" visibility="hidden">0.20</text>
    <text x="16.94" y="39.04" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1295" gadfly:scale="10.0" visibility="hidden">0.25</text>
    <text x="16.94" y="33.28" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1296" gadfly:scale="10.0" visibility="hidden">0.30</text>
    <text x="16.94" y="27.52" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1297" gadfly:scale="10.0" visibility="hidden">0.35</text>
    <text x="16.94" y="21.76" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1298" gadfly:scale="10.0" visibility="hidden">0.40</text>
    <text x="16.94" y="15.99" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1299" gadfly:scale="10.0" visibility="hidden">0.45</text>
    <text x="16.94" y="10.23" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1300" gadfly:scale="10.0" visibility="hidden">0.50</text>
    <text x="16.94" y="4.47" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1301" gadfly:scale="10.0" visibility="hidden">0.55</text>
    <text x="16.94" y="-1.3" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1302" gadfly:scale="10.0" visibility="hidden">0.60</text>
    <text x="16.94" y="-7.06" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1303" gadfly:scale="10.0" visibility="hidden">0.65</text>
    <text x="16.94" y="-12.82" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1304" gadfly:scale="10.0" visibility="hidden">0.70</text>
    <text x="16.94" y="-18.58" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1305" gadfly:scale="10.0" visibility="hidden">0.75</text>
    <text x="16.94" y="-24.35" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1306" gadfly:scale="10.0" visibility="hidden">0.80</text>
    <text x="16.94" y="-30.11" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1307" gadfly:scale="10.0" visibility="hidden">0.85</text>
    <text x="16.94" y="-35.87" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1308" gadfly:scale="10.0" visibility="hidden">0.90</text>
    <text x="16.94" y="-41.63" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1309" gadfly:scale="10.0" visibility="hidden">0.95</text>
    <text x="16.94" y="-47.4" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1310" gadfly:scale="10.0" visibility="hidden">1.00</text>
    <text x="16.94" y="-53.16" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1311" gadfly:scale="10.0" visibility="hidden">1.05</text>
    <text x="16.94" y="-58.92" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1312" gadfly:scale="10.0" visibility="hidden">1.10</text>
    <text x="16.94" y="-64.68" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1313" gadfly:scale="10.0" visibility="hidden">1.15</text>
    <text x="16.94" y="-70.45" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1314" gadfly:scale="10.0" visibility="hidden">1.20</text>
    <text x="16.94" y="-76.21" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1315" gadfly:scale="10.0" visibility="hidden">1.25</text>
    <text x="16.94" y="-81.97" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1316" gadfly:scale="10.0" visibility="hidden">1.30</text>
    <text x="16.94" y="-87.74" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1317" gadfly:scale="10.0" visibility="hidden">1.35</text>
    <text x="16.94" y="-93.5" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1318" gadfly:scale="10.0" visibility="hidden">1.40</text>
    <text x="16.94" y="-99.26" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1319" gadfly:scale="10.0" visibility="hidden">1.45</text>
    <text x="16.94" y="-105.02" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1320" gadfly:scale="10.0" visibility="hidden">1.50</text>
    <text x="16.94" y="298.37" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1321" gadfly:scale="0.5" visibility="hidden">-2</text>
    <text x="16.94" y="183.11" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1322" gadfly:scale="0.5" visibility="hidden">-1</text>
    <text x="16.94" y="67.86" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1323" gadfly:scale="0.5" visibility="hidden">0</text>
    <text x="16.94" y="-47.4" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1324" gadfly:scale="0.5" visibility="hidden">1</text>
    <text x="16.94" y="-162.65" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1325" gadfly:scale="0.5" visibility="hidden">2</text>
    <text x="16.94" y="240.74" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1326" gadfly:scale="5.0" visibility="hidden">-1.5</text>
    <text x="16.94" y="229.21" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1327" gadfly:scale="5.0" visibility="hidden">-1.4</text>
    <text x="16.94" y="217.69" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1328" gadfly:scale="5.0" visibility="hidden">-1.3</text>
    <text x="16.94" y="206.16" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1329" gadfly:scale="5.0" visibility="hidden">-1.2</text>
    <text x="16.94" y="194.64" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1330" gadfly:scale="5.0" visibility="hidden">-1.1</text>
    <text x="16.94" y="183.11" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1331" gadfly:scale="5.0" visibility="hidden">-1.0</text>
    <text x="16.94" y="171.59" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1332" gadfly:scale="5.0" visibility="hidden">-0.9</text>
    <text x="16.94" y="160.06" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1333" gadfly:scale="5.0" visibility="hidden">-0.8</text>
    <text x="16.94" y="148.54" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1334" gadfly:scale="5.0" visibility="hidden">-0.7</text>
    <text x="16.94" y="137.01" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1335" gadfly:scale="5.0" visibility="hidden">-0.6</text>
    <text x="16.94" y="125.48" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1336" gadfly:scale="5.0" visibility="hidden">-0.5</text>
    <text x="16.94" y="113.96" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1337" gadfly:scale="5.0" visibility="hidden">-0.4</text>
    <text x="16.94" y="102.43" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1338" gadfly:scale="5.0" visibility="hidden">-0.3</text>
    <text x="16.94" y="90.91" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1339" gadfly:scale="5.0" visibility="hidden">-0.2</text>
    <text x="16.94" y="79.38" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1340" gadfly:scale="5.0" visibility="hidden">-0.1</text>
    <text x="16.94" y="67.86" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1341" gadfly:scale="5.0" visibility="hidden">0.0</text>
    <text x="16.94" y="56.33" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1342" gadfly:scale="5.0" visibility="hidden">0.1</text>
    <text x="16.94" y="44.81" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1343" gadfly:scale="5.0" visibility="hidden">0.2</text>
    <text x="16.94" y="33.28" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1344" gadfly:scale="5.0" visibility="hidden">0.3</text>
    <text x="16.94" y="21.76" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1345" gadfly:scale="5.0" visibility="hidden">0.4</text>
    <text x="16.94" y="10.23" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1346" gadfly:scale="5.0" visibility="hidden">0.5</text>
    <text x="16.94" y="-1.3" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1347" gadfly:scale="5.0" visibility="hidden">0.6</text>
    <text x="16.94" y="-12.82" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1348" gadfly:scale="5.0" visibility="hidden">0.7</text>
    <text x="16.94" y="-24.35" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1349" gadfly:scale="5.0" visibility="hidden">0.8</text>
    <text x="16.94" y="-35.87" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1350" gadfly:scale="5.0" visibility="hidden">0.9</text>
    <text x="16.94" y="-47.4" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1351" gadfly:scale="5.0" visibility="hidden">1.0</text>
    <text x="16.94" y="-58.92" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1352" gadfly:scale="5.0" visibility="hidden">1.1</text>
    <text x="16.94" y="-70.45" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1353" gadfly:scale="5.0" visibility="hidden">1.2</text>
    <text x="16.94" y="-81.97" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1354" gadfly:scale="5.0" visibility="hidden">1.3</text>
    <text x="16.94" y="-93.5" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1355" gadfly:scale="5.0" visibility="hidden">1.4</text>
    <text x="16.94" y="-105.02" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1356" gadfly:scale="5.0" visibility="hidden">1.5</text>
  </g>
  <g font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" fill="#564A55" stroke="#000000" stroke-opacity="0.000" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1357">
    <text x="8.81" y="67.86" text-anchor="end" dy="0.35em" id="fig-7ca6750e949147c1bff9e7479e97a43d-element-1358">y</text>
  </g>
</g>
<defs>
<clipPath id="fig-7ca6750e949147c1bff9e7479e97a43d-element-14">
  <path d="M17.94,8.23 L 137.19 8.23 137.19 127.48 17.94 127.48" />
</clipPath
></defs>
<script> <![CDATA[
(function(N){var k=/[\.\/]/,L=/\s*,\s*/,C=function(a,d){return a-d},a,v,y={n:{}},M=function(){for(var a=0,d=this.length;a<d;a++)if("undefined"!=typeof this[a])return this[a]},A=function(){for(var a=this.length;--a;)if("undefined"!=typeof this[a])return this[a]},w=function(k,d){k=String(k);var f=v,n=Array.prototype.slice.call(arguments,2),u=w.listeners(k),p=0,b,q=[],e={},l=[],r=a;l.firstDefined=M;l.lastDefined=A;a=k;for(var s=v=0,x=u.length;s<x;s++)"zIndex"in u[s]&&(q.push(u[s].zIndex),0>u[s].zIndex&&
(e[u[s].zIndex]=u[s]));for(q.sort(C);0>q[p];)if(b=e[q[p++] ],l.push(b.apply(d,n)),v)return v=f,l;for(s=0;s<x;s++)if(b=u[s],"zIndex"in b)if(b.zIndex==q[p]){l.push(b.apply(d,n));if(v)break;do if(p++,(b=e[q[p] ])&&l.push(b.apply(d,n)),v)break;while(b)}else e[b.zIndex]=b;else if(l.push(b.apply(d,n)),v)break;v=f;a=r;return l};w._events=y;w.listeners=function(a){a=a.split(k);var d=y,f,n,u,p,b,q,e,l=[d],r=[];u=0;for(p=a.length;u<p;u++){e=[];b=0;for(q=l.length;b<q;b++)for(d=l[b].n,f=[d[a[u] ],d["*"] ],n=2;n--;)if(d=
f[n])e.push(d),r=r.concat(d.f||[]);l=e}return r};w.on=function(a,d){a=String(a);if("function"!=typeof d)return function(){};for(var f=a.split(L),n=0,u=f.length;n<u;n++)(function(a){a=a.split(k);for(var b=y,f,e=0,l=a.length;e<l;e++)b=b.n,b=b.hasOwnProperty(a[e])&&b[a[e] ]||(b[a[e] ]={n:{}});b.f=b.f||[];e=0;for(l=b.f.length;e<l;e++)if(b.f[e]==d){f=!0;break}!f&&b.f.push(d)})(f[n]);return function(a){+a==+a&&(d.zIndex=+a)}};w.f=function(a){var d=[].slice.call(arguments,1);return function(){w.apply(null,
[a,null].concat(d).concat([].slice.call(arguments,0)))}};w.stop=function(){v=1};w.nt=function(k){return k?(new RegExp("(?:\\.|\\/|^)"+k+"(?:\\.|\\/|$)")).test(a):a};w.nts=function(){return a.split(k)};w.off=w.unbind=function(a,d){if(a){var f=a.split(L);if(1<f.length)for(var n=0,u=f.length;n<u;n++)w.off(f[n],d);else{for(var f=a.split(k),p,b,q,e,l=[y],n=0,u=f.length;n<u;n++)for(e=0;e<l.length;e+=q.length-2){q=[e,1];p=l[e].n;if("*"!=f[n])p[f[n] ]&&q.push(p[f[n] ]);else for(b in p)p.hasOwnProperty(b)&&
q.push(p[b]);l.splice.apply(l,q)}n=0;for(u=l.length;n<u;n++)for(p=l[n];p.n;){if(d){if(p.f){e=0;for(f=p.f.length;e<f;e++)if(p.f[e]==d){p.f.splice(e,1);break}!p.f.length&&delete p.f}for(b in p.n)if(p.n.hasOwnProperty(b)&&p.n[b].f){q=p.n[b].f;e=0;for(f=q.length;e<f;e++)if(q[e]==d){q.splice(e,1);break}!q.length&&delete p.n[b].f}}else for(b in delete p.f,p.n)p.n.hasOwnProperty(b)&&p.n[b].f&&delete p.n[b].f;p=p.n}}}else w._events=y={n:{}}};w.once=function(a,d){var f=function(){w.unbind(a,f);return d.apply(this,
arguments)};return w.on(a,f)};w.version="0.4.2";w.toString=function(){return"You are running Eve 0.4.2"};"undefined"!=typeof module&&module.exports?module.exports=w:"function"===typeof define&&define.amd?define("eve",[],function(){return w}):N.eve=w})(this);
(function(N,k){"function"===typeof define&&define.amd?define("Snap.svg",["eve"],function(L){return k(N,L)}):k(N,N.eve)})(this,function(N,k){var L=function(a){var k={},y=N.requestAnimationFrame||N.webkitRequestAnimationFrame||N.mozRequestAnimationFrame||N.oRequestAnimationFrame||N.msRequestAnimationFrame||function(a){setTimeout(a,16)},M=Array.isArray||function(a){return a instanceof Array||"[object Array]"==Object.prototype.toString.call(a)},A=0,w="M"+(+new Date).toString(36),z=function(a){if(null==
a)return this.s;var b=this.s-a;this.b+=this.dur*b;this.B+=this.dur*b;this.s=a},d=function(a){if(null==a)return this.spd;this.spd=a},f=function(a){if(null==a)return this.dur;this.s=this.s*a/this.dur;this.dur=a},n=function(){delete k[this.id];this.update();a("mina.stop."+this.id,this)},u=function(){this.pdif||(delete k[this.id],this.update(),this.pdif=this.get()-this.b)},p=function(){this.pdif&&(this.b=this.get()-this.pdif,delete this.pdif,k[this.id]=this)},b=function(){var a;if(M(this.start)){a=[];
for(var b=0,e=this.start.length;b<e;b++)a[b]=+this.start[b]+(this.end[b]-this.start[b])*this.easing(this.s)}else a=+this.start+(this.end-this.start)*this.easing(this.s);this.set(a)},q=function(){var l=0,b;for(b in k)if(k.hasOwnProperty(b)){var e=k[b],f=e.get();l++;e.s=(f-e.b)/(e.dur/e.spd);1<=e.s&&(delete k[b],e.s=1,l--,function(b){setTimeout(function(){a("mina.finish."+b.id,b)})}(e));e.update()}l&&y(q)},e=function(a,r,s,x,G,h,J){a={id:w+(A++).toString(36),start:a,end:r,b:s,s:0,dur:x-s,spd:1,get:G,
set:h,easing:J||e.linear,status:z,speed:d,duration:f,stop:n,pause:u,resume:p,update:b};k[a.id]=a;r=0;for(var K in k)if(k.hasOwnProperty(K)&&(r++,2==r))break;1==r&&y(q);return a};e.time=Date.now||function(){return+new Date};e.getById=function(a){return k[a]||null};e.linear=function(a){return a};e.easeout=function(a){return Math.pow(a,1.7)};e.easein=function(a){return Math.pow(a,0.48)};e.easeinout=function(a){if(1==a)return 1;if(0==a)return 0;var b=0.48-a/1.04,e=Math.sqrt(0.1734+b*b);a=e-b;a=Math.pow(Math.abs(a),
1/3)*(0>a?-1:1);b=-e-b;b=Math.pow(Math.abs(b),1/3)*(0>b?-1:1);a=a+b+0.5;return 3*(1-a)*a*a+a*a*a};e.backin=function(a){return 1==a?1:a*a*(2.70158*a-1.70158)};e.backout=function(a){if(0==a)return 0;a-=1;return a*a*(2.70158*a+1.70158)+1};e.elastic=function(a){return a==!!a?a:Math.pow(2,-10*a)*Math.sin(2*(a-0.075)*Math.PI/0.3)+1};e.bounce=function(a){a<1/2.75?a*=7.5625*a:a<2/2.75?(a-=1.5/2.75,a=7.5625*a*a+0.75):a<2.5/2.75?(a-=2.25/2.75,a=7.5625*a*a+0.9375):(a-=2.625/2.75,a=7.5625*a*a+0.984375);return a};
return N.mina=e}("undefined"==typeof k?function(){}:k),C=function(){function a(c,t){if(c){if(c.tagName)return x(c);if(y(c,"array")&&a.set)return a.set.apply(a,c);if(c instanceof e)return c;if(null==t)return c=G.doc.querySelector(c),x(c)}return new s(null==c?"100%":c,null==t?"100%":t)}function v(c,a){if(a){"#text"==c&&(c=G.doc.createTextNode(a.text||""));"string"==typeof c&&(c=v(c));if("string"==typeof a)return"xlink:"==a.substring(0,6)?c.getAttributeNS(m,a.substring(6)):"xml:"==a.substring(0,4)?c.getAttributeNS(la,
a.substring(4)):c.getAttribute(a);for(var da in a)if(a[h](da)){var b=J(a[da]);b?"xlink:"==da.substring(0,6)?c.setAttributeNS(m,da.substring(6),b):"xml:"==da.substring(0,4)?c.setAttributeNS(la,da.substring(4),b):c.setAttribute(da,b):c.removeAttribute(da)}}else c=G.doc.createElementNS(la,c);return c}function y(c,a){a=J.prototype.toLowerCase.call(a);return"finite"==a?isFinite(c):"array"==a&&(c instanceof Array||Array.isArray&&Array.isArray(c))?!0:"null"==a&&null===c||a==typeof c&&null!==c||"object"==
a&&c===Object(c)||$.call(c).slice(8,-1).toLowerCase()==a}function M(c){if("function"==typeof c||Object(c)!==c)return c;var a=new c.constructor,b;for(b in c)c[h](b)&&(a[b]=M(c[b]));return a}function A(c,a,b){function m(){var e=Array.prototype.slice.call(arguments,0),f=e.join("\u2400"),d=m.cache=m.cache||{},l=m.count=m.count||[];if(d[h](f)){a:for(var e=l,l=f,B=0,H=e.length;B<H;B++)if(e[B]===l){e.push(e.splice(B,1)[0]);break a}return b?b(d[f]):d[f]}1E3<=l.length&&delete d[l.shift()];l.push(f);d[f]=c.apply(a,
e);return b?b(d[f]):d[f]}return m}function w(c,a,b,m,e,f){return null==e?(c-=b,a-=m,c||a?(180*I.atan2(-a,-c)/C+540)%360:0):w(c,a,e,f)-w(b,m,e,f)}function z(c){return c%360*C/180}function d(c){var a=[];c=c.replace(/(?:^|\s)(\w+)\(([^)]+)\)/g,function(c,b,m){m=m.split(/\s*,\s*|\s+/);"rotate"==b&&1==m.length&&m.push(0,0);"scale"==b&&(2<m.length?m=m.slice(0,2):2==m.length&&m.push(0,0),1==m.length&&m.push(m[0],0,0));"skewX"==b?a.push(["m",1,0,I.tan(z(m[0])),1,0,0]):"skewY"==b?a.push(["m",1,I.tan(z(m[0])),
0,1,0,0]):a.push([b.charAt(0)].concat(m));return c});return a}function f(c,t){var b=O(c),m=new a.Matrix;if(b)for(var e=0,f=b.length;e<f;e++){var h=b[e],d=h.length,B=J(h[0]).toLowerCase(),H=h[0]!=B,l=H?m.invert():0,E;"t"==B&&2==d?m.translate(h[1],0):"t"==B&&3==d?H?(d=l.x(0,0),B=l.y(0,0),H=l.x(h[1],h[2]),l=l.y(h[1],h[2]),m.translate(H-d,l-B)):m.translate(h[1],h[2]):"r"==B?2==d?(E=E||t,m.rotate(h[1],E.x+E.width/2,E.y+E.height/2)):4==d&&(H?(H=l.x(h[2],h[3]),l=l.y(h[2],h[3]),m.rotate(h[1],H,l)):m.rotate(h[1],
h[2],h[3])):"s"==B?2==d||3==d?(E=E||t,m.scale(h[1],h[d-1],E.x+E.width/2,E.y+E.height/2)):4==d?H?(H=l.x(h[2],h[3]),l=l.y(h[2],h[3]),m.scale(h[1],h[1],H,l)):m.scale(h[1],h[1],h[2],h[3]):5==d&&(H?(H=l.x(h[3],h[4]),l=l.y(h[3],h[4]),m.scale(h[1],h[2],H,l)):m.scale(h[1],h[2],h[3],h[4])):"m"==B&&7==d&&m.add(h[1],h[2],h[3],h[4],h[5],h[6])}return m}function n(c,t){if(null==t){var m=!0;t="linearGradient"==c.type||"radialGradient"==c.type?c.node.getAttribute("gradientTransform"):"pattern"==c.type?c.node.getAttribute("patternTransform"):
c.node.getAttribute("transform");if(!t)return new a.Matrix;t=d(t)}else t=a._.rgTransform.test(t)?J(t).replace(/\.{3}|\u2026/g,c._.transform||aa):d(t),y(t,"array")&&(t=a.path?a.path.toString.call(t):J(t)),c._.transform=t;var b=f(t,c.getBBox(1));if(m)return b;c.matrix=b}function u(c){c=c.node.ownerSVGElement&&x(c.node.ownerSVGElement)||c.node.parentNode&&x(c.node.parentNode)||a.select("svg")||a(0,0);var t=c.select("defs"),t=null==t?!1:t.node;t||(t=r("defs",c.node).node);return t}function p(c){return c.node.ownerSVGElement&&
x(c.node.ownerSVGElement)||a.select("svg")}function b(c,a,m){function b(c){if(null==c)return aa;if(c==+c)return c;v(B,{width:c});try{return B.getBBox().width}catch(a){return 0}}function h(c){if(null==c)return aa;if(c==+c)return c;v(B,{height:c});try{return B.getBBox().height}catch(a){return 0}}function e(b,B){null==a?d[b]=B(c.attr(b)||0):b==a&&(d=B(null==m?c.attr(b)||0:m))}var f=p(c).node,d={},B=f.querySelector(".svg---mgr");B||(B=v("rect"),v(B,{x:-9E9,y:-9E9,width:10,height:10,"class":"svg---mgr",
fill:"none"}),f.appendChild(B));switch(c.type){case "rect":e("rx",b),e("ry",h);case "image":e("width",b),e("height",h);case "text":e("x",b);e("y",h);break;case "circle":e("cx",b);e("cy",h);e("r",b);break;case "ellipse":e("cx",b);e("cy",h);e("rx",b);e("ry",h);break;case "line":e("x1",b);e("x2",b);e("y1",h);e("y2",h);break;case "marker":e("refX",b);e("markerWidth",b);e("refY",h);e("markerHeight",h);break;case "radialGradient":e("fx",b);e("fy",h);break;case "tspan":e("dx",b);e("dy",h);break;default:e(a,
b)}f.removeChild(B);return d}function q(c){y(c,"array")||(c=Array.prototype.slice.call(arguments,0));for(var a=0,b=0,m=this.node;this[a];)delete this[a++];for(a=0;a<c.length;a++)"set"==c[a].type?c[a].forEach(function(c){m.appendChild(c.node)}):m.appendChild(c[a].node);for(var h=m.childNodes,a=0;a<h.length;a++)this[b++]=x(h[a]);return this}function e(c){if(c.snap in E)return E[c.snap];var a=this.id=V(),b;try{b=c.ownerSVGElement}catch(m){}this.node=c;b&&(this.paper=new s(b));this.type=c.tagName;this.anims=
{};this._={transform:[]};c.snap=a;E[a]=this;"g"==this.type&&(this.add=q);if(this.type in{g:1,mask:1,pattern:1})for(var e in s.prototype)s.prototype[h](e)&&(this[e]=s.prototype[e])}function l(c){this.node=c}function r(c,a){var b=v(c);a.appendChild(b);return x(b)}function s(c,a){var b,m,f,d=s.prototype;if(c&&"svg"==c.tagName){if(c.snap in E)return E[c.snap];var l=c.ownerDocument;b=new e(c);m=c.getElementsByTagName("desc")[0];f=c.getElementsByTagName("defs")[0];m||(m=v("desc"),m.appendChild(l.createTextNode("Created with Snap")),
b.node.appendChild(m));f||(f=v("defs"),b.node.appendChild(f));b.defs=f;for(var ca in d)d[h](ca)&&(b[ca]=d[ca]);b.paper=b.root=b}else b=r("svg",G.doc.body),v(b.node,{height:a,version:1.1,width:c,xmlns:la});return b}function x(c){return!c||c instanceof e||c instanceof l?c:c.tagName&&"svg"==c.tagName.toLowerCase()?new s(c):c.tagName&&"object"==c.tagName.toLowerCase()&&"image/svg+xml"==c.type?new s(c.contentDocument.getElementsByTagName("svg")[0]):new e(c)}a.version="0.3.0";a.toString=function(){return"Snap v"+
this.version};a._={};var G={win:N,doc:N.document};a._.glob=G;var h="hasOwnProperty",J=String,K=parseFloat,U=parseInt,I=Math,P=I.max,Q=I.min,Y=I.abs,C=I.PI,aa="",$=Object.prototype.toString,F=/^\s*((#[a-f\d]{6})|(#[a-f\d]{3})|rgba?\(\s*([\d\.]+%?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+%?(?:\s*,\s*[\d\.]+%?)?)\s*\)|hsba?\(\s*([\d\.]+(?:deg|\xb0|%)?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+(?:%?\s*,\s*[\d\.]+)?%?)\s*\)|hsla?\(\s*([\d\.]+(?:deg|\xb0|%)?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+(?:%?\s*,\s*[\d\.]+)?%?)\s*\))\s*$/i;a._.separator=
RegExp("[,\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]+");var S=RegExp("[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*"),X={hs:1,rg:1},W=RegExp("([a-z])[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029,]*((-?\\d*\\.?\\d*(?:e[\\-+]?\\d+)?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*)+)",
"ig"),ma=RegExp("([rstm])[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029,]*((-?\\d*\\.?\\d*(?:e[\\-+]?\\d+)?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*)+)","ig"),Z=RegExp("(-?\\d*\\.?\\d*(?:e[\\-+]?\\d+)?)[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*",
"ig"),na=0,ba="S"+(+new Date).toString(36),V=function(){return ba+(na++).toString(36)},m="http://www.w3.org/1999/xlink",la="http://www.w3.org/2000/svg",E={},ca=a.url=function(c){return"url('#"+c+"')"};a._.$=v;a._.id=V;a.format=function(){var c=/\{([^\}]+)\}/g,a=/(?:(?:^|\.)(.+?)(?=\[|\.|$|\()|\[('|")(.+?)\2\])(\(\))?/g,b=function(c,b,m){var h=m;b.replace(a,function(c,a,b,m,t){a=a||m;h&&(a in h&&(h=h[a]),"function"==typeof h&&t&&(h=h()))});return h=(null==h||h==m?c:h)+""};return function(a,m){return J(a).replace(c,
function(c,a){return b(c,a,m)})}}();a._.clone=M;a._.cacher=A;a.rad=z;a.deg=function(c){return 180*c/C%360};a.angle=w;a.is=y;a.snapTo=function(c,a,b){b=y(b,"finite")?b:10;if(y(c,"array"))for(var m=c.length;m--;){if(Y(c[m]-a)<=b)return c[m]}else{c=+c;m=a%c;if(m<b)return a-m;if(m>c-b)return a-m+c}return a};a.getRGB=A(function(c){if(!c||(c=J(c)).indexOf("-")+1)return{r:-1,g:-1,b:-1,hex:"none",error:1,toString:ka};if("none"==c)return{r:-1,g:-1,b:-1,hex:"none",toString:ka};!X[h](c.toLowerCase().substring(0,
2))&&"#"!=c.charAt()&&(c=T(c));if(!c)return{r:-1,g:-1,b:-1,hex:"none",error:1,toString:ka};var b,m,e,f,d;if(c=c.match(F)){c[2]&&(e=U(c[2].substring(5),16),m=U(c[2].substring(3,5),16),b=U(c[2].substring(1,3),16));c[3]&&(e=U((d=c[3].charAt(3))+d,16),m=U((d=c[3].charAt(2))+d,16),b=U((d=c[3].charAt(1))+d,16));c[4]&&(d=c[4].split(S),b=K(d[0]),"%"==d[0].slice(-1)&&(b*=2.55),m=K(d[1]),"%"==d[1].slice(-1)&&(m*=2.55),e=K(d[2]),"%"==d[2].slice(-1)&&(e*=2.55),"rgba"==c[1].toLowerCase().slice(0,4)&&(f=K(d[3])),
d[3]&&"%"==d[3].slice(-1)&&(f/=100));if(c[5])return d=c[5].split(S),b=K(d[0]),"%"==d[0].slice(-1)&&(b/=100),m=K(d[1]),"%"==d[1].slice(-1)&&(m/=100),e=K(d[2]),"%"==d[2].slice(-1)&&(e/=100),"deg"!=d[0].slice(-3)&&"\u00b0"!=d[0].slice(-1)||(b/=360),"hsba"==c[1].toLowerCase().slice(0,4)&&(f=K(d[3])),d[3]&&"%"==d[3].slice(-1)&&(f/=100),a.hsb2rgb(b,m,e,f);if(c[6])return d=c[6].split(S),b=K(d[0]),"%"==d[0].slice(-1)&&(b/=100),m=K(d[1]),"%"==d[1].slice(-1)&&(m/=100),e=K(d[2]),"%"==d[2].slice(-1)&&(e/=100),
"deg"!=d[0].slice(-3)&&"\u00b0"!=d[0].slice(-1)||(b/=360),"hsla"==c[1].toLowerCase().slice(0,4)&&(f=K(d[3])),d[3]&&"%"==d[3].slice(-1)&&(f/=100),a.hsl2rgb(b,m,e,f);b=Q(I.round(b),255);m=Q(I.round(m),255);e=Q(I.round(e),255);f=Q(P(f,0),1);c={r:b,g:m,b:e,toString:ka};c.hex="#"+(16777216|e|m<<8|b<<16).toString(16).slice(1);c.opacity=y(f,"finite")?f:1;return c}return{r:-1,g:-1,b:-1,hex:"none",error:1,toString:ka}},a);a.hsb=A(function(c,b,m){return a.hsb2rgb(c,b,m).hex});a.hsl=A(function(c,b,m){return a.hsl2rgb(c,
b,m).hex});a.rgb=A(function(c,a,b,m){if(y(m,"finite")){var e=I.round;return"rgba("+[e(c),e(a),e(b),+m.toFixed(2)]+")"}return"#"+(16777216|b|a<<8|c<<16).toString(16).slice(1)});var T=function(c){var a=G.doc.getElementsByTagName("head")[0]||G.doc.getElementsByTagName("svg")[0];T=A(function(c){if("red"==c.toLowerCase())return"rgb(255, 0, 0)";a.style.color="rgb(255, 0, 0)";a.style.color=c;c=G.doc.defaultView.getComputedStyle(a,aa).getPropertyValue("color");return"rgb(255, 0, 0)"==c?null:c});return T(c)},
qa=function(){return"hsb("+[this.h,this.s,this.b]+")"},ra=function(){return"hsl("+[this.h,this.s,this.l]+")"},ka=function(){return 1==this.opacity||null==this.opacity?this.hex:"rgba("+[this.r,this.g,this.b,this.opacity]+")"},D=function(c,b,m){null==b&&y(c,"object")&&"r"in c&&"g"in c&&"b"in c&&(m=c.b,b=c.g,c=c.r);null==b&&y(c,string)&&(m=a.getRGB(c),c=m.r,b=m.g,m=m.b);if(1<c||1<b||1<m)c/=255,b/=255,m/=255;return[c,b,m]},oa=function(c,b,m,e){c=I.round(255*c);b=I.round(255*b);m=I.round(255*m);c={r:c,
g:b,b:m,opacity:y(e,"finite")?e:1,hex:a.rgb(c,b,m),toString:ka};y(e,"finite")&&(c.opacity=e);return c};a.color=function(c){var b;y(c,"object")&&"h"in c&&"s"in c&&"b"in c?(b=a.hsb2rgb(c),c.r=b.r,c.g=b.g,c.b=b.b,c.opacity=1,c.hex=b.hex):y(c,"object")&&"h"in c&&"s"in c&&"l"in c?(b=a.hsl2rgb(c),c.r=b.r,c.g=b.g,c.b=b.b,c.opacity=1,c.hex=b.hex):(y(c,"string")&&(c=a.getRGB(c)),y(c,"object")&&"r"in c&&"g"in c&&"b"in c&&!("error"in c)?(b=a.rgb2hsl(c),c.h=b.h,c.s=b.s,c.l=b.l,b=a.rgb2hsb(c),c.v=b.b):(c={hex:"none"},
c.r=c.g=c.b=c.h=c.s=c.v=c.l=-1,c.error=1));c.toString=ka;return c};a.hsb2rgb=function(c,a,b,m){y(c,"object")&&"h"in c&&"s"in c&&"b"in c&&(b=c.b,a=c.s,c=c.h,m=c.o);var e,h,d;c=360*c%360/60;d=b*a;a=d*(1-Y(c%2-1));b=e=h=b-d;c=~~c;b+=[d,a,0,0,a,d][c];e+=[a,d,d,a,0,0][c];h+=[0,0,a,d,d,a][c];return oa(b,e,h,m)};a.hsl2rgb=function(c,a,b,m){y(c,"object")&&"h"in c&&"s"in c&&"l"in c&&(b=c.l,a=c.s,c=c.h);if(1<c||1<a||1<b)c/=360,a/=100,b/=100;var e,h,d;c=360*c%360/60;d=2*a*(0.5>b?b:1-b);a=d*(1-Y(c%2-1));b=e=
h=b-d/2;c=~~c;b+=[d,a,0,0,a,d][c];e+=[a,d,d,a,0,0][c];h+=[0,0,a,d,d,a][c];return oa(b,e,h,m)};a.rgb2hsb=function(c,a,b){b=D(c,a,b);c=b[0];a=b[1];b=b[2];var m,e;m=P(c,a,b);e=m-Q(c,a,b);c=((0==e?0:m==c?(a-b)/e:m==a?(b-c)/e+2:(c-a)/e+4)+360)%6*60/360;return{h:c,s:0==e?0:e/m,b:m,toString:qa}};a.rgb2hsl=function(c,a,b){b=D(c,a,b);c=b[0];a=b[1];b=b[2];var m,e,h;m=P(c,a,b);e=Q(c,a,b);h=m-e;c=((0==h?0:m==c?(a-b)/h:m==a?(b-c)/h+2:(c-a)/h+4)+360)%6*60/360;m=(m+e)/2;return{h:c,s:0==h?0:0.5>m?h/(2*m):h/(2-2*
m),l:m,toString:ra}};a.parsePathString=function(c){if(!c)return null;var b=a.path(c);if(b.arr)return a.path.clone(b.arr);var m={a:7,c:6,o:2,h:1,l:2,m:2,r:4,q:4,s:4,t:2,v:1,u:3,z:0},e=[];y(c,"array")&&y(c[0],"array")&&(e=a.path.clone(c));e.length||J(c).replace(W,function(c,a,b){var h=[];c=a.toLowerCase();b.replace(Z,function(c,a){a&&h.push(+a)});"m"==c&&2<h.length&&(e.push([a].concat(h.splice(0,2))),c="l",a="m"==a?"l":"L");"o"==c&&1==h.length&&e.push([a,h[0] ]);if("r"==c)e.push([a].concat(h));else for(;h.length>=
m[c]&&(e.push([a].concat(h.splice(0,m[c]))),m[c]););});e.toString=a.path.toString;b.arr=a.path.clone(e);return e};var O=a.parseTransformString=function(c){if(!c)return null;var b=[];y(c,"array")&&y(c[0],"array")&&(b=a.path.clone(c));b.length||J(c).replace(ma,function(c,a,m){var e=[];a.toLowerCase();m.replace(Z,function(c,a){a&&e.push(+a)});b.push([a].concat(e))});b.toString=a.path.toString;return b};a._.svgTransform2string=d;a._.rgTransform=RegExp("^[a-z][\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*-?\\.?\\d",
"i");a._.transform2matrix=f;a._unit2px=b;a._.getSomeDefs=u;a._.getSomeSVG=p;a.select=function(c){return x(G.doc.querySelector(c))};a.selectAll=function(c){c=G.doc.querySelectorAll(c);for(var b=(a.set||Array)(),m=0;m<c.length;m++)b.push(x(c[m]));return b};setInterval(function(){for(var c in E)if(E[h](c)){var a=E[c],b=a.node;("svg"!=a.type&&!b.ownerSVGElement||"svg"==a.type&&(!b.parentNode||"ownerSVGElement"in b.parentNode&&!b.ownerSVGElement))&&delete E[c]}},1E4);(function(c){function m(c){function a(c,
b){var m=v(c.node,b);(m=(m=m&&m.match(d))&&m[2])&&"#"==m.charAt()&&(m=m.substring(1))&&(f[m]=(f[m]||[]).concat(function(a){var m={};m[b]=ca(a);v(c.node,m)}))}function b(c){var a=v(c.node,"xlink:href");a&&"#"==a.charAt()&&(a=a.substring(1))&&(f[a]=(f[a]||[]).concat(function(a){c.attr("xlink:href","#"+a)}))}var e=c.selectAll("*"),h,d=/^\s*url\(("|'|)(.*)\1\)\s*$/;c=[];for(var f={},l=0,E=e.length;l<E;l++){h=e[l];a(h,"fill");a(h,"stroke");a(h,"filter");a(h,"mask");a(h,"clip-path");b(h);var t=v(h.node,
"id");t&&(v(h.node,{id:h.id}),c.push({old:t,id:h.id}))}l=0;for(E=c.length;l<E;l++)if(e=f[c[l].old])for(h=0,t=e.length;h<t;h++)e[h](c[l].id)}function e(c,a,b){return function(m){m=m.slice(c,a);1==m.length&&(m=m[0]);return b?b(m):m}}function d(c){return function(){var a=c?"<"+this.type:"",b=this.node.attributes,m=this.node.childNodes;if(c)for(var e=0,h=b.length;e<h;e++)a+=" "+b[e].name+'="'+b[e].value.replace(/"/g,'\\"')+'"';if(m.length){c&&(a+=">");e=0;for(h=m.length;e<h;e++)3==m[e].nodeType?a+=m[e].nodeValue:
1==m[e].nodeType&&(a+=x(m[e]).toString());c&&(a+="</"+this.type+">")}else c&&(a+="/>");return a}}c.attr=function(c,a){if(!c)return this;if(y(c,"string"))if(1<arguments.length){var b={};b[c]=a;c=b}else return k("snap.util.getattr."+c,this).firstDefined();for(var m in c)c[h](m)&&k("snap.util.attr."+m,this,c[m]);return this};c.getBBox=function(c){if(!a.Matrix||!a.path)return this.node.getBBox();var b=this,m=new a.Matrix;if(b.removed)return a._.box();for(;"use"==b.type;)if(c||(m=m.add(b.transform().localMatrix.translate(b.attr("x")||
0,b.attr("y")||0))),b.original)b=b.original;else var e=b.attr("xlink:href"),b=b.original=b.node.ownerDocument.getElementById(e.substring(e.indexOf("#")+1));var e=b._,h=a.path.get[b.type]||a.path.get.deflt;try{if(c)return e.bboxwt=h?a.path.getBBox(b.realPath=h(b)):a._.box(b.node.getBBox()),a._.box(e.bboxwt);b.realPath=h(b);b.matrix=b.transform().localMatrix;e.bbox=a.path.getBBox(a.path.map(b.realPath,m.add(b.matrix)));return a._.box(e.bbox)}catch(d){return a._.box()}};var f=function(){return this.string};
c.transform=function(c){var b=this._;if(null==c){var m=this;c=new a.Matrix(this.node.getCTM());for(var e=n(this),h=[e],d=new a.Matrix,l=e.toTransformString(),b=J(e)==J(this.matrix)?J(b.transform):l;"svg"!=m.type&&(m=m.parent());)h.push(n(m));for(m=h.length;m--;)d.add(h[m]);return{string:b,globalMatrix:c,totalMatrix:d,localMatrix:e,diffMatrix:c.clone().add(e.invert()),global:c.toTransformString(),total:d.toTransformString(),local:l,toString:f}}c instanceof a.Matrix?this.matrix=c:n(this,c);this.node&&
("linearGradient"==this.type||"radialGradient"==this.type?v(this.node,{gradientTransform:this.matrix}):"pattern"==this.type?v(this.node,{patternTransform:this.matrix}):v(this.node,{transform:this.matrix}));return this};c.parent=function(){return x(this.node.parentNode)};c.append=c.add=function(c){if(c){if("set"==c.type){var a=this;c.forEach(function(c){a.add(c)});return this}c=x(c);this.node.appendChild(c.node);c.paper=this.paper}return this};c.appendTo=function(c){c&&(c=x(c),c.append(this));return this};
c.prepend=function(c){if(c){if("set"==c.type){var a=this,b;c.forEach(function(c){b?b.after(c):a.prepend(c);b=c});return this}c=x(c);var m=c.parent();this.node.insertBefore(c.node,this.node.firstChild);this.add&&this.add();c.paper=this.paper;this.parent()&&this.parent().add();m&&m.add()}return this};c.prependTo=function(c){c=x(c);c.prepend(this);return this};c.before=function(c){if("set"==c.type){var a=this;c.forEach(function(c){var b=c.parent();a.node.parentNode.insertBefore(c.node,a.node);b&&b.add()});
this.parent().add();return this}c=x(c);var b=c.parent();this.node.parentNode.insertBefore(c.node,this.node);this.parent()&&this.parent().add();b&&b.add();c.paper=this.paper;return this};c.after=function(c){c=x(c);var a=c.parent();this.node.nextSibling?this.node.parentNode.insertBefore(c.node,this.node.nextSibling):this.node.parentNode.appendChild(c.node);this.parent()&&this.parent().add();a&&a.add();c.paper=this.paper;return this};c.insertBefore=function(c){c=x(c);var a=this.parent();c.node.parentNode.insertBefore(this.node,
c.node);this.paper=c.paper;a&&a.add();c.parent()&&c.parent().add();return this};c.insertAfter=function(c){c=x(c);var a=this.parent();c.node.parentNode.insertBefore(this.node,c.node.nextSibling);this.paper=c.paper;a&&a.add();c.parent()&&c.parent().add();return this};c.remove=function(){var c=this.parent();this.node.parentNode&&this.node.parentNode.removeChild(this.node);delete this.paper;this.removed=!0;c&&c.add();return this};c.select=function(c){return x(this.node.querySelector(c))};c.selectAll=
function(c){c=this.node.querySelectorAll(c);for(var b=(a.set||Array)(),m=0;m<c.length;m++)b.push(x(c[m]));return b};c.asPX=function(c,a){null==a&&(a=this.attr(c));return+b(this,c,a)};c.use=function(){var c,a=this.node.id;a||(a=this.id,v(this.node,{id:a}));c="linearGradient"==this.type||"radialGradient"==this.type||"pattern"==this.type?r(this.type,this.node.parentNode):r("use",this.node.parentNode);v(c.node,{"xlink:href":"#"+a});c.original=this;return c};var l=/\S+/g;c.addClass=function(c){var a=(c||
"").match(l)||[];c=this.node;var b=c.className.baseVal,m=b.match(l)||[],e,h,d;if(a.length){for(e=0;d=a[e++];)h=m.indexOf(d),~h||m.push(d);a=m.join(" ");b!=a&&(c.className.baseVal=a)}return this};c.removeClass=function(c){var a=(c||"").match(l)||[];c=this.node;var b=c.className.baseVal,m=b.match(l)||[],e,h;if(m.length){for(e=0;h=a[e++];)h=m.indexOf(h),~h&&m.splice(h,1);a=m.join(" ");b!=a&&(c.className.baseVal=a)}return this};c.hasClass=function(c){return!!~(this.node.className.baseVal.match(l)||[]).indexOf(c)};
c.toggleClass=function(c,a){if(null!=a)return a?this.addClass(c):this.removeClass(c);var b=(c||"").match(l)||[],m=this.node,e=m.className.baseVal,h=e.match(l)||[],d,f,E;for(d=0;E=b[d++];)f=h.indexOf(E),~f?h.splice(f,1):h.push(E);b=h.join(" ");e!=b&&(m.className.baseVal=b);return this};c.clone=function(){var c=x(this.node.cloneNode(!0));v(c.node,"id")&&v(c.node,{id:c.id});m(c);c.insertAfter(this);return c};c.toDefs=function(){u(this).appendChild(this.node);return this};c.pattern=c.toPattern=function(c,
a,b,m){var e=r("pattern",u(this));null==c&&(c=this.getBBox());y(c,"object")&&"x"in c&&(a=c.y,b=c.width,m=c.height,c=c.x);v(e.node,{x:c,y:a,width:b,height:m,patternUnits:"userSpaceOnUse",id:e.id,viewBox:[c,a,b,m].join(" ")});e.node.appendChild(this.node);return e};c.marker=function(c,a,b,m,e,h){var d=r("marker",u(this));null==c&&(c=this.getBBox());y(c,"object")&&"x"in c&&(a=c.y,b=c.width,m=c.height,e=c.refX||c.cx,h=c.refY||c.cy,c=c.x);v(d.node,{viewBox:[c,a,b,m].join(" "),markerWidth:b,markerHeight:m,
orient:"auto",refX:e||0,refY:h||0,id:d.id});d.node.appendChild(this.node);return d};var E=function(c,a,b,m){"function"!=typeof b||b.length||(m=b,b=L.linear);this.attr=c;this.dur=a;b&&(this.easing=b);m&&(this.callback=m)};a._.Animation=E;a.animation=function(c,a,b,m){return new E(c,a,b,m)};c.inAnim=function(){var c=[],a;for(a in this.anims)this.anims[h](a)&&function(a){c.push({anim:new E(a._attrs,a.dur,a.easing,a._callback),mina:a,curStatus:a.status(),status:function(c){return a.status(c)},stop:function(){a.stop()}})}(this.anims[a]);
return c};a.animate=function(c,a,b,m,e,h){"function"!=typeof e||e.length||(h=e,e=L.linear);var d=L.time();c=L(c,a,d,d+m,L.time,b,e);h&&k.once("mina.finish."+c.id,h);return c};c.stop=function(){for(var c=this.inAnim(),a=0,b=c.length;a<b;a++)c[a].stop();return this};c.animate=function(c,a,b,m){"function"!=typeof b||b.length||(m=b,b=L.linear);c instanceof E&&(m=c.callback,b=c.easing,a=b.dur,c=c.attr);var d=[],f=[],l={},t,ca,n,T=this,q;for(q in c)if(c[h](q)){T.equal?(n=T.equal(q,J(c[q])),t=n.from,ca=
n.to,n=n.f):(t=+T.attr(q),ca=+c[q]);var la=y(t,"array")?t.length:1;l[q]=e(d.length,d.length+la,n);d=d.concat(t);f=f.concat(ca)}t=L.time();var p=L(d,f,t,t+a,L.time,function(c){var a={},b;for(b in l)l[h](b)&&(a[b]=l[b](c));T.attr(a)},b);T.anims[p.id]=p;p._attrs=c;p._callback=m;k("snap.animcreated."+T.id,p);k.once("mina.finish."+p.id,function(){delete T.anims[p.id];m&&m.call(T)});k.once("mina.stop."+p.id,function(){delete T.anims[p.id]});return T};var T={};c.data=function(c,b){var m=T[this.id]=T[this.id]||
{};if(0==arguments.length)return k("snap.data.get."+this.id,this,m,null),m;if(1==arguments.length){if(a.is(c,"object")){for(var e in c)c[h](e)&&this.data(e,c[e]);return this}k("snap.data.get."+this.id,this,m[c],c);return m[c]}m[c]=b;k("snap.data.set."+this.id,this,b,c);return this};c.removeData=function(c){null==c?T[this.id]={}:T[this.id]&&delete T[this.id][c];return this};c.outerSVG=c.toString=d(1);c.innerSVG=d()})(e.prototype);a.parse=function(c){var a=G.doc.createDocumentFragment(),b=!0,m=G.doc.createElement("div");
c=J(c);c.match(/^\s*<\s*svg(?:\s|>)/)||(c="<svg>"+c+"</svg>",b=!1);m.innerHTML=c;if(c=m.getElementsByTagName("svg")[0])if(b)a=c;else for(;c.firstChild;)a.appendChild(c.firstChild);m.innerHTML=aa;return new l(a)};l.prototype.select=e.prototype.select;l.prototype.selectAll=e.prototype.selectAll;a.fragment=function(){for(var c=Array.prototype.slice.call(arguments,0),b=G.doc.createDocumentFragment(),m=0,e=c.length;m<e;m++){var h=c[m];h.node&&h.node.nodeType&&b.appendChild(h.node);h.nodeType&&b.appendChild(h);
"string"==typeof h&&b.appendChild(a.parse(h).node)}return new l(b)};a._.make=r;a._.wrap=x;s.prototype.el=function(c,a){var b=r(c,this.node);a&&b.attr(a);return b};k.on("snap.util.getattr",function(){var c=k.nt(),c=c.substring(c.lastIndexOf(".")+1),a=c.replace(/[A-Z]/g,function(c){return"-"+c.toLowerCase()});return pa[h](a)?this.node.ownerDocument.defaultView.getComputedStyle(this.node,null).getPropertyValue(a):v(this.node,c)});var pa={"alignment-baseline":0,"baseline-shift":0,clip:0,"clip-path":0,
"clip-rule":0,color:0,"color-interpolation":0,"color-interpolation-filters":0,"color-profile":0,"color-rendering":0,cursor:0,direction:0,display:0,"dominant-baseline":0,"enable-background":0,fill:0,"fill-opacity":0,"fill-rule":0,filter:0,"flood-color":0,"flood-opacity":0,font:0,"font-family":0,"font-size":0,"font-size-adjust":0,"font-stretch":0,"font-style":0,"font-variant":0,"font-weight":0,"glyph-orientation-horizontal":0,"glyph-orientation-vertical":0,"image-rendering":0,kerning:0,"letter-spacing":0,
"lighting-color":0,marker:0,"marker-end":0,"marker-mid":0,"marker-start":0,mask:0,opacity:0,overflow:0,"pointer-events":0,"shape-rendering":0,"stop-color":0,"stop-opacity":0,stroke:0,"stroke-dasharray":0,"stroke-dashoffset":0,"stroke-linecap":0,"stroke-linejoin":0,"stroke-miterlimit":0,"stroke-opacity":0,"stroke-width":0,"text-anchor":0,"text-decoration":0,"text-rendering":0,"unicode-bidi":0,visibility:0,"word-spacing":0,"writing-mode":0};k.on("snap.util.attr",function(c){var a=k.nt(),b={},a=a.substring(a.lastIndexOf(".")+
1);b[a]=c;var m=a.replace(/-(\w)/gi,function(c,a){return a.toUpperCase()}),a=a.replace(/[A-Z]/g,function(c){return"-"+c.toLowerCase()});pa[h](a)?this.node.style[m]=null==c?aa:c:v(this.node,b)});a.ajax=function(c,a,b,m){var e=new XMLHttpRequest,h=V();if(e){if(y(a,"function"))m=b,b=a,a=null;else if(y(a,"object")){var d=[],f;for(f in a)a.hasOwnProperty(f)&&d.push(encodeURIComponent(f)+"="+encodeURIComponent(a[f]));a=d.join("&")}e.open(a?"POST":"GET",c,!0);a&&(e.setRequestHeader("X-Requested-With","XMLHttpRequest"),
e.setRequestHeader("Content-type","application/x-www-form-urlencoded"));b&&(k.once("snap.ajax."+h+".0",b),k.once("snap.ajax."+h+".200",b),k.once("snap.ajax."+h+".304",b));e.onreadystatechange=function(){4==e.readyState&&k("snap.ajax."+h+"."+e.status,m,e)};if(4==e.readyState)return e;e.send(a);return e}};a.load=function(c,b,m){a.ajax(c,function(c){c=a.parse(c.responseText);m?b.call(m,c):b(c)})};a.getElementByPoint=function(c,a){var b,m,e=G.doc.elementFromPoint(c,a);if(G.win.opera&&"svg"==e.tagName){b=
e;m=b.getBoundingClientRect();b=b.ownerDocument;var h=b.body,d=b.documentElement;b=m.top+(g.win.pageYOffset||d.scrollTop||h.scrollTop)-(d.clientTop||h.clientTop||0);m=m.left+(g.win.pageXOffset||d.scrollLeft||h.scrollLeft)-(d.clientLeft||h.clientLeft||0);h=e.createSVGRect();h.x=c-m;h.y=a-b;h.width=h.height=1;b=e.getIntersectionList(h,null);b.length&&(e=b[b.length-1])}return e?x(e):null};a.plugin=function(c){c(a,e,s,G,l)};return G.win.Snap=a}();C.plugin(function(a,k,y,M,A){function w(a,d,f,b,q,e){null==
d&&"[object SVGMatrix]"==z.call(a)?(this.a=a.a,this.b=a.b,this.c=a.c,this.d=a.d,this.e=a.e,this.f=a.f):null!=a?(this.a=+a,this.b=+d,this.c=+f,this.d=+b,this.e=+q,this.f=+e):(this.a=1,this.c=this.b=0,this.d=1,this.f=this.e=0)}var z=Object.prototype.toString,d=String,f=Math;(function(n){function k(a){return a[0]*a[0]+a[1]*a[1]}function p(a){var d=f.sqrt(k(a));a[0]&&(a[0]/=d);a[1]&&(a[1]/=d)}n.add=function(a,d,e,f,n,p){var k=[[],[],[] ],u=[[this.a,this.c,this.e],[this.b,this.d,this.f],[0,0,1] ];d=[[a,
e,n],[d,f,p],[0,0,1] ];a&&a instanceof w&&(d=[[a.a,a.c,a.e],[a.b,a.d,a.f],[0,0,1] ]);for(a=0;3>a;a++)for(e=0;3>e;e++){for(f=n=0;3>f;f++)n+=u[a][f]*d[f][e];k[a][e]=n}this.a=k[0][0];this.b=k[1][0];this.c=k[0][1];this.d=k[1][1];this.e=k[0][2];this.f=k[1][2];return this};n.invert=function(){var a=this.a*this.d-this.b*this.c;return new w(this.d/a,-this.b/a,-this.c/a,this.a/a,(this.c*this.f-this.d*this.e)/a,(this.b*this.e-this.a*this.f)/a)};n.clone=function(){return new w(this.a,this.b,this.c,this.d,this.e,
this.f)};n.translate=function(a,d){return this.add(1,0,0,1,a,d)};n.scale=function(a,d,e,f){null==d&&(d=a);(e||f)&&this.add(1,0,0,1,e,f);this.add(a,0,0,d,0,0);(e||f)&&this.add(1,0,0,1,-e,-f);return this};n.rotate=function(b,d,e){b=a.rad(b);d=d||0;e=e||0;var l=+f.cos(b).toFixed(9);b=+f.sin(b).toFixed(9);this.add(l,b,-b,l,d,e);return this.add(1,0,0,1,-d,-e)};n.x=function(a,d){return a*this.a+d*this.c+this.e};n.y=function(a,d){return a*this.b+d*this.d+this.f};n.get=function(a){return+this[d.fromCharCode(97+
a)].toFixed(4)};n.toString=function(){return"matrix("+[this.get(0),this.get(1),this.get(2),this.get(3),this.get(4),this.get(5)].join()+")"};n.offset=function(){return[this.e.toFixed(4),this.f.toFixed(4)]};n.determinant=function(){return this.a*this.d-this.b*this.c};n.split=function(){var b={};b.dx=this.e;b.dy=this.f;var d=[[this.a,this.c],[this.b,this.d] ];b.scalex=f.sqrt(k(d[0]));p(d[0]);b.shear=d[0][0]*d[1][0]+d[0][1]*d[1][1];d[1]=[d[1][0]-d[0][0]*b.shear,d[1][1]-d[0][1]*b.shear];b.scaley=f.sqrt(k(d[1]));
p(d[1]);b.shear/=b.scaley;0>this.determinant()&&(b.scalex=-b.scalex);var e=-d[0][1],d=d[1][1];0>d?(b.rotate=a.deg(f.acos(d)),0>e&&(b.rotate=360-b.rotate)):b.rotate=a.deg(f.asin(e));b.isSimple=!+b.shear.toFixed(9)&&(b.scalex.toFixed(9)==b.scaley.toFixed(9)||!b.rotate);b.isSuperSimple=!+b.shear.toFixed(9)&&b.scalex.toFixed(9)==b.scaley.toFixed(9)&&!b.rotate;b.noRotation=!+b.shear.toFixed(9)&&!b.rotate;return b};n.toTransformString=function(a){a=a||this.split();if(+a.shear.toFixed(9))return"m"+[this.get(0),
this.get(1),this.get(2),this.get(3),this.get(4),this.get(5)];a.scalex=+a.scalex.toFixed(4);a.scaley=+a.scaley.toFixed(4);a.rotate=+a.rotate.toFixed(4);return(a.dx||a.dy?"t"+[+a.dx.toFixed(4),+a.dy.toFixed(4)]:"")+(1!=a.scalex||1!=a.scaley?"s"+[a.scalex,a.scaley,0,0]:"")+(a.rotate?"r"+[+a.rotate.toFixed(4),0,0]:"")}})(w.prototype);a.Matrix=w;a.matrix=function(a,d,f,b,k,e){return new w(a,d,f,b,k,e)}});C.plugin(function(a,v,y,M,A){function w(h){return function(d){k.stop();d instanceof A&&1==d.node.childNodes.length&&
("radialGradient"==d.node.firstChild.tagName||"linearGradient"==d.node.firstChild.tagName||"pattern"==d.node.firstChild.tagName)&&(d=d.node.firstChild,b(this).appendChild(d),d=u(d));if(d instanceof v)if("radialGradient"==d.type||"linearGradient"==d.type||"pattern"==d.type){d.node.id||e(d.node,{id:d.id});var f=l(d.node.id)}else f=d.attr(h);else f=a.color(d),f.error?(f=a(b(this).ownerSVGElement).gradient(d))?(f.node.id||e(f.node,{id:f.id}),f=l(f.node.id)):f=d:f=r(f);d={};d[h]=f;e(this.node,d);this.node.style[h]=
x}}function z(a){k.stop();a==+a&&(a+="px");this.node.style.fontSize=a}function d(a){var b=[];a=a.childNodes;for(var e=0,f=a.length;e<f;e++){var l=a[e];3==l.nodeType&&b.push(l.nodeValue);"tspan"==l.tagName&&(1==l.childNodes.length&&3==l.firstChild.nodeType?b.push(l.firstChild.nodeValue):b.push(d(l)))}return b}function f(){k.stop();return this.node.style.fontSize}var n=a._.make,u=a._.wrap,p=a.is,b=a._.getSomeDefs,q=/^url\(#?([^)]+)\)$/,e=a._.$,l=a.url,r=String,s=a._.separator,x="";k.on("snap.util.attr.mask",
function(a){if(a instanceof v||a instanceof A){k.stop();a instanceof A&&1==a.node.childNodes.length&&(a=a.node.firstChild,b(this).appendChild(a),a=u(a));if("mask"==a.type)var d=a;else d=n("mask",b(this)),d.node.appendChild(a.node);!d.node.id&&e(d.node,{id:d.id});e(this.node,{mask:l(d.id)})}});(function(a){k.on("snap.util.attr.clip",a);k.on("snap.util.attr.clip-path",a);k.on("snap.util.attr.clipPath",a)})(function(a){if(a instanceof v||a instanceof A){k.stop();if("clipPath"==a.type)var d=a;else d=
n("clipPath",b(this)),d.node.appendChild(a.node),!d.node.id&&e(d.node,{id:d.id});e(this.node,{"clip-path":l(d.id)})}});k.on("snap.util.attr.fill",w("fill"));k.on("snap.util.attr.stroke",w("stroke"));var G=/^([lr])(?:\(([^)]*)\))?(.*)$/i;k.on("snap.util.grad.parse",function(a){a=r(a);var b=a.match(G);if(!b)return null;a=b[1];var e=b[2],b=b[3],e=e.split(/\s*,\s*/).map(function(a){return+a==a?+a:a});1==e.length&&0==e[0]&&(e=[]);b=b.split("-");b=b.map(function(a){a=a.split(":");var b={color:a[0]};a[1]&&
(b.offset=parseFloat(a[1]));return b});return{type:a,params:e,stops:b}});k.on("snap.util.attr.d",function(b){k.stop();p(b,"array")&&p(b[0],"array")&&(b=a.path.toString.call(b));b=r(b);b.match(/[ruo]/i)&&(b=a.path.toAbsolute(b));e(this.node,{d:b})})(-1);k.on("snap.util.attr.#text",function(a){k.stop();a=r(a);for(a=M.doc.createTextNode(a);this.node.firstChild;)this.node.removeChild(this.node.firstChild);this.node.appendChild(a)})(-1);k.on("snap.util.attr.path",function(a){k.stop();this.attr({d:a})})(-1);
k.on("snap.util.attr.class",function(a){k.stop();this.node.className.baseVal=a})(-1);k.on("snap.util.attr.viewBox",function(a){a=p(a,"object")&&"x"in a?[a.x,a.y,a.width,a.height].join(" "):p(a,"array")?a.join(" "):a;e(this.node,{viewBox:a});k.stop()})(-1);k.on("snap.util.attr.transform",function(a){this.transform(a);k.stop()})(-1);k.on("snap.util.attr.r",function(a){"rect"==this.type&&(k.stop(),e(this.node,{rx:a,ry:a}))})(-1);k.on("snap.util.attr.textpath",function(a){k.stop();if("text"==this.type){var d,
f;if(!a&&this.textPath){for(a=this.textPath;a.node.firstChild;)this.node.appendChild(a.node.firstChild);a.remove();delete this.textPath}else if(p(a,"string")?(d=b(this),a=u(d.parentNode).path(a),d.appendChild(a.node),d=a.id,a.attr({id:d})):(a=u(a),a instanceof v&&(d=a.attr("id"),d||(d=a.id,a.attr({id:d})))),d)if(a=this.textPath,f=this.node,a)a.attr({"xlink:href":"#"+d});else{for(a=e("textPath",{"xlink:href":"#"+d});f.firstChild;)a.appendChild(f.firstChild);f.appendChild(a);this.textPath=u(a)}}})(-1);
k.on("snap.util.attr.text",function(a){if("text"==this.type){for(var b=this.node,d=function(a){var b=e("tspan");if(p(a,"array"))for(var f=0;f<a.length;f++)b.appendChild(d(a[f]));else b.appendChild(M.doc.createTextNode(a));b.normalize&&b.normalize();return b};b.firstChild;)b.removeChild(b.firstChild);for(a=d(a);a.firstChild;)b.appendChild(a.firstChild)}k.stop()})(-1);k.on("snap.util.attr.fontSize",z)(-1);k.on("snap.util.attr.font-size",z)(-1);k.on("snap.util.getattr.transform",function(){k.stop();
return this.transform()})(-1);k.on("snap.util.getattr.textpath",function(){k.stop();return this.textPath})(-1);(function(){function b(d){return function(){k.stop();var b=M.doc.defaultView.getComputedStyle(this.node,null).getPropertyValue("marker-"+d);return"none"==b?b:a(M.doc.getElementById(b.match(q)[1]))}}function d(a){return function(b){k.stop();var d="marker"+a.charAt(0).toUpperCase()+a.substring(1);if(""==b||!b)this.node.style[d]="none";else if("marker"==b.type){var f=b.node.id;f||e(b.node,{id:b.id});
this.node.style[d]=l(f)}}}k.on("snap.util.getattr.marker-end",b("end"))(-1);k.on("snap.util.getattr.markerEnd",b("end"))(-1);k.on("snap.util.getattr.marker-start",b("start"))(-1);k.on("snap.util.getattr.markerStart",b("start"))(-1);k.on("snap.util.getattr.marker-mid",b("mid"))(-1);k.on("snap.util.getattr.markerMid",b("mid"))(-1);k.on("snap.util.attr.marker-end",d("end"))(-1);k.on("snap.util.attr.markerEnd",d("end"))(-1);k.on("snap.util.attr.marker-start",d("start"))(-1);k.on("snap.util.attr.markerStart",
d("start"))(-1);k.on("snap.util.attr.marker-mid",d("mid"))(-1);k.on("snap.util.attr.markerMid",d("mid"))(-1)})();k.on("snap.util.getattr.r",function(){if("rect"==this.type&&e(this.node,"rx")==e(this.node,"ry"))return k.stop(),e(this.node,"rx")})(-1);k.on("snap.util.getattr.text",function(){if("text"==this.type||"tspan"==this.type){k.stop();var a=d(this.node);return 1==a.length?a[0]:a}})(-1);k.on("snap.util.getattr.#text",function(){return this.node.textContent})(-1);k.on("snap.util.getattr.viewBox",
function(){k.stop();var b=e(this.node,"viewBox");if(b)return b=b.split(s),a._.box(+b[0],+b[1],+b[2],+b[3])})(-1);k.on("snap.util.getattr.points",function(){var a=e(this.node,"points");k.stop();if(a)return a.split(s)})(-1);k.on("snap.util.getattr.path",function(){var a=e(this.node,"d");k.stop();return a})(-1);k.on("snap.util.getattr.class",function(){return this.node.className.baseVal})(-1);k.on("snap.util.getattr.fontSize",f)(-1);k.on("snap.util.getattr.font-size",f)(-1)});C.plugin(function(a,v,y,
M,A){function w(a){return a}function z(a){return function(b){return+b.toFixed(3)+a}}var d={"+":function(a,b){return a+b},"-":function(a,b){return a-b},"/":function(a,b){return a/b},"*":function(a,b){return a*b}},f=String,n=/[a-z]+$/i,u=/^\s*([+\-\/*])\s*=\s*([\d.eE+\-]+)\s*([^\d\s]+)?\s*$/;k.on("snap.util.attr",function(a){if(a=f(a).match(u)){var b=k.nt(),b=b.substring(b.lastIndexOf(".")+1),q=this.attr(b),e={};k.stop();var l=a[3]||"",r=q.match(n),s=d[a[1] ];r&&r==l?a=s(parseFloat(q),+a[2]):(q=this.asPX(b),
a=s(this.asPX(b),this.asPX(b,a[2]+l)));isNaN(q)||isNaN(a)||(e[b]=a,this.attr(e))}})(-10);k.on("snap.util.equal",function(a,b){var q=f(this.attr(a)||""),e=f(b).match(u);if(e){k.stop();var l=e[3]||"",r=q.match(n),s=d[e[1] ];if(r&&r==l)return{from:parseFloat(q),to:s(parseFloat(q),+e[2]),f:z(r)};q=this.asPX(a);return{from:q,to:s(q,this.asPX(a,e[2]+l)),f:w}}})(-10)});C.plugin(function(a,v,y,M,A){var w=y.prototype,z=a.is;w.rect=function(a,d,k,p,b,q){var e;null==q&&(q=b);z(a,"object")&&"[object Object]"==
a?e=a:null!=a&&(e={x:a,y:d,width:k,height:p},null!=b&&(e.rx=b,e.ry=q));return this.el("rect",e)};w.circle=function(a,d,k){var p;z(a,"object")&&"[object Object]"==a?p=a:null!=a&&(p={cx:a,cy:d,r:k});return this.el("circle",p)};var d=function(){function a(){this.parentNode.removeChild(this)}return function(d,k){var p=M.doc.createElement("img"),b=M.doc.body;p.style.cssText="position:absolute;left:-9999em;top:-9999em";p.onload=function(){k.call(p);p.onload=p.onerror=null;b.removeChild(p)};p.onerror=a;
b.appendChild(p);p.src=d}}();w.image=function(f,n,k,p,b){var q=this.el("image");if(z(f,"object")&&"src"in f)q.attr(f);else if(null!=f){var e={"xlink:href":f,preserveAspectRatio:"none"};null!=n&&null!=k&&(e.x=n,e.y=k);null!=p&&null!=b?(e.width=p,e.height=b):d(f,function(){a._.$(q.node,{width:this.offsetWidth,height:this.offsetHeight})});a._.$(q.node,e)}return q};w.ellipse=function(a,d,k,p){var b;z(a,"object")&&"[object Object]"==a?b=a:null!=a&&(b={cx:a,cy:d,rx:k,ry:p});return this.el("ellipse",b)};
w.path=function(a){var d;z(a,"object")&&!z(a,"array")?d=a:a&&(d={d:a});return this.el("path",d)};w.group=w.g=function(a){var d=this.el("g");1==arguments.length&&a&&!a.type?d.attr(a):arguments.length&&d.add(Array.prototype.slice.call(arguments,0));return d};w.svg=function(a,d,k,p,b,q,e,l){var r={};z(a,"object")&&null==d?r=a:(null!=a&&(r.x=a),null!=d&&(r.y=d),null!=k&&(r.width=k),null!=p&&(r.height=p),null!=b&&null!=q&&null!=e&&null!=l&&(r.viewBox=[b,q,e,l]));return this.el("svg",r)};w.mask=function(a){var d=
this.el("mask");1==arguments.length&&a&&!a.type?d.attr(a):arguments.length&&d.add(Array.prototype.slice.call(arguments,0));return d};w.ptrn=function(a,d,k,p,b,q,e,l){if(z(a,"object"))var r=a;else arguments.length?(r={},null!=a&&(r.x=a),null!=d&&(r.y=d),null!=k&&(r.width=k),null!=p&&(r.height=p),null!=b&&null!=q&&null!=e&&null!=l&&(r.viewBox=[b,q,e,l])):r={patternUnits:"userSpaceOnUse"};return this.el("pattern",r)};w.use=function(a){return null!=a?(make("use",this.node),a instanceof v&&(a.attr("id")||
a.attr({id:ID()}),a=a.attr("id")),this.el("use",{"xlink:href":a})):v.prototype.use.call(this)};w.text=function(a,d,k){var p={};z(a,"object")?p=a:null!=a&&(p={x:a,y:d,text:k||""});return this.el("text",p)};w.line=function(a,d,k,p){var b={};z(a,"object")?b=a:null!=a&&(b={x1:a,x2:k,y1:d,y2:p});return this.el("line",b)};w.polyline=function(a){1<arguments.length&&(a=Array.prototype.slice.call(arguments,0));var d={};z(a,"object")&&!z(a,"array")?d=a:null!=a&&(d={points:a});return this.el("polyline",d)};
w.polygon=function(a){1<arguments.length&&(a=Array.prototype.slice.call(arguments,0));var d={};z(a,"object")&&!z(a,"array")?d=a:null!=a&&(d={points:a});return this.el("polygon",d)};(function(){function d(){return this.selectAll("stop")}function n(b,d){var f=e("stop"),k={offset:+d+"%"};b=a.color(b);k["stop-color"]=b.hex;1>b.opacity&&(k["stop-opacity"]=b.opacity);e(f,k);this.node.appendChild(f);return this}function u(){if("linearGradient"==this.type){var b=e(this.node,"x1")||0,d=e(this.node,"x2")||
1,f=e(this.node,"y1")||0,k=e(this.node,"y2")||0;return a._.box(b,f,math.abs(d-b),math.abs(k-f))}b=this.node.r||0;return a._.box((this.node.cx||0.5)-b,(this.node.cy||0.5)-b,2*b,2*b)}function p(a,d){function f(a,b){for(var d=(b-u)/(a-w),e=w;e<a;e++)h[e].offset=+(+u+d*(e-w)).toFixed(2);w=a;u=b}var n=k("snap.util.grad.parse",null,d).firstDefined(),p;if(!n)return null;n.params.unshift(a);p="l"==n.type.toLowerCase()?b.apply(0,n.params):q.apply(0,n.params);n.type!=n.type.toLowerCase()&&e(p.node,{gradientUnits:"userSpaceOnUse"});
var h=n.stops,n=h.length,u=0,w=0;n--;for(var v=0;v<n;v++)"offset"in h[v]&&f(v,h[v].offset);h[n].offset=h[n].offset||100;f(n,h[n].offset);for(v=0;v<=n;v++){var y=h[v];p.addStop(y.color,y.offset)}return p}function b(b,k,p,q,w){b=a._.make("linearGradient",b);b.stops=d;b.addStop=n;b.getBBox=u;null!=k&&e(b.node,{x1:k,y1:p,x2:q,y2:w});return b}function q(b,k,p,q,w,h){b=a._.make("radialGradient",b);b.stops=d;b.addStop=n;b.getBBox=u;null!=k&&e(b.node,{cx:k,cy:p,r:q});null!=w&&null!=h&&e(b.node,{fx:w,fy:h});
return b}var e=a._.$;w.gradient=function(a){return p(this.defs,a)};w.gradientLinear=function(a,d,e,f){return b(this.defs,a,d,e,f)};w.gradientRadial=function(a,b,d,e,f){return q(this.defs,a,b,d,e,f)};w.toString=function(){var b=this.node.ownerDocument,d=b.createDocumentFragment(),b=b.createElement("div"),e=this.node.cloneNode(!0);d.appendChild(b);b.appendChild(e);a._.$(e,{xmlns:"http://www.w3.org/2000/svg"});b=b.innerHTML;d.removeChild(d.firstChild);return b};w.clear=function(){for(var a=this.node.firstChild,
b;a;)b=a.nextSibling,"defs"!=a.tagName?a.parentNode.removeChild(a):w.clear.call({node:a}),a=b}})()});C.plugin(function(a,k,y,M){function A(a){var b=A.ps=A.ps||{};b[a]?b[a].sleep=100:b[a]={sleep:100};setTimeout(function(){for(var d in b)b[L](d)&&d!=a&&(b[d].sleep--,!b[d].sleep&&delete b[d])});return b[a]}function w(a,b,d,e){null==a&&(a=b=d=e=0);null==b&&(b=a.y,d=a.width,e=a.height,a=a.x);return{x:a,y:b,width:d,w:d,height:e,h:e,x2:a+d,y2:b+e,cx:a+d/2,cy:b+e/2,r1:F.min(d,e)/2,r2:F.max(d,e)/2,r0:F.sqrt(d*
d+e*e)/2,path:s(a,b,d,e),vb:[a,b,d,e].join(" ")}}function z(){return this.join(",").replace(N,"$1")}function d(a){a=C(a);a.toString=z;return a}function f(a,b,d,h,f,k,l,n,p){if(null==p)return e(a,b,d,h,f,k,l,n);if(0>p||e(a,b,d,h,f,k,l,n)<p)p=void 0;else{var q=0.5,O=1-q,s;for(s=e(a,b,d,h,f,k,l,n,O);0.01<Z(s-p);)q/=2,O+=(s<p?1:-1)*q,s=e(a,b,d,h,f,k,l,n,O);p=O}return u(a,b,d,h,f,k,l,n,p)}function n(b,d){function e(a){return+(+a).toFixed(3)}return a._.cacher(function(a,h,l){a instanceof k&&(a=a.attr("d"));
a=I(a);for(var n,p,D,q,O="",s={},c=0,t=0,r=a.length;t<r;t++){D=a[t];if("M"==D[0])n=+D[1],p=+D[2];else{q=f(n,p,D[1],D[2],D[3],D[4],D[5],D[6]);if(c+q>h){if(d&&!s.start){n=f(n,p,D[1],D[2],D[3],D[4],D[5],D[6],h-c);O+=["C"+e(n.start.x),e(n.start.y),e(n.m.x),e(n.m.y),e(n.x),e(n.y)];if(l)return O;s.start=O;O=["M"+e(n.x),e(n.y)+"C"+e(n.n.x),e(n.n.y),e(n.end.x),e(n.end.y),e(D[5]),e(D[6])].join();c+=q;n=+D[5];p=+D[6];continue}if(!b&&!d)return n=f(n,p,D[1],D[2],D[3],D[4],D[5],D[6],h-c)}c+=q;n=+D[5];p=+D[6]}O+=
D.shift()+D}s.end=O;return n=b?c:d?s:u(n,p,D[0],D[1],D[2],D[3],D[4],D[5],1)},null,a._.clone)}function u(a,b,d,e,h,f,k,l,n){var p=1-n,q=ma(p,3),s=ma(p,2),c=n*n,t=c*n,r=q*a+3*s*n*d+3*p*n*n*h+t*k,q=q*b+3*s*n*e+3*p*n*n*f+t*l,s=a+2*n*(d-a)+c*(h-2*d+a),t=b+2*n*(e-b)+c*(f-2*e+b),x=d+2*n*(h-d)+c*(k-2*h+d),c=e+2*n*(f-e)+c*(l-2*f+e);a=p*a+n*d;b=p*b+n*e;h=p*h+n*k;f=p*f+n*l;l=90-180*F.atan2(s-x,t-c)/S;return{x:r,y:q,m:{x:s,y:t},n:{x:x,y:c},start:{x:a,y:b},end:{x:h,y:f},alpha:l}}function p(b,d,e,h,f,n,k,l){a.is(b,
"array")||(b=[b,d,e,h,f,n,k,l]);b=U.apply(null,b);return w(b.min.x,b.min.y,b.max.x-b.min.x,b.max.y-b.min.y)}function b(a,b,d){return b>=a.x&&b<=a.x+a.width&&d>=a.y&&d<=a.y+a.height}function q(a,d){a=w(a);d=w(d);return b(d,a.x,a.y)||b(d,a.x2,a.y)||b(d,a.x,a.y2)||b(d,a.x2,a.y2)||b(a,d.x,d.y)||b(a,d.x2,d.y)||b(a,d.x,d.y2)||b(a,d.x2,d.y2)||(a.x<d.x2&&a.x>d.x||d.x<a.x2&&d.x>a.x)&&(a.y<d.y2&&a.y>d.y||d.y<a.y2&&d.y>a.y)}function e(a,b,d,e,h,f,n,k,l){null==l&&(l=1);l=(1<l?1:0>l?0:l)/2;for(var p=[-0.1252,
0.1252,-0.3678,0.3678,-0.5873,0.5873,-0.7699,0.7699,-0.9041,0.9041,-0.9816,0.9816],q=[0.2491,0.2491,0.2335,0.2335,0.2032,0.2032,0.1601,0.1601,0.1069,0.1069,0.0472,0.0472],s=0,c=0;12>c;c++)var t=l*p[c]+l,r=t*(t*(-3*a+9*d-9*h+3*n)+6*a-12*d+6*h)-3*a+3*d,t=t*(t*(-3*b+9*e-9*f+3*k)+6*b-12*e+6*f)-3*b+3*e,s=s+q[c]*F.sqrt(r*r+t*t);return l*s}function l(a,b,d){a=I(a);b=I(b);for(var h,f,l,n,k,s,r,O,x,c,t=d?0:[],w=0,v=a.length;w<v;w++)if(x=a[w],"M"==x[0])h=k=x[1],f=s=x[2];else{"C"==x[0]?(x=[h,f].concat(x.slice(1)),
h=x[6],f=x[7]):(x=[h,f,h,f,k,s,k,s],h=k,f=s);for(var G=0,y=b.length;G<y;G++)if(c=b[G],"M"==c[0])l=r=c[1],n=O=c[2];else{"C"==c[0]?(c=[l,n].concat(c.slice(1)),l=c[6],n=c[7]):(c=[l,n,l,n,r,O,r,O],l=r,n=O);var z;var K=x,B=c;z=d;var H=p(K),J=p(B);if(q(H,J)){for(var H=e.apply(0,K),J=e.apply(0,B),H=~~(H/8),J=~~(J/8),U=[],A=[],F={},M=z?0:[],P=0;P<H+1;P++){var C=u.apply(0,K.concat(P/H));U.push({x:C.x,y:C.y,t:P/H})}for(P=0;P<J+1;P++)C=u.apply(0,B.concat(P/J)),A.push({x:C.x,y:C.y,t:P/J});for(P=0;P<H;P++)for(K=
0;K<J;K++){var Q=U[P],L=U[P+1],B=A[K],C=A[K+1],N=0.001>Z(L.x-Q.x)?"y":"x",S=0.001>Z(C.x-B.x)?"y":"x",R;R=Q.x;var Y=Q.y,V=L.x,ea=L.y,fa=B.x,ga=B.y,ha=C.x,ia=C.y;if(W(R,V)<X(fa,ha)||X(R,V)>W(fa,ha)||W(Y,ea)<X(ga,ia)||X(Y,ea)>W(ga,ia))R=void 0;else{var $=(R*ea-Y*V)*(fa-ha)-(R-V)*(fa*ia-ga*ha),aa=(R*ea-Y*V)*(ga-ia)-(Y-ea)*(fa*ia-ga*ha),ja=(R-V)*(ga-ia)-(Y-ea)*(fa-ha);if(ja){var $=$/ja,aa=aa/ja,ja=+$.toFixed(2),ba=+aa.toFixed(2);R=ja<+X(R,V).toFixed(2)||ja>+W(R,V).toFixed(2)||ja<+X(fa,ha).toFixed(2)||
ja>+W(fa,ha).toFixed(2)||ba<+X(Y,ea).toFixed(2)||ba>+W(Y,ea).toFixed(2)||ba<+X(ga,ia).toFixed(2)||ba>+W(ga,ia).toFixed(2)?void 0:{x:$,y:aa}}else R=void 0}R&&F[R.x.toFixed(4)]!=R.y.toFixed(4)&&(F[R.x.toFixed(4)]=R.y.toFixed(4),Q=Q.t+Z((R[N]-Q[N])/(L[N]-Q[N]))*(L.t-Q.t),B=B.t+Z((R[S]-B[S])/(C[S]-B[S]))*(C.t-B.t),0<=Q&&1>=Q&&0<=B&&1>=B&&(z?M++:M.push({x:R.x,y:R.y,t1:Q,t2:B})))}z=M}else z=z?0:[];if(d)t+=z;else{H=0;for(J=z.length;H<J;H++)z[H].segment1=w,z[H].segment2=G,z[H].bez1=x,z[H].bez2=c;t=t.concat(z)}}}return t}
function r(a){var b=A(a);if(b.bbox)return C(b.bbox);if(!a)return w();a=I(a);for(var d=0,e=0,h=[],f=[],l,n=0,k=a.length;n<k;n++)l=a[n],"M"==l[0]?(d=l[1],e=l[2],h.push(d),f.push(e)):(d=U(d,e,l[1],l[2],l[3],l[4],l[5],l[6]),h=h.concat(d.min.x,d.max.x),f=f.concat(d.min.y,d.max.y),d=l[5],e=l[6]);a=X.apply(0,h);l=X.apply(0,f);h=W.apply(0,h);f=W.apply(0,f);f=w(a,l,h-a,f-l);b.bbox=C(f);return f}function s(a,b,d,e,h){if(h)return[["M",+a+ +h,b],["l",d-2*h,0],["a",h,h,0,0,1,h,h],["l",0,e-2*h],["a",h,h,0,0,1,
-h,h],["l",2*h-d,0],["a",h,h,0,0,1,-h,-h],["l",0,2*h-e],["a",h,h,0,0,1,h,-h],["z"] ];a=[["M",a,b],["l",d,0],["l",0,e],["l",-d,0],["z"] ];a.toString=z;return a}function x(a,b,d,e,h){null==h&&null==e&&(e=d);a=+a;b=+b;d=+d;e=+e;if(null!=h){var f=Math.PI/180,l=a+d*Math.cos(-e*f);a+=d*Math.cos(-h*f);var n=b+d*Math.sin(-e*f);b+=d*Math.sin(-h*f);d=[["M",l,n],["A",d,d,0,+(180<h-e),0,a,b] ]}else d=[["M",a,b],["m",0,-e],["a",d,e,0,1,1,0,2*e],["a",d,e,0,1,1,0,-2*e],["z"] ];d.toString=z;return d}function G(b){var e=
A(b);if(e.abs)return d(e.abs);Q(b,"array")&&Q(b&&b[0],"array")||(b=a.parsePathString(b));if(!b||!b.length)return[["M",0,0] ];var h=[],f=0,l=0,n=0,k=0,p=0;"M"==b[0][0]&&(f=+b[0][1],l=+b[0][2],n=f,k=l,p++,h[0]=["M",f,l]);for(var q=3==b.length&&"M"==b[0][0]&&"R"==b[1][0].toUpperCase()&&"Z"==b[2][0].toUpperCase(),s,r,w=p,c=b.length;w<c;w++){h.push(s=[]);r=b[w];p=r[0];if(p!=p.toUpperCase())switch(s[0]=p.toUpperCase(),s[0]){case "A":s[1]=r[1];s[2]=r[2];s[3]=r[3];s[4]=r[4];s[5]=r[5];s[6]=+r[6]+f;s[7]=+r[7]+
l;break;case "V":s[1]=+r[1]+l;break;case "H":s[1]=+r[1]+f;break;case "R":for(var t=[f,l].concat(r.slice(1)),u=2,v=t.length;u<v;u++)t[u]=+t[u]+f,t[++u]=+t[u]+l;h.pop();h=h.concat(P(t,q));break;case "O":h.pop();t=x(f,l,r[1],r[2]);t.push(t[0]);h=h.concat(t);break;case "U":h.pop();h=h.concat(x(f,l,r[1],r[2],r[3]));s=["U"].concat(h[h.length-1].slice(-2));break;case "M":n=+r[1]+f,k=+r[2]+l;default:for(u=1,v=r.length;u<v;u++)s[u]=+r[u]+(u%2?f:l)}else if("R"==p)t=[f,l].concat(r.slice(1)),h.pop(),h=h.concat(P(t,
q)),s=["R"].concat(r.slice(-2));else if("O"==p)h.pop(),t=x(f,l,r[1],r[2]),t.push(t[0]),h=h.concat(t);else if("U"==p)h.pop(),h=h.concat(x(f,l,r[1],r[2],r[3])),s=["U"].concat(h[h.length-1].slice(-2));else for(t=0,u=r.length;t<u;t++)s[t]=r[t];p=p.toUpperCase();if("O"!=p)switch(s[0]){case "Z":f=+n;l=+k;break;case "H":f=s[1];break;case "V":l=s[1];break;case "M":n=s[s.length-2],k=s[s.length-1];default:f=s[s.length-2],l=s[s.length-1]}}h.toString=z;e.abs=d(h);return h}function h(a,b,d,e){return[a,b,d,e,d,
e]}function J(a,b,d,e,h,f){var l=1/3,n=2/3;return[l*a+n*d,l*b+n*e,l*h+n*d,l*f+n*e,h,f]}function K(b,d,e,h,f,l,n,k,p,s){var r=120*S/180,q=S/180*(+f||0),c=[],t,x=a._.cacher(function(a,b,c){var d=a*F.cos(c)-b*F.sin(c);a=a*F.sin(c)+b*F.cos(c);return{x:d,y:a}});if(s)v=s[0],t=s[1],l=s[2],u=s[3];else{t=x(b,d,-q);b=t.x;d=t.y;t=x(k,p,-q);k=t.x;p=t.y;F.cos(S/180*f);F.sin(S/180*f);t=(b-k)/2;v=(d-p)/2;u=t*t/(e*e)+v*v/(h*h);1<u&&(u=F.sqrt(u),e*=u,h*=u);var u=e*e,w=h*h,u=(l==n?-1:1)*F.sqrt(Z((u*w-u*v*v-w*t*t)/
(u*v*v+w*t*t)));l=u*e*v/h+(b+k)/2;var u=u*-h*t/e+(d+p)/2,v=F.asin(((d-u)/h).toFixed(9));t=F.asin(((p-u)/h).toFixed(9));v=b<l?S-v:v;t=k<l?S-t:t;0>v&&(v=2*S+v);0>t&&(t=2*S+t);n&&v>t&&(v-=2*S);!n&&t>v&&(t-=2*S)}if(Z(t-v)>r){var c=t,w=k,G=p;t=v+r*(n&&t>v?1:-1);k=l+e*F.cos(t);p=u+h*F.sin(t);c=K(k,p,e,h,f,0,n,w,G,[t,c,l,u])}l=t-v;f=F.cos(v);r=F.sin(v);n=F.cos(t);t=F.sin(t);l=F.tan(l/4);e=4/3*e*l;l*=4/3*h;h=[b,d];b=[b+e*r,d-l*f];d=[k+e*t,p-l*n];k=[k,p];b[0]=2*h[0]-b[0];b[1]=2*h[1]-b[1];if(s)return[b,d,k].concat(c);
c=[b,d,k].concat(c).join().split(",");s=[];k=0;for(p=c.length;k<p;k++)s[k]=k%2?x(c[k-1],c[k],q).y:x(c[k],c[k+1],q).x;return s}function U(a,b,d,e,h,f,l,k){for(var n=[],p=[[],[] ],s,r,c,t,q=0;2>q;++q)0==q?(r=6*a-12*d+6*h,s=-3*a+9*d-9*h+3*l,c=3*d-3*a):(r=6*b-12*e+6*f,s=-3*b+9*e-9*f+3*k,c=3*e-3*b),1E-12>Z(s)?1E-12>Z(r)||(s=-c/r,0<s&&1>s&&n.push(s)):(t=r*r-4*c*s,c=F.sqrt(t),0>t||(t=(-r+c)/(2*s),0<t&&1>t&&n.push(t),s=(-r-c)/(2*s),0<s&&1>s&&n.push(s)));for(r=q=n.length;q--;)s=n[q],c=1-s,p[0][q]=c*c*c*a+3*
c*c*s*d+3*c*s*s*h+s*s*s*l,p[1][q]=c*c*c*b+3*c*c*s*e+3*c*s*s*f+s*s*s*k;p[0][r]=a;p[1][r]=b;p[0][r+1]=l;p[1][r+1]=k;p[0].length=p[1].length=r+2;return{min:{x:X.apply(0,p[0]),y:X.apply(0,p[1])},max:{x:W.apply(0,p[0]),y:W.apply(0,p[1])}}}function I(a,b){var e=!b&&A(a);if(!b&&e.curve)return d(e.curve);var f=G(a),l=b&&G(b),n={x:0,y:0,bx:0,by:0,X:0,Y:0,qx:null,qy:null},k={x:0,y:0,bx:0,by:0,X:0,Y:0,qx:null,qy:null},p=function(a,b,c){if(!a)return["C",b.x,b.y,b.x,b.y,b.x,b.y];a[0]in{T:1,Q:1}||(b.qx=b.qy=null);
switch(a[0]){case "M":b.X=a[1];b.Y=a[2];break;case "A":a=["C"].concat(K.apply(0,[b.x,b.y].concat(a.slice(1))));break;case "S":"C"==c||"S"==c?(c=2*b.x-b.bx,b=2*b.y-b.by):(c=b.x,b=b.y);a=["C",c,b].concat(a.slice(1));break;case "T":"Q"==c||"T"==c?(b.qx=2*b.x-b.qx,b.qy=2*b.y-b.qy):(b.qx=b.x,b.qy=b.y);a=["C"].concat(J(b.x,b.y,b.qx,b.qy,a[1],a[2]));break;case "Q":b.qx=a[1];b.qy=a[2];a=["C"].concat(J(b.x,b.y,a[1],a[2],a[3],a[4]));break;case "L":a=["C"].concat(h(b.x,b.y,a[1],a[2]));break;case "H":a=["C"].concat(h(b.x,
b.y,a[1],b.y));break;case "V":a=["C"].concat(h(b.x,b.y,b.x,a[1]));break;case "Z":a=["C"].concat(h(b.x,b.y,b.X,b.Y))}return a},s=function(a,b){if(7<a[b].length){a[b].shift();for(var c=a[b];c.length;)q[b]="A",l&&(u[b]="A"),a.splice(b++,0,["C"].concat(c.splice(0,6)));a.splice(b,1);v=W(f.length,l&&l.length||0)}},r=function(a,b,c,d,e){a&&b&&"M"==a[e][0]&&"M"!=b[e][0]&&(b.splice(e,0,["M",d.x,d.y]),c.bx=0,c.by=0,c.x=a[e][1],c.y=a[e][2],v=W(f.length,l&&l.length||0))},q=[],u=[],c="",t="",x=0,v=W(f.length,
l&&l.length||0);for(;x<v;x++){f[x]&&(c=f[x][0]);"C"!=c&&(q[x]=c,x&&(t=q[x-1]));f[x]=p(f[x],n,t);"A"!=q[x]&&"C"==c&&(q[x]="C");s(f,x);l&&(l[x]&&(c=l[x][0]),"C"!=c&&(u[x]=c,x&&(t=u[x-1])),l[x]=p(l[x],k,t),"A"!=u[x]&&"C"==c&&(u[x]="C"),s(l,x));r(f,l,n,k,x);r(l,f,k,n,x);var w=f[x],z=l&&l[x],y=w.length,U=l&&z.length;n.x=w[y-2];n.y=w[y-1];n.bx=$(w[y-4])||n.x;n.by=$(w[y-3])||n.y;k.bx=l&&($(z[U-4])||k.x);k.by=l&&($(z[U-3])||k.y);k.x=l&&z[U-2];k.y=l&&z[U-1]}l||(e.curve=d(f));return l?[f,l]:f}function P(a,
b){for(var d=[],e=0,h=a.length;h-2*!b>e;e+=2){var f=[{x:+a[e-2],y:+a[e-1]},{x:+a[e],y:+a[e+1]},{x:+a[e+2],y:+a[e+3]},{x:+a[e+4],y:+a[e+5]}];b?e?h-4==e?f[3]={x:+a[0],y:+a[1]}:h-2==e&&(f[2]={x:+a[0],y:+a[1]},f[3]={x:+a[2],y:+a[3]}):f[0]={x:+a[h-2],y:+a[h-1]}:h-4==e?f[3]=f[2]:e||(f[0]={x:+a[e],y:+a[e+1]});d.push(["C",(-f[0].x+6*f[1].x+f[2].x)/6,(-f[0].y+6*f[1].y+f[2].y)/6,(f[1].x+6*f[2].x-f[3].x)/6,(f[1].y+6*f[2].y-f[3].y)/6,f[2].x,f[2].y])}return d}y=k.prototype;var Q=a.is,C=a._.clone,L="hasOwnProperty",
N=/,?([a-z]),?/gi,$=parseFloat,F=Math,S=F.PI,X=F.min,W=F.max,ma=F.pow,Z=F.abs;M=n(1);var na=n(),ba=n(0,1),V=a._unit2px;a.path=A;a.path.getTotalLength=M;a.path.getPointAtLength=na;a.path.getSubpath=function(a,b,d){if(1E-6>this.getTotalLength(a)-d)return ba(a,b).end;a=ba(a,d,1);return b?ba(a,b).end:a};y.getTotalLength=function(){if(this.node.getTotalLength)return this.node.getTotalLength()};y.getPointAtLength=function(a){return na(this.attr("d"),a)};y.getSubpath=function(b,d){return a.path.getSubpath(this.attr("d"),
b,d)};a._.box=w;a.path.findDotsAtSegment=u;a.path.bezierBBox=p;a.path.isPointInsideBBox=b;a.path.isBBoxIntersect=q;a.path.intersection=function(a,b){return l(a,b)};a.path.intersectionNumber=function(a,b){return l(a,b,1)};a.path.isPointInside=function(a,d,e){var h=r(a);return b(h,d,e)&&1==l(a,[["M",d,e],["H",h.x2+10] ],1)%2};a.path.getBBox=r;a.path.get={path:function(a){return a.attr("path")},circle:function(a){a=V(a);return x(a.cx,a.cy,a.r)},ellipse:function(a){a=V(a);return x(a.cx||0,a.cy||0,a.rx,
a.ry)},rect:function(a){a=V(a);return s(a.x||0,a.y||0,a.width,a.height,a.rx,a.ry)},image:function(a){a=V(a);return s(a.x||0,a.y||0,a.width,a.height)},line:function(a){return"M"+[a.attr("x1")||0,a.attr("y1")||0,a.attr("x2"),a.attr("y2")]},polyline:function(a){return"M"+a.attr("points")},polygon:function(a){return"M"+a.attr("points")+"z"},deflt:function(a){a=a.node.getBBox();return s(a.x,a.y,a.width,a.height)}};a.path.toRelative=function(b){var e=A(b),h=String.prototype.toLowerCase;if(e.rel)return d(e.rel);
a.is(b,"array")&&a.is(b&&b[0],"array")||(b=a.parsePathString(b));var f=[],l=0,n=0,k=0,p=0,s=0;"M"==b[0][0]&&(l=b[0][1],n=b[0][2],k=l,p=n,s++,f.push(["M",l,n]));for(var r=b.length;s<r;s++){var q=f[s]=[],x=b[s];if(x[0]!=h.call(x[0]))switch(q[0]=h.call(x[0]),q[0]){case "a":q[1]=x[1];q[2]=x[2];q[3]=x[3];q[4]=x[4];q[5]=x[5];q[6]=+(x[6]-l).toFixed(3);q[7]=+(x[7]-n).toFixed(3);break;case "v":q[1]=+(x[1]-n).toFixed(3);break;case "m":k=x[1],p=x[2];default:for(var c=1,t=x.length;c<t;c++)q[c]=+(x[c]-(c%2?l:
n)).toFixed(3)}else for(f[s]=[],"m"==x[0]&&(k=x[1]+l,p=x[2]+n),q=0,c=x.length;q<c;q++)f[s][q]=x[q];x=f[s].length;switch(f[s][0]){case "z":l=k;n=p;break;case "h":l+=+f[s][x-1];break;case "v":n+=+f[s][x-1];break;default:l+=+f[s][x-2],n+=+f[s][x-1]}}f.toString=z;e.rel=d(f);return f};a.path.toAbsolute=G;a.path.toCubic=I;a.path.map=function(a,b){if(!b)return a;var d,e,h,f,l,n,k;a=I(a);h=0;for(l=a.length;h<l;h++)for(k=a[h],f=1,n=k.length;f<n;f+=2)d=b.x(k[f],k[f+1]),e=b.y(k[f],k[f+1]),k[f]=d,k[f+1]=e;return a};
a.path.toString=z;a.path.clone=d});C.plugin(function(a,v,y,C){var A=Math.max,w=Math.min,z=function(a){this.items=[];this.bindings={};this.length=0;this.type="set";if(a)for(var f=0,n=a.length;f<n;f++)a[f]&&(this[this.items.length]=this.items[this.items.length]=a[f],this.length++)};v=z.prototype;v.push=function(){for(var a,f,n=0,k=arguments.length;n<k;n++)if(a=arguments[n])f=this.items.length,this[f]=this.items[f]=a,this.length++;return this};v.pop=function(){this.length&&delete this[this.length--];
return this.items.pop()};v.forEach=function(a,f){for(var n=0,k=this.items.length;n<k&&!1!==a.call(f,this.items[n],n);n++);return this};v.animate=function(d,f,n,u){"function"!=typeof n||n.length||(u=n,n=L.linear);d instanceof a._.Animation&&(u=d.callback,n=d.easing,f=n.dur,d=d.attr);var p=arguments;if(a.is(d,"array")&&a.is(p[p.length-1],"array"))var b=!0;var q,e=function(){q?this.b=q:q=this.b},l=0,r=u&&function(){l++==this.length&&u.call(this)};return this.forEach(function(a,l){k.once("snap.animcreated."+
a.id,e);b?p[l]&&a.animate.apply(a,p[l]):a.animate(d,f,n,r)})};v.remove=function(){for(;this.length;)this.pop().remove();return this};v.bind=function(a,f,k){var u={};if("function"==typeof f)this.bindings[a]=f;else{var p=k||a;this.bindings[a]=function(a){u[p]=a;f.attr(u)}}return this};v.attr=function(a){var f={},k;for(k in a)if(this.bindings[k])this.bindings[k](a[k]);else f[k]=a[k];a=0;for(k=this.items.length;a<k;a++)this.items[a].attr(f);return this};v.clear=function(){for(;this.length;)this.pop()};
v.splice=function(a,f,k){a=0>a?A(this.length+a,0):a;f=A(0,w(this.length-a,f));var u=[],p=[],b=[],q;for(q=2;q<arguments.length;q++)b.push(arguments[q]);for(q=0;q<f;q++)p.push(this[a+q]);for(;q<this.length-a;q++)u.push(this[a+q]);var e=b.length;for(q=0;q<e+u.length;q++)this.items[a+q]=this[a+q]=q<e?b[q]:u[q-e];for(q=this.items.length=this.length-=f-e;this[q];)delete this[q++];return new z(p)};v.exclude=function(a){for(var f=0,k=this.length;f<k;f++)if(this[f]==a)return this.splice(f,1),!0;return!1};
v.insertAfter=function(a){for(var f=this.items.length;f--;)this.items[f].insertAfter(a);return this};v.getBBox=function(){for(var a=[],f=[],k=[],u=[],p=this.items.length;p--;)if(!this.items[p].removed){var b=this.items[p].getBBox();a.push(b.x);f.push(b.y);k.push(b.x+b.width);u.push(b.y+b.height)}a=w.apply(0,a);f=w.apply(0,f);k=A.apply(0,k);u=A.apply(0,u);return{x:a,y:f,x2:k,y2:u,width:k-a,height:u-f,cx:a+(k-a)/2,cy:f+(u-f)/2}};v.clone=function(a){a=new z;for(var f=0,k=this.items.length;f<k;f++)a.push(this.items[f].clone());
return a};v.toString=function(){return"Snap\u2018s set"};v.type="set";a.set=function(){var a=new z;arguments.length&&a.push.apply(a,Array.prototype.slice.call(arguments,0));return a}});C.plugin(function(a,v,y,C){function A(a){var b=a[0];switch(b.toLowerCase()){case "t":return[b,0,0];case "m":return[b,1,0,0,1,0,0];case "r":return 4==a.length?[b,0,a[2],a[3] ]:[b,0];case "s":return 5==a.length?[b,1,1,a[3],a[4] ]:3==a.length?[b,1,1]:[b,1]}}function w(b,d,f){d=q(d).replace(/\.{3}|\u2026/g,b);b=a.parseTransformString(b)||
[];d=a.parseTransformString(d)||[];for(var k=Math.max(b.length,d.length),p=[],v=[],h=0,w,z,y,I;h<k;h++){y=b[h]||A(d[h]);I=d[h]||A(y);if(y[0]!=I[0]||"r"==y[0].toLowerCase()&&(y[2]!=I[2]||y[3]!=I[3])||"s"==y[0].toLowerCase()&&(y[3]!=I[3]||y[4]!=I[4])){b=a._.transform2matrix(b,f());d=a._.transform2matrix(d,f());p=[["m",b.a,b.b,b.c,b.d,b.e,b.f] ];v=[["m",d.a,d.b,d.c,d.d,d.e,d.f] ];break}p[h]=[];v[h]=[];w=0;for(z=Math.max(y.length,I.length);w<z;w++)w in y&&(p[h][w]=y[w]),w in I&&(v[h][w]=I[w])}return{from:u(p),
to:u(v),f:n(p)}}function z(a){return a}function d(a){return function(b){return+b.toFixed(3)+a}}function f(b){return a.rgb(b[0],b[1],b[2])}function n(a){var b=0,d,f,k,n,h,p,q=[];d=0;for(f=a.length;d<f;d++){h="[";p=['"'+a[d][0]+'"'];k=1;for(n=a[d].length;k<n;k++)p[k]="val["+b++ +"]";h+=p+"]";q[d]=h}return Function("val","return Snap.path.toString.call(["+q+"])")}function u(a){for(var b=[],d=0,f=a.length;d<f;d++)for(var k=1,n=a[d].length;k<n;k++)b.push(a[d][k]);return b}var p={},b=/[a-z]+$/i,q=String;
p.stroke=p.fill="colour";v.prototype.equal=function(a,b){return k("snap.util.equal",this,a,b).firstDefined()};k.on("snap.util.equal",function(e,k){var r,s;r=q(this.attr(e)||"");var x=this;if(r==+r&&k==+k)return{from:+r,to:+k,f:z};if("colour"==p[e])return r=a.color(r),s=a.color(k),{from:[r.r,r.g,r.b,r.opacity],to:[s.r,s.g,s.b,s.opacity],f:f};if("transform"==e||"gradientTransform"==e||"patternTransform"==e)return k instanceof a.Matrix&&(k=k.toTransformString()),a._.rgTransform.test(k)||(k=a._.svgTransform2string(k)),
w(r,k,function(){return x.getBBox(1)});if("d"==e||"path"==e)return r=a.path.toCubic(r,k),{from:u(r[0]),to:u(r[1]),f:n(r[0])};if("points"==e)return r=q(r).split(a._.separator),s=q(k).split(a._.separator),{from:r,to:s,f:function(a){return a}};aUnit=r.match(b);s=q(k).match(b);return aUnit&&aUnit==s?{from:parseFloat(r),to:parseFloat(k),f:d(aUnit)}:{from:this.asPX(e),to:this.asPX(e,k),f:z}})});C.plugin(function(a,v,y,C){var A=v.prototype,w="createTouch"in C.doc;v="click dblclick mousedown mousemove mouseout mouseover mouseup touchstart touchmove touchend touchcancel".split(" ");
var z={mousedown:"touchstart",mousemove:"touchmove",mouseup:"touchend"},d=function(a,b){var d="y"==a?"scrollTop":"scrollLeft",e=b&&b.node?b.node.ownerDocument:C.doc;return e[d in e.documentElement?"documentElement":"body"][d]},f=function(){this.returnValue=!1},n=function(){return this.originalEvent.preventDefault()},u=function(){this.cancelBubble=!0},p=function(){return this.originalEvent.stopPropagation()},b=function(){if(C.doc.addEventListener)return function(a,b,e,f){var k=w&&z[b]?z[b]:b,l=function(k){var l=
d("y",f),q=d("x",f);if(w&&z.hasOwnProperty(b))for(var r=0,u=k.targetTouches&&k.targetTouches.length;r<u;r++)if(k.targetTouches[r].target==a||a.contains(k.targetTouches[r].target)){u=k;k=k.targetTouches[r];k.originalEvent=u;k.preventDefault=n;k.stopPropagation=p;break}return e.call(f,k,k.clientX+q,k.clientY+l)};b!==k&&a.addEventListener(b,l,!1);a.addEventListener(k,l,!1);return function(){b!==k&&a.removeEventListener(b,l,!1);a.removeEventListener(k,l,!1);return!0}};if(C.doc.attachEvent)return function(a,
b,e,h){var k=function(a){a=a||h.node.ownerDocument.window.event;var b=d("y",h),k=d("x",h),k=a.clientX+k,b=a.clientY+b;a.preventDefault=a.preventDefault||f;a.stopPropagation=a.stopPropagation||u;return e.call(h,a,k,b)};a.attachEvent("on"+b,k);return function(){a.detachEvent("on"+b,k);return!0}}}(),q=[],e=function(a){for(var b=a.clientX,e=a.clientY,f=d("y"),l=d("x"),n,p=q.length;p--;){n=q[p];if(w)for(var r=a.touches&&a.touches.length,u;r--;){if(u=a.touches[r],u.identifier==n.el._drag.id||n.el.node.contains(u.target)){b=
u.clientX;e=u.clientY;(a.originalEvent?a.originalEvent:a).preventDefault();break}}else a.preventDefault();b+=l;e+=f;k("snap.drag.move."+n.el.id,n.move_scope||n.el,b-n.el._drag.x,e-n.el._drag.y,b,e,a)}},l=function(b){a.unmousemove(e).unmouseup(l);for(var d=q.length,f;d--;)f=q[d],f.el._drag={},k("snap.drag.end."+f.el.id,f.end_scope||f.start_scope||f.move_scope||f.el,b);q=[]};for(y=v.length;y--;)(function(d){a[d]=A[d]=function(e,f){a.is(e,"function")&&(this.events=this.events||[],this.events.push({name:d,
f:e,unbind:b(this.node||document,d,e,f||this)}));return this};a["un"+d]=A["un"+d]=function(a){for(var b=this.events||[],e=b.length;e--;)if(b[e].name==d&&(b[e].f==a||!a)){b[e].unbind();b.splice(e,1);!b.length&&delete this.events;break}return this}})(v[y]);A.hover=function(a,b,d,e){return this.mouseover(a,d).mouseout(b,e||d)};A.unhover=function(a,b){return this.unmouseover(a).unmouseout(b)};var r=[];A.drag=function(b,d,f,h,n,p){function u(r,v,w){(r.originalEvent||r).preventDefault();this._drag.x=v;
this._drag.y=w;this._drag.id=r.identifier;!q.length&&a.mousemove(e).mouseup(l);q.push({el:this,move_scope:h,start_scope:n,end_scope:p});d&&k.on("snap.drag.start."+this.id,d);b&&k.on("snap.drag.move."+this.id,b);f&&k.on("snap.drag.end."+this.id,f);k("snap.drag.start."+this.id,n||h||this,v,w,r)}if(!arguments.length){var v;return this.drag(function(a,b){this.attr({transform:v+(v?"T":"t")+[a,b]})},function(){v=this.transform().local})}this._drag={};r.push({el:this,start:u});this.mousedown(u);return this};
A.undrag=function(){for(var b=r.length;b--;)r[b].el==this&&(this.unmousedown(r[b].start),r.splice(b,1),k.unbind("snap.drag.*."+this.id));!r.length&&a.unmousemove(e).unmouseup(l);return this}});C.plugin(function(a,v,y,C){y=y.prototype;var A=/^\s*url\((.+)\)/,w=String,z=a._.$;a.filter={};y.filter=function(d){var f=this;"svg"!=f.type&&(f=f.paper);d=a.parse(w(d));var k=a._.id(),u=z("filter");z(u,{id:k,filterUnits:"userSpaceOnUse"});u.appendChild(d.node);f.defs.appendChild(u);return new v(u)};k.on("snap.util.getattr.filter",
function(){k.stop();var d=z(this.node,"filter");if(d)return(d=w(d).match(A))&&a.select(d[1])});k.on("snap.util.attr.filter",function(d){if(d instanceof v&&"filter"==d.type){k.stop();var f=d.node.id;f||(z(d.node,{id:d.id}),f=d.id);z(this.node,{filter:a.url(f)})}d&&"none"!=d||(k.stop(),this.node.removeAttribute("filter"))});a.filter.blur=function(d,f){null==d&&(d=2);return a.format('<feGaussianBlur stdDeviation="{def}"/>',{def:null==f?d:[d,f]})};a.filter.blur.toString=function(){return this()};a.filter.shadow=
function(d,f,k,u,p){"string"==typeof k&&(p=u=k,k=4);"string"!=typeof u&&(p=u,u="#000");null==k&&(k=4);null==p&&(p=1);null==d&&(d=0,f=2);null==f&&(f=d);u=a.color(u||"#000");return a.format('<feGaussianBlur in="SourceAlpha" stdDeviation="{blur}"/><feOffset dx="{dx}" dy="{dy}" result="offsetblur"/><feFlood flood-color="{color}"/><feComposite in2="offsetblur" operator="in"/><feComponentTransfer><feFuncA type="linear" slope="{opacity}"/></feComponentTransfer><feMerge><feMergeNode/><feMergeNode in="SourceGraphic"/></feMerge>',
{color:u,dx:d,dy:f,blur:k,opacity:p})};a.filter.shadow.toString=function(){return this()};a.filter.grayscale=function(d){null==d&&(d=1);return a.format('<feColorMatrix type="matrix" values="{a} {b} {c} 0 0 {d} {e} {f} 0 0 {g} {b} {h} 0 0 0 0 0 1 0"/>',{a:0.2126+0.7874*(1-d),b:0.7152-0.7152*(1-d),c:0.0722-0.0722*(1-d),d:0.2126-0.2126*(1-d),e:0.7152+0.2848*(1-d),f:0.0722-0.0722*(1-d),g:0.2126-0.2126*(1-d),h:0.0722+0.9278*(1-d)})};a.filter.grayscale.toString=function(){return this()};a.filter.sepia=
function(d){null==d&&(d=1);return a.format('<feColorMatrix type="matrix" values="{a} {b} {c} 0 0 {d} {e} {f} 0 0 {g} {h} {i} 0 0 0 0 0 1 0"/>',{a:0.393+0.607*(1-d),b:0.769-0.769*(1-d),c:0.189-0.189*(1-d),d:0.349-0.349*(1-d),e:0.686+0.314*(1-d),f:0.168-0.168*(1-d),g:0.272-0.272*(1-d),h:0.534-0.534*(1-d),i:0.131+0.869*(1-d)})};a.filter.sepia.toString=function(){return this()};a.filter.saturate=function(d){null==d&&(d=1);return a.format('<feColorMatrix type="saturate" values="{amount}"/>',{amount:1-
d})};a.filter.saturate.toString=function(){return this()};a.filter.hueRotate=function(d){return a.format('<feColorMatrix type="hueRotate" values="{angle}"/>',{angle:d||0})};a.filter.hueRotate.toString=function(){return this()};a.filter.invert=function(d){null==d&&(d=1);return a.format('<feComponentTransfer><feFuncR type="table" tableValues="{amount} {amount2}"/><feFuncG type="table" tableValues="{amount} {amount2}"/><feFuncB type="table" tableValues="{amount} {amount2}"/></feComponentTransfer>',{amount:d,
amount2:1-d})};a.filter.invert.toString=function(){return this()};a.filter.brightness=function(d){null==d&&(d=1);return a.format('<feComponentTransfer><feFuncR type="linear" slope="{amount}"/><feFuncG type="linear" slope="{amount}"/><feFuncB type="linear" slope="{amount}"/></feComponentTransfer>',{amount:d})};a.filter.brightness.toString=function(){return this()};a.filter.contrast=function(d){null==d&&(d=1);return a.format('<feComponentTransfer><feFuncR type="linear" slope="{amount}" intercept="{amount2}"/><feFuncG type="linear" slope="{amount}" intercept="{amount2}"/><feFuncB type="linear" slope="{amount}" intercept="{amount2}"/></feComponentTransfer>',
{amount:d,amount2:0.5-d/2})};a.filter.contrast.toString=function(){return this()}});return C});

]]> </script>
<script> <![CDATA[

(function (glob, factory) {
    // AMD support
    if (typeof define === "function" && define.amd) {
        // Define as an anonymous module
        define("Gadfly", ["Snap.svg"], function (Snap) {
            return factory(Snap);
        });
    } else {
        // Browser globals (glob is window)
        // Snap adds itself to window
        glob.Gadfly = factory(glob.Snap);
    }
}(this, function (Snap) {

var Gadfly = {};

// Get an x/y coordinate value in pixels
var xPX = function(fig, x) {
    var client_box = fig.node.getBoundingClientRect();
    return x * fig.node.viewBox.baseVal.width / client_box.width;
};

var yPX = function(fig, y) {
    var client_box = fig.node.getBoundingClientRect();
    return y * fig.node.viewBox.baseVal.height / client_box.height;
};


Snap.plugin(function (Snap, Element, Paper, global) {
    // Traverse upwards from a snap element to find and return the first
    // note with the "plotroot" class.
    Element.prototype.plotroot = function () {
        var element = this;
        while (!element.hasClass("plotroot") && element.parent() != null) {
            element = element.parent();
        }
        return element;
    };

    Element.prototype.svgroot = function () {
        var element = this;
        while (element.node.nodeName != "svg" && element.parent() != null) {
            element = element.parent();
        }
        return element;
    };

    Element.prototype.plotbounds = function () {
        var root = this.plotroot()
        var bbox = root.select(".guide.background").node.getBBox();
        return {
            x0: bbox.x,
            x1: bbox.x + bbox.width,
            y0: bbox.y,
            y1: bbox.y + bbox.height
        };
    };

    Element.prototype.plotcenter = function () {
        var root = this.plotroot()
        var bbox = root.select(".guide.background").node.getBBox();
        return {
            x: bbox.x + bbox.width / 2,
            y: bbox.y + bbox.height / 2
        };
    };

    // Emulate IE style mouseenter/mouseleave events, since Microsoft always
    // does everything right.
    // See: http://www.dynamic-tools.net/toolbox/isMouseLeaveOrEnter/
    var events = ["mouseenter", "mouseleave"];

    for (i in events) {
        (function (event_name) {
            var event_name = events[i];
            Element.prototype[event_name] = function (fn, scope) {
                if (Snap.is(fn, "function")) {
                    var fn2 = function (event) {
                        if (event.type != "mouseover" && event.type != "mouseout") {
                            return;
                        }

                        var reltg = event.relatedTarget ? event.relatedTarget :
                            event.type == "mouseout" ? event.toElement : event.fromElement;
                        while (reltg && reltg != this.node) reltg = reltg.parentNode;

                        if (reltg != this.node) {
                            return fn.apply(this, event);
                        }
                    };

                    if (event_name == "mouseenter") {
                        this.mouseover(fn2, scope);
                    } else {
                        this.mouseout(fn2, scope);
                    }
                }
                return this;
            };
        })(events[i]);
    }


    Element.prototype.mousewheel = function (fn, scope) {
        if (Snap.is(fn, "function")) {
            var el = this;
            var fn2 = function (event) {
                fn.apply(el, [event]);
            };
        }

        this.node.addEventListener(
            /Firefox/i.test(navigator.userAgent) ? "DOMMouseScroll" : "mousewheel",
            fn2);

        return this;
    };


    // Snap's attr function can be too slow for things like panning/zooming.
    // This is a function to directly update element attributes without going
    // through eve.
    Element.prototype.attribute = function(key, val) {
        if (val === undefined) {
            return this.node.getAttribute(key);
        } else {
            this.node.setAttribute(key, val);
            return this;
        }
    };
});


// When the plot is moused over, emphasize the grid lines.
Gadfly.plot_mouseover = function(event) {
    var root = this.plotroot();
    init_pan_zoom(root);

    var xgridlines = root.select(".xgridlines"),
        ygridlines = root.select(".ygridlines");

    xgridlines.data("unfocused_strokedash",
                    xgridlines.attribute("stroke-dasharray").replace(/(\d)(,|$)/g, "$1mm$2"));
    ygridlines.data("unfocused_strokedash",
                    ygridlines.attribute("stroke-dasharray").replace(/(\d)(,|$)/g, "$1mm$2"));

    // emphasize grid lines
    var destcolor = root.data("focused_xgrid_color");
    xgridlines.attribute("stroke-dasharray", "none")
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    destcolor = root.data("focused_ygrid_color");
    ygridlines.attribute("stroke-dasharray", "none")
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    // reveal zoom slider
    root.select(".zoomslider")
        .animate({opacity: 1.0}, 250);
};


// Unemphasize grid lines on mouse out.
Gadfly.plot_mouseout = function(event) {
    var root = this.plotroot();
    var xgridlines = root.select(".xgridlines"),
        ygridlines = root.select(".ygridlines");

    var destcolor = root.data("unfocused_xgrid_color");

    xgridlines.attribute("stroke-dasharray", xgridlines.data("unfocused_strokedash"))
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    destcolor = root.data("unfocused_ygrid_color");
    ygridlines.attribute("stroke-dasharray", ygridlines.data("unfocused_strokedash"))
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    // hide zoom slider
    root.select(".zoomslider")
        .animate({opacity: 0.0}, 250);
};


var set_geometry_transform = function(root, tx, ty, scale) {
    var xscalable = root.hasClass("xscalable"),
        yscalable = root.hasClass("yscalable");

    var old_scale = root.data("scale");

    var xscale = xscalable ? scale : 1.0,
        yscale = yscalable ? scale : 1.0;

    tx = xscalable ? tx : 0.0;
    ty = yscalable ? ty : 0.0;

    var t = new Snap.Matrix().translate(tx, ty).scale(xscale, yscale);

    root.selectAll(".geometry, image")
        .forEach(function (element, i) {
            element.transform(t);
        });

    bounds = root.plotbounds();

    if (yscalable) {
        var xfixed_t = new Snap.Matrix().translate(0, ty).scale(1.0, yscale);
        root.selectAll(".xfixed")
            .forEach(function (element, i) {
                element.transform(xfixed_t);
            });

        root.select(".ylabels")
            .transform(xfixed_t)
            .selectAll("text")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var cx = element.asPX("x"),
                        cy = element.asPX("y");
                    var st = element.data("static_transform");
                    unscale_t = new Snap.Matrix();
                    unscale_t.scale(1, 1/scale, cx, cy).add(st);
                    element.transform(unscale_t);

                    var y = cy * scale + ty;
                    element.attr("visibility",
                        bounds.y0 <= y && y <= bounds.y1 ? "visible" : "hidden");
                }
            });
    }

    if (xscalable) {
        var yfixed_t = new Snap.Matrix().translate(tx, 0).scale(xscale, 1.0);
        var xtrans = new Snap.Matrix().translate(tx, 0);
        root.selectAll(".yfixed")
            .forEach(function (element, i) {
                element.transform(yfixed_t);
            });

        root.select(".xlabels")
            .transform(yfixed_t)
            .selectAll("text")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var cx = element.asPX("x"),
                        cy = element.asPX("y");
                    var st = element.data("static_transform");
                    unscale_t = new Snap.Matrix();
                    unscale_t.scale(1/scale, 1, cx, cy).add(st);

                    element.transform(unscale_t);

                    var x = cx * scale + tx;
                    element.attr("visibility",
                        bounds.x0 <= x && x <= bounds.x1 ? "visible" : "hidden");
                    }
            });
    }

    // we must unscale anything that is scale invariance: widths, raiduses, etc.
    var size_attribs = ["font-size"];
    var unscaled_selection = ".geometry, .geometry *";
    if (xscalable) {
        size_attribs.push("rx");
        unscaled_selection += ", .xgridlines";
    }
    if (yscalable) {
        size_attribs.push("ry");
        unscaled_selection += ", .ygridlines";
    }

    root.selectAll(unscaled_selection)
        .forEach(function (element, i) {
            // circle need special help
            if (element.node.nodeName == "circle") {
                var cx = element.attribute("cx"),
                    cy = element.attribute("cy");
                unscale_t = new Snap.Matrix().scale(1/xscale, 1/yscale,
                                                        cx, cy);
                element.transform(unscale_t);
                return;
            }

            for (i in size_attribs) {
                var key = size_attribs[i];
                var val = parseFloat(element.attribute(key));
                if (val !== undefined && val != 0 && !isNaN(val)) {
                    element.attribute(key, val * old_scale / scale);
                }
            }
        });
};


// Find the most appropriate tick scale and update label visibility.
var update_tickscale = function(root, scale, axis) {
    if (!root.hasClass(axis + "scalable")) return;

    var tickscales = root.data(axis + "tickscales");
    var best_tickscale = 1.0;
    var best_tickscale_dist = Infinity;
    for (tickscale in tickscales) {
        var dist = Math.abs(Math.log(tickscale) - Math.log(scale));
        if (dist < best_tickscale_dist) {
            best_tickscale_dist = dist;
            best_tickscale = tickscale;
        }
    }

    if (best_tickscale != root.data(axis + "tickscale")) {
        root.data(axis + "tickscale", best_tickscale);
        var mark_inscale_gridlines = function (element, i) {
            var inscale = element.attr("gadfly:scale") == best_tickscale;
            element.attribute("gadfly:inscale", inscale);
            element.attr("visibility", inscale ? "visible" : "hidden");
        };

        var mark_inscale_labels = function (element, i) {
            var inscale = element.attr("gadfly:scale") == best_tickscale;
            element.attribute("gadfly:inscale", inscale);
            element.attr("visibility", inscale ? "visible" : "hidden");
        };

        root.select("." + axis + "gridlines").selectAll("path").forEach(mark_inscale_gridlines);
        root.select("." + axis + "labels").selectAll("text").forEach(mark_inscale_labels);
    }
};


var set_plot_pan_zoom = function(root, tx, ty, scale) {
    var old_scale = root.data("scale");
    var bounds = root.plotbounds();

    var width = bounds.x1 - bounds.x0,
        height = bounds.y1 - bounds.y0;

    // compute the viewport derived from tx, ty, and scale
    var x_min = -width * scale - (scale * width - width),
        x_max = width * scale,
        y_min = -height * scale - (scale * height - height),
        y_max = height * scale;

    var x0 = bounds.x0 - scale * bounds.x0,
        y0 = bounds.y0 - scale * bounds.y0;

    var tx = Math.max(Math.min(tx - x0, x_max), x_min),
        ty = Math.max(Math.min(ty - y0, y_max), y_min);

    tx += x0;
    ty += y0;

    // when the scale change, we may need to alter which set of
    // ticks is being displayed
    if (scale != old_scale) {
        update_tickscale(root, scale, "x");
        update_tickscale(root, scale, "y");
    }

    set_geometry_transform(root, tx, ty, scale);

    root.data("scale", scale);
    root.data("tx", tx);
    root.data("ty", ty);
};


var scale_centered_translation = function(root, scale) {
    var bounds = root.plotbounds();

    var width = bounds.x1 - bounds.x0,
        height = bounds.y1 - bounds.y0;

    var tx0 = root.data("tx"),
        ty0 = root.data("ty");

    var scale0 = root.data("scale");

    // how off from center the current view is
    var xoff = tx0 - (bounds.x0 * (1 - scale0) + (width * (1 - scale0)) / 2),
        yoff = ty0 - (bounds.y0 * (1 - scale0) + (height * (1 - scale0)) / 2);

    // rescale offsets
    xoff = xoff * scale / scale0;
    yoff = yoff * scale / scale0;

    // adjust for the panel position being scaled
    var x_edge_adjust = bounds.x0 * (1 - scale),
        y_edge_adjust = bounds.y0 * (1 - scale);

    return {
        x: xoff + x_edge_adjust + (width - width * scale) / 2,
        y: yoff + y_edge_adjust + (height - height * scale) / 2
    };
};


// Initialize data for panning zooming if it isn't already.
var init_pan_zoom = function(root) {
    if (root.data("zoompan-ready")) {
        return;
    }

    // The non-scaling-stroke trick. Rather than try to correct for the
    // stroke-width when zooming, we force it to a fixed value.
    var px_per_mm = root.node.getCTM().a;

    // Drag events report deltas in pixels, which we'd like to convert to
    // millimeters.
    root.data("px_per_mm", px_per_mm);

    root.selectAll("path")
        .forEach(function (element, i) {
        sw = element.asPX("stroke-width") * px_per_mm;
        if (sw > 0) {
            element.attribute("stroke-width", sw);
            element.attribute("vector-effect", "non-scaling-stroke");
        }
    });

    // Store ticks labels original tranformation
    root.selectAll(".xlabels > text, .ylabels > text")
        .forEach(function (element, i) {
            var lm = element.transform().localMatrix;
            element.data("static_transform",
                new Snap.Matrix(lm.a, lm.b, lm.c, lm.d, lm.e, lm.f));
        });

    var xgridlines = root.select(".xgridlines");
    var ygridlines = root.select(".ygridlines");
    var xlabels = root.select(".xlabels");
    var ylabels = root.select(".ylabels");

    if (root.data("tx") === undefined) root.data("tx", 0);
    if (root.data("ty") === undefined) root.data("ty", 0);
    if (root.data("scale") === undefined) root.data("scale", 1.0);
    if (root.data("xtickscales") === undefined) {

        // index all the tick scales that are listed
        var xtickscales = {};
        var ytickscales = {};
        var add_x_tick_scales = function (element, i) {
            xtickscales[element.attribute("gadfly:scale")] = true;
        };
        var add_y_tick_scales = function (element, i) {
            ytickscales[element.attribute("gadfly:scale")] = true;
        };

        if (xgridlines) xgridlines.selectAll("path").forEach(add_x_tick_scales);
        if (ygridlines) ygridlines.selectAll("path").forEach(add_y_tick_scales);
        if (xlabels) xlabels.selectAll("text").forEach(add_x_tick_scales);
        if (ylabels) ylabels.selectAll("text").forEach(add_y_tick_scales);

        root.data("xtickscales", xtickscales);
        root.data("ytickscales", ytickscales);
        root.data("xtickscale", 1.0);
    }

    var min_scale = 1.0, max_scale = 1.0;
    for (scale in xtickscales) {
        min_scale = Math.min(min_scale, scale);
        max_scale = Math.max(max_scale, scale);
    }
    for (scale in ytickscales) {
        min_scale = Math.min(min_scale, scale);
        max_scale = Math.max(max_scale, scale);
    }
    root.data("min_scale", min_scale);
    root.data("max_scale", max_scale);

    // store the original positions of labels
    if (xlabels) {
        xlabels.selectAll("text")
               .forEach(function (element, i) {
                   element.data("x", element.asPX("x"));
               });
    }

    if (ylabels) {
        ylabels.selectAll("text")
               .forEach(function (element, i) {
                   element.data("y", element.asPX("y"));
               });
    }

    // mark grid lines and ticks as in or out of scale.
    var mark_inscale = function (element, i) {
        element.attribute("gadfly:inscale", element.attribute("gadfly:scale") == 1.0);
    };

    if (xgridlines) xgridlines.selectAll("path").forEach(mark_inscale);
    if (ygridlines) ygridlines.selectAll("path").forEach(mark_inscale);
    if (xlabels) xlabels.selectAll("text").forEach(mark_inscale);
    if (ylabels) ylabels.selectAll("text").forEach(mark_inscale);

    // figure out the upper ond lower bounds on panning using the maximum
    // and minum grid lines
    var bounds = root.plotbounds();
    var pan_bounds = {
        x0: 0.0,
        y0: 0.0,
        x1: 0.0,
        y1: 0.0
    };

    if (xgridlines) {
        xgridlines
            .selectAll("path")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var bbox = element.node.getBBox();
                    if (bounds.x1 - bbox.x < pan_bounds.x0) {
                        pan_bounds.x0 = bounds.x1 - bbox.x;
                    }
                    if (bounds.x0 - bbox.x > pan_bounds.x1) {
                        pan_bounds.x1 = bounds.x0 - bbox.x;
                    }
                    element.attr("visibility", "visible");
                }
            });
    }

    if (ygridlines) {
        ygridlines
            .selectAll("path")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var bbox = element.node.getBBox();
                    if (bounds.y1 - bbox.y < pan_bounds.y0) {
                        pan_bounds.y0 = bounds.y1 - bbox.y;
                    }
                    if (bounds.y0 - bbox.y > pan_bounds.y1) {
                        pan_bounds.y1 = bounds.y0 - bbox.y;
                    }
                    element.attr("visibility", "visible");
                }
            });
    }

    // nudge these values a little
    pan_bounds.x0 -= 5;
    pan_bounds.x1 += 5;
    pan_bounds.y0 -= 5;
    pan_bounds.y1 += 5;
    root.data("pan_bounds", pan_bounds);

    root.data("zoompan-ready", true)
};


// Panning
Gadfly.guide_background_drag_onmove = function(dx, dy, x, y, event) {
    var root = this.plotroot();
    var px_per_mm = root.data("px_per_mm");
    dx /= px_per_mm;
    dy /= px_per_mm;

    var tx0 = root.data("tx"),
        ty0 = root.data("ty");

    var dx0 = root.data("dx"),
        dy0 = root.data("dy");

    root.data("dx", dx);
    root.data("dy", dy);

    dx = dx - dx0;
    dy = dy - dy0;

    var tx = tx0 + dx,
        ty = ty0 + dy;

    set_plot_pan_zoom(root, tx, ty, root.data("scale"));
};


Gadfly.guide_background_drag_onstart = function(x, y, event) {
    var root = this.plotroot();
    root.data("dx", 0);
    root.data("dy", 0);
    init_pan_zoom(root);
};


Gadfly.guide_background_drag_onend = function(event) {
    var root = this.plotroot();
};


Gadfly.guide_background_scroll = function(event) {
    if (event.shiftKey) {
        var root = this.plotroot();
        init_pan_zoom(root);
        var new_scale = root.data("scale") * Math.pow(2, 0.002 * event.wheelDelta);
        new_scale = Math.max(
            root.data("min_scale"),
            Math.min(root.data("max_scale"), new_scale))
        update_plot_scale(root, new_scale);
        event.stopPropagation();
    }
};


Gadfly.zoomslider_button_mouseover = function(event) {
    this.select(".button_logo")
         .animate({fill: this.data("mouseover_color")}, 100);
};


Gadfly.zoomslider_button_mouseout = function(event) {
     this.select(".button_logo")
         .animate({fill: this.data("mouseout_color")}, 100);
};


Gadfly.zoomslider_zoomout_click = function(event) {
    var root = this.plotroot();
    init_pan_zoom(root);
    var min_scale = root.data("min_scale"),
        scale = root.data("scale");
    Snap.animate(
        scale,
        Math.max(min_scale, scale / 1.5),
        function (new_scale) {
            update_plot_scale(root, new_scale);
        },
        200);
};


Gadfly.zoomslider_zoomin_click = function(event) {
    var root = this.plotroot();
    init_pan_zoom(root);
    var max_scale = root.data("max_scale"),
        scale = root.data("scale");

    Snap.animate(
        scale,
        Math.min(max_scale, scale * 1.5),
        function (new_scale) {
            update_plot_scale(root, new_scale);
        },
        200);
};


Gadfly.zoomslider_track_click = function(event) {
    // TODO
};


Gadfly.zoomslider_thumb_mousedown = function(event) {
    this.animate({fill: this.data("mouseover_color")}, 100);
};


Gadfly.zoomslider_thumb_mouseup = function(event) {
    this.animate({fill: this.data("mouseout_color")}, 100);
};


// compute the position in [0, 1] of the zoom slider thumb from the current scale
var slider_position_from_scale = function(scale, min_scale, max_scale) {
    if (scale >= 1.0) {
        return 0.5 + 0.5 * (Math.log(scale) / Math.log(max_scale));
    }
    else {
        return 0.5 * (Math.log(scale) - Math.log(min_scale)) / (0 - Math.log(min_scale));
    }
}


var update_plot_scale = function(root, new_scale) {
    var trans = scale_centered_translation(root, new_scale);
    set_plot_pan_zoom(root, trans.x, trans.y, new_scale);

    root.selectAll(".zoomslider_thumb")
        .forEach(function (element, i) {
            var min_pos = element.data("min_pos"),
                max_pos = element.data("max_pos"),
                min_scale = root.data("min_scale"),
                max_scale = root.data("max_scale");
            var xmid = (min_pos + max_pos) / 2;
            var xpos = slider_position_from_scale(new_scale, min_scale, max_scale);
            element.transform(new Snap.Matrix().translate(
                Math.max(min_pos, Math.min(
                         max_pos, min_pos + (max_pos - min_pos) * xpos)) - xmid, 0));
    });
};


Gadfly.zoomslider_thumb_dragmove = function(dx, dy, x, y) {
    var root = this.plotroot();
    var min_pos = this.data("min_pos"),
        max_pos = this.data("max_pos"),
        min_scale = root.data("min_scale"),
        max_scale = root.data("max_scale"),
        old_scale = root.data("old_scale");

    var px_per_mm = root.data("px_per_mm");
    dx /= px_per_mm;
    dy /= px_per_mm;

    var xmid = (min_pos + max_pos) / 2;
    var xpos = slider_position_from_scale(old_scale, min_scale, max_scale) +
                   dx / (max_pos - min_pos);

    // compute the new scale
    var new_scale;
    if (xpos >= 0.5) {
        new_scale = Math.exp(2.0 * (xpos - 0.5) * Math.log(max_scale));
    }
    else {
        new_scale = Math.exp(2.0 * xpos * (0 - Math.log(min_scale)) +
                        Math.log(min_scale));
    }
    new_scale = Math.min(max_scale, Math.max(min_scale, new_scale));

    update_plot_scale(root, new_scale);
};


Gadfly.zoomslider_thumb_dragstart = function(event) {
    var root = this.plotroot();
    init_pan_zoom(root);

    // keep track of what the scale was when we started dragging
    root.data("old_scale", root.data("scale"));
};


Gadfly.zoomslider_thumb_dragend = function(event) {
};


var toggle_color_class = function(root, color_class, ison) {
    var guides = root.selectAll(".guide." + color_class + ",.guide ." + color_class);
    var geoms = root.selectAll(".geometry." + color_class + ",.geometry ." + color_class);
    if (ison) {
        guides.animate({opacity: 0.5}, 250);
        geoms.animate({opacity: 0.0}, 250);
    } else {
        guides.animate({opacity: 1.0}, 250);
        geoms.animate({opacity: 1.0}, 250);
    }
};


Gadfly.colorkey_swatch_click = function(event) {
    var root = this.plotroot();
    var color_class = this.data("color_class");

    if (event.shiftKey) {
        root.selectAll(".colorkey text")
            .forEach(function (element) {
                var other_color_class = element.data("color_class");
                if (other_color_class != color_class) {
                    toggle_color_class(root, other_color_class,
                                       element.attr("opacity") == 1.0);
                }
            });
    } else {
        toggle_color_class(root, color_class, this.attr("opacity") == 1.0);
    }
};


return Gadfly;

}));


//@ sourceURL=gadfly.js

(function (glob, factory) {
    // AMD support
      if (typeof require === "function" && typeof define === "function" && define.amd) {
        require(["Snap.svg", "Gadfly"], function (Snap, Gadfly) {
            factory(Snap, Gadfly);
        });
      } else {
          factory(glob.Snap, glob.Gadfly);
      }
})(window, function (Snap, Gadfly) {
    var fig = Snap("#fig-7ca6750e949147c1bff9e7479e97a43d");
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-4")
   .drag(function() {}, function() {}, function() {});
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-6")
   .data("color_class", "color_out")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-7")
   .data("color_class", "color_in")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-9")
   .data("color_class", "color_out")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-10")
   .data("color_class", "color_in")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-13")
   .mouseenter(Gadfly.plot_mouseover)
.mouseleave(Gadfly.plot_mouseout)
.mousewheel(Gadfly.guide_background_scroll)
.drag(Gadfly.guide_background_drag_onmove,
      Gadfly.guide_background_drag_onstart,
      Gadfly.guide_background_drag_onend)
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-17")
   .plotroot().data("unfocused_ygrid_color", "#D0D0E0")
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-17")
   .plotroot().data("focused_ygrid_color", "#A0A0A0")
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-124")
   .plotroot().data("unfocused_xgrid_color", "#D0D0E0")
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-124")
   .plotroot().data("focused_xgrid_color", "#A0A0A0")
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-1235")
   .data("mouseover_color", "#cd5c5c")
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-1235")
   .data("mouseout_color", "#6a6a6a")
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-1235")
   .click(Gadfly.zoomslider_zoomin_click)
.mouseenter(Gadfly.zoomslider_button_mouseover)
.mouseleave(Gadfly.zoomslider_button_mouseout)
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-1239")
   .data("max_pos", 121.19)
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-1239")
   .data("min_pos", 104.19)
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-1239")
   .click(Gadfly.zoomslider_track_click);
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-1241")
   .data("max_pos", 121.19)
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-1241")
   .data("min_pos", 104.19)
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-1241")
   .data("mouseover_color", "#cd5c5c")
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-1241")
   .data("mouseout_color", "#6a6a6a")
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-1241")
   .drag(Gadfly.zoomslider_thumb_dragmove,
     Gadfly.zoomslider_thumb_dragstart,
     Gadfly.zoomslider_thumb_dragend)
.mousedown(Gadfly.zoomslider_thumb_mousedown)
.mouseup(Gadfly.zoomslider_thumb_mouseup)
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-1243")
   .data("mouseover_color", "#cd5c5c")
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-1243")
   .data("mouseout_color", "#6a6a6a")
;
fig.select("#fig-7ca6750e949147c1bff9e7479e97a43d-element-1243")
   .click(Gadfly.zoomslider_zoomout_click)
.mouseenter(Gadfly.zoomslider_button_mouseover)
.mouseleave(Gadfly.zoomslider_button_mouseout)
;
    });
]]> </script>
</svg>

</div>

</div>

</div>
</div>

</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In&nbsp;[34]:</div>
<div class="inner_cell">
    <div class="input_area">
<div class=" highlight hl-julia"><pre><span class="n">print</span><span class="p">(</span><span class="s">&quot;pi ~ &quot;</span><span class="p">,</span><span class="mi">4</span><span class="o">*</span><span class="n">sum</span><span class="p">(</span><span class="n">df</span><span class="p">[:</span><span class="n">c</span><span class="p">]</span> <span class="o">.==</span> <span class="s">&quot;in&quot;</span><span class="p">)</span><span class="o">/</span><span class="n">n</span><span class="p">)</span>
</pre></div>

</div>
</div>
</div>

<div class="output_wrapper">
<div class="output">


<div class="output_area"><div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>pi ~ 3.140724</pre>
</div>
</div>
</div>
</div>
</div>
</body>

