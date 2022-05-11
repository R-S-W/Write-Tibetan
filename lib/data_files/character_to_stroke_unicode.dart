/*Map that converts the tibetan character into the step by step characters used
 in PracticeCharacterPage and DrawnStroke in PracticeMode.  The step by step
 characters appear in the custom font, NotoSansTibetanStroke. Each character in
 each Map value represents a step in drawing the picture of the character in the
 key
*/
const Map<String,String> characterToStrokeUnicode = <String,String>{
  "ཀ" : "!\"#\$",
  "ཁ" : "%&\'(",
  "ག" : ")*+,",
  "ང" : "-.",
  "ཅ" : "/01",
  "ཆ" : "2 \u00c3\u00c43 ",
  "ཇ" : "456",
  "ཉ" : "789:",
  "ཏ" : ";<=",
  "ཐ" : ">?@A",
  "ད" : "BC",
  "ན" : "D \u00c0E ",
  "པ" : "FGH",
  "ཕ" : "IJKL",
  "བ" : "MNO",
  "མ" : "P \u00c1Q R ",
  "ཙ" : "STUV",
  "ཚ" : "W \u00c5\u00c6X Y",
  "ཛ" : "Z[\\]",
  "ཝ" : "^_`abc",
  "ཞ" : "de \u00c2f ",
  "ཟ" : "ghij",
  "འ" : "klmn",
  "ཡ" : "opq",
  "ར" : "rst",
  "ལ" : "uvwxy",
  "ཤ" : "z{|}~",
  "ས" : "\u00a1\u00a2\u00a3\u00a4",
  "ཧ" : "\u00a5\u00a6\u00a7",
  "ཨ" : "\u00a8\u00a9\u00aa\u00ab",
  "ཨི" :"\u00ab\u00ac",
  "ཨེ" :"\u00ab\u00ae",
  "ཨུ" :"\u00ab\u00b0",
  "ཨོ" :"\u00c7\u00af",
};