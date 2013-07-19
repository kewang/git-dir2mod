git-dir2mod
===========

`git-dir2mod.sh` can help your directory transform to submodule

# Usage

```bash

git-dir2mod.sh -m mod -u url

  -m mod		new submodule name
  -u url		new submodule repository url
```

# Example:

	foo/aaa
	foo/bbb
	foo/ccc
	foo/ddd
	foo/bar/zzz
	foo/bar/yyy
	foo/bar/xxx
	foo/bar/www

If you want to subdirectory 'bar' to git submodule, you can execute following command:

`git-dir2mod.sh -m bar -u https://github.com/kewangtw/bar.git`

# Thanks

Special thanks to http://willandorla.com/will/2011/01/convert-folder-into-git-submodule
