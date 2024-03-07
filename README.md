# tac.ksh

An [unaware](#ok-but-why-it-is-unaware) KornShell 93 reimplementation of GNU coreutils.

## Why?

After I spent an [unacceptable time programming
in C](https://github.com/Projeto-Pindorama/heirloom-ng/pull/41), I decided
to come back to the same old place, Sweet Old KornShell.  
No, seriously, I had to invert a list of [git commit
hashes](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects),
with the intent of [cherry-picking](https://git-scm.com/docs/git-cherry-pick)
them into another branch of another repository --- in case,
[I had to move some commits made after July 15th of
2007](https://github.com/Projeto-Pindorama/heirloom-ng/pull/43) on the
git-imported version of [Heirloom Toolchest
CVS repository](https://heirloom.cvs.sourceforge.net/heirloom/heirloom/)
to Heirloom NG's
[20240220-fix](https://github.com/Projeto-Pindorama/heirloom-ng/commit/a908e262da0668c7cac8179cf7c1bcced190db30)
branch --- and I just didn't wanted to use GNU-specific tools to do it,
so I wrote this small program.

An example of what I ended up doing after wroting this ---
clearified, of course:

```sh
for hash in $(ksh93 tac.ksh /tmp/git_hashes); do
    git cherry-pick $hash
done
```

### "O.k., but why it is 'unaware'?"

One using a system with tools derived and/or reimplemented from
4BSD or Research UNIX v8 --- such as
[Copacabana](http://copacabana.pindorama.dob.jp), which has
[Heirloom Toolchest](http://heirloom-ng.pindorama.dob.jp) --- may
have a ``tail`` command with a ``-r`` option, which will print text
from the finish to the start, exactly like ``tac``.  

If you're dealing with a large set and/or a single shell script which
uses ``tac``, you can hack it out with something like this:

```sh
tac() {
    if [ $# -lt 1 ]; then
        # standard input
        tail -r
    else
        for file; do
            tail -r "$file"
        done
    fi
    return 0
}
```

I personally think it is not really worth of using, since an actually
large file could easily overflow KornShell 93's limit of (2²² - 1) ~ 2²²
elements on the buffer array and, although this does not appear to be
an actual problem, I could also argue that the speed is not that great,
since it would iterate two times.  

This is more of an elaborated hack made with the intent of solving a problem,
but I hope it can be useful anyway.

## Licence

[Glad you asked.](./COPYING)
