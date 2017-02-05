# Metadata Definitions
Sample spreadsheet: https://docs.google.com/spreadsheets/d/1H8NLRIkKhsZOSPTaguAAH8wGy7uPPN5Ss1Owc8FMfSI/edit?usp=sharing 

* Identifier
 * Definition: identifier assigned to the recipe in the transcription document.
 * Sample value: "p004r_1"
* heading
 * The verbatim heading for the recipe in the translation
 * Sample value: "Lavendar spike oil varnish"
* image_url
 * The URL of the image of the manuscript folio on which the recipe occurs
 * "http://gallica.bnf.fr/ark:/12148/btv1b10500001g/fl3.image"
* folio_start
 * The zero-padded number assigned to the folio on the recipe begins
 * Sample value: "034"
 * Note: must be stored in the spreadsheet as text not a number
* folio_start_r_or_v
 * indicates that folio_start is either recto or verso
 * sample value: "r"
 * Note: valid values are "r" and "v" only
* folio_end
 * The zero-padded number assigned to the folio on the recipe ends
 * Sample value: "034"
 * Note: must be stored in the spreadsheet as text not a number
* folio_end_r_or_v
 * indicates that folio_start is either recto or verso
 * sample value: "r"
 * Note: valid values are "r" and "v" only
* activity
 * one or more terms describing activities discussed in the recipe
 * Sample value: "varnish making"
 * Note: Multiple values are permitted. Use semicolons to delimit individual terms. Avoid punctuation in terms.
* ingredients
 * one or more terms describing ingredients discussed in the recipe
 * Sample value: "lavendar spike oil; sandarac gum"
 * Note: Multiple values are permitted. Use semicolons to delimit individual terms. Avoid
* number_of_ingredients
 * a number indicating the total count of ingredients discussed in the recipe
 * Sample value: "2"
* annotation1_title
 * the title of an annotation discussing the recipe
 * Sample value: "Spike lavender and lavender spikes"
* annotation1_url
 * the URL of the annotation described by annotation1_title above
 * Sample value: https://drive.google.com/open?id=0B0JTLtMxXWT_MGllU1E0V011dlU
* annotation2_title
 * the title of a second annotation discussing the recipe
 * Sample value: "Spike lavender and lavender spikes"
* annotation2_url
 * the URL of the annotation described by annotation1_title above
 * Sample value: see annotation1_url above
* annotation3_title
 * the title of a third annotation discussing the recipe
 * Sample value: "Spike lavender and lavender spikes"
* annotation3_url
 * the URL of a third annotation described by annotation3_title above
 * Sample value: see annotation1_url above
* place_names
 * Geographic names mentioned in the recipe
 * Sample value: "Armenia"
 * Note: May be empty. Multiple values are permitted. Use semicolons to delimit individual names. Avoid punctuation in terms.
* person_names
  * Names of persons mentioned in the recipe
  * Sample value: "Cicero"
  * Note: May be empty. Multiple values are permitted. Use semicolons to delimit individual names. Avoid punctuation in terms.
* product
 * the intended end product of the recipe
 * Sample value: "varnish"
* foreign_language
 * foreign languages used in the text of the recipe
 * Sample value: "latin"								
