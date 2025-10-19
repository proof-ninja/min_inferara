(lang dune 3.19)

(name min_inferara)

(generate_opam_files true)

(source
 (github proof-ninja/min_inferara))

(authors "Yoshihiro Imai <y.imai@proof-ninja.co.jp>")

(maintainers "Yoshihiro Imai<y.imai@proof-ninja.co.jp>")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name min_inferara)
 (synopsis "A minimum implementation of Inferara")
 (description "A longer description")
 (depends ocaml dune ppx_deriving menhir (ounit2 :with-test))
 (tags
  ("add topics" "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html

(using menhir 2.1)
