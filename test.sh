#!/bin/bash

set -e

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEST_HOME="$(mktemp -d)"

cleanup() {
rm -rf "$TEST_HOME"
}

trap cleanup EXIT

echo "===== Jaewoong Linux tools Test ====="
echo

echo "[1] Syntax check"

for file in jcheck jgrep jnote install.sh uninstall.sh
do
if [ -f "$PROJECT_DIR/$file" ]; then
bash -n "$PROJECT_DIR/$file"
echo "OK: $file"
else
echo "Missing file: $file"
exit 1
fi
done

echo
echo "[2] Install test"
HOME="$TEST_HOME" "$PROJECT_DIR/install.sh"

for tool in jcheck jgrep jnote
do
if [ -x "$TEST_HOME/bin/$tool" ]; then
echo "Installed: $tool"
else
echo "Installed failed: $tool"
exit 1
fi
done

echo
echo "[3] jgrep test"

cat > "$TEST_HOME/app.log" << 'LOG'
INFO server started
ERROR database failed
error timeout happened
INFO server stopped
LOG

"$TEST_HOME/bin/jgrep" error "$TEST_HOME/app.log" > "$TEST_HOME/jgrep.out"

grep -q "ERROR database failed" "$TEST_HOME/jgrep.out"
grep -q "error timeout happened" "$TEST_HOME/jgrep.out"

echo "OK: jgrep found error lines"

echo
echo "[4] jnote test"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" add "Linux test note"
HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" add "Git test note"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" list > "$TEST_HOME/jnote-list.out"
grep -q "Linux test note" "$TEST_HOME/jnote-list.out"
grep -q "Git test note" "$TEST_HOME/jnote-list.out"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" search git > "$TEST_HOME/jnote-search.out"
grep -qi "Git test note" "$TEST_HOME/jnote-search.out"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" count > "$TEST_HOME/jnote-count.out"
grep -Eq '^[[:space:]]*2[[:space:]]' "$TEST_HOME/jnote-count.out"

echo "OK: jnote add/list/search/count"
echo
echo "[5] Uninstall test"

HOME="$TEST_HOME" "$PROJECT_DIR/uninstall.sh" --yes

for tool in jcheck jgrep jnote
do
    if [ -e "$TEST_HOME/bin/$tool" ]; then
        echo "Uninstall failed: $tool still exists"
        exit 1
    else
        echo "Removed: $tool"
    fi
done

echo
echo "All tests passed."
