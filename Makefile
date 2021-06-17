# We don't want to touch the user's existing keys or gpg conf
GPG_OPTIONS := --no-options --no-default-keyring --no-auto-check-trustdb --trustdb-name ./trustdb.gpg

# Take the ascii armored key and export it in binary.
# apt doesn't like ascii armored keys, but binary keys in git are annoying,
# this allows us to work well with both.
build:	ubiquity.key
	mkdir -p keyrings
	gpg ${GPG_OPTIONS} --no-keyring --import-options import-export --import < ubiquity.key > keyrings/ubiquity.gpg

clean:
	rm -rf keyrings

install: build
	install -d $(DESTDIR)/usr/share/keyrings/
	cp keyrings/*.gpg $(DESTDIR)/usr/share/keyrings/

.PHONY: build clean install
