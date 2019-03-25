.PHONY: drake publish refs all

all: drake publish
refs: analysis/paper/references.bib

analysis/paper/references.bib: analysis/paper/paper.Rmd
	./getcitations

drake: refs analysis/drake.R
	./analysis/drake.R

publish: analysis/paper/paper.md
	cp -rf analysis/paper/paper.md analysis/paper/paper_files analysis/paper/_rendered_output/
	cd analysis/paper/_rendered_output &&\
	pwd &&\
	git checkout rendered &&\
	git add . &&\
	git commit --amend -m "Rendered output" &&\
	git push --force
