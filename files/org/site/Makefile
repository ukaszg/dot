##
# site
.PHONY: install serve clean cleanall

clean:
	@rm -r _out 2>/dev/null || true

cleanall: clean
	@rm -r .packages 2>/dev/null || true

install: clean
	@yes | emacs -Q --batch -l ./publish.el --funcall site-publish

serve: install
	@cd _out && serve .

# end
