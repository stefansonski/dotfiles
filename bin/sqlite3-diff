#!/usr/bin/python3
import gzip
import lzma
import os
import bz2
import argparse
import os.path
import tempfile
import subprocess
import shlex
import sys

class SqliteDiffError(Exception):
    pass

class SqliteDiffArgumentError(SqliteDiffError):
    pass

class DbFile(object):
    def __init__(self, path):
        if not os.path.isfile(path):
            raise SqliteDiffError("{0} is not a file".format(path))
        self.orig_path = path
        self.path = None
        self.dump_path = None

    def _tmpfile(self):
        _, path = tempfile.mkstemp(prefix="sqlitediff")
        return path

    def _rawdb(self):
        if self.path:
            return self.path

        if self.orig_path.endswith(".bz2"):
            bzf = bz2.BZ2File(self.orig_path)
            self.path = self._tmpfile()
            open(self.path, "wb").write(bzf.read())
        elif self.orig_path.endswith(".xz"):
            xzf = lzma.open(self.orig_path)
            self.path = self._tmpfile()
            open(self.path, "wb").write(xzf.read())
        elif self.orig_path.endswith(".gz"):
            gzf = gzip.open(self.orig_path)
            self.path = self._tmpfile()
            open(self.path, "wb").write(gzf.read())
        else:
            return self.orig_path

        return self.path

    def dump(self, plain=False):
        if self.dump_path:
            return self.dump_path

        fn = self._rawdb()
        if plain:
            return fn

        self.dump_path = self._tmpfile()
        outf = open(self.dump_path, "w")
        subprocess.call(shlex.split("sqlite3 {0} .dump".format(fn)), stdout=outf)
        outf.close()
        return self.dump_path

    def __del__(self):
        if self.path:
            os.remove(self.path)
        if self.dump_path:
            os.remove(self.dump_path)

def parse_arguments():
    parser = argparse.ArgumentParser(description='Compare two sqlite dbs',
                                     epilog='Supports compressed databases (bz2).')

    parser.add_argument('db1', help='First database file')
    parser.add_argument('db2', help='Second database file')
    parser.add_argument('--meld', help='Use Meld',
                        action='store_true')
    parser.add_argument('--plain', action='store_true',
                        help='When content of the compressed file '
                        'is not database but plain text')

    return parser.parse_args()

def diff(f1, f2, meld=False, plain=False):
    fn1 = f1.dump(plain=plain)
    fn2 = f2.dump(plain=plain)

    if meld:
        subprocess.call(shlex.split("meld {0} {1}".format(fn1, fn2)))
    else:
        subprocess.call(shlex.split("diff {0} {1}".format(fn1, fn2)), stdout=sys.stdout)

    return 0

if __name__ == "__main__":
    args = parse_arguments()

    f1 = DbFile(args.db1)
    f2 = DbFile(args.db2)

    ret = diff(f1, f2, meld=args.meld, plain=args.plain)

    # Next two lines are important, because otherwise __del__method of DbFile
    # is called after the os module is collected by garbage collector.
    # References: https://mail.cct.lsu.edu/pipermail/saga-users/2009-October/000228.html
    del(f1)
    del(f2)

    sys.exit(ret)
