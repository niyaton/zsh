#!/usr/bin/env python3
"""Display explicit SSH aliases without executing Match exec or opening connections."""

import fnmatch
import getpass
from pathlib import Path
import shlex
import sys
import unicodedata


def matches(name, patterns):
    positive = False
    for pattern in patterns:
        if pattern.startswith("!"):
            if fnmatch.fnmatchcase(name, pattern[1:]):
                return False
        elif fnmatch.fnmatchcase(name, pattern):
            positive = True
    return positive


def rows(config):
    blocks = []
    aliases = []
    kind, patterns, options = "host", ["*"], []
    for number, line in enumerate(config.splitlines(), 1):
        words = shlex.split(line, comments=True)
        if not words:
            continue
        key = words[0].lower()
        if key == "include":
            raise ValueError(f"{number}行目: Includeにはまだ対応していません")
        if key in ("host", "match"):
            blocks.append((kind, patterns, options))
            options = []
            if key == "host":
                kind, patterns = "host", words[1:]
                for alias in patterns:
                    if not any(char in alias for char in "*?![") and alias not in aliases:
                        aliases.append(alias)
            else:
                # An arbitrary exec cannot be evaluated safely for a static list.
                # Recognize the originalhost + exec form and display its route as conditional.
                if (len(words) != 5 or words[1].lower() != "originalhost"
                        or words[3].lower() != "exec"):
                    raise ValueError(f"{number}行目: このMatch形式にはまだ対応していません")
                kind, patterns = "conditional", words[2].split(",")
        else:
            value = " ".join(words[1:])
            options.append((key, value))
    blocks.append((kind, patterns, options))

    for alias in aliases:
        values = {}
        conditional_jump = None
        for kind, patterns, options in blocks:
            if not matches(alias, patterns):
                continue
            for key, value in options:
                if kind == "conditional":
                    if key != "proxyjump":
                        raise ValueError("条件付きMatch内はProxyJumpだけに対応しています")
                    if key not in values and conditional_jump is None:
                        conditional_jump = value
                elif key not in values:
                    values[key] = value
        hostname = values.get("hostname", alias).replace("%h", alias).replace("%%", "%")
        user = values.get("user", getpass.getuser())
        jump = values.get("proxyjump", "none")
        route = "直通" if jump == "none" else jump
        if conditional_jump is not None:
            route = f"{route} or {conditional_jump}（自動）"
        yield alias, hostname, user, route


def main():
    path = Path(sys.argv[1]).expanduser() if len(sys.argv) > 1 else Path.home() / ".ssh/config"
    try:
        entries = list(rows(path.read_text()))
    except (OSError, ValueError) as error:
        print(f"ssh-list: {error}", file=sys.stderr)
        return 1
    # Tabs separate the selectable alias from the human-readable columns.
    headers = ("名前", "接続先", "ユーザー", "経路")

    def display_width(text):
        return sum(0 if unicodedata.combining(char) else
                   2 if unicodedata.east_asian_width(char) in ("W", "F") else 1
                   for char in text)

    widths = [max(display_width(row[i]) for row in [headers, *entries]) for i in range(3)]
    for row in [headers, *entries]:
        print("\t".join(row[i] + " " * (widths[i] - display_width(row[i]))
                        for i in range(3)) + "\t" + row[3])
    return 0


if __name__ == "__main__":
    sys.exit(main())
