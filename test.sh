#!/bin/bash

set -e

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEST_HOME="$(mktemp -d)"

cleanup() {
    rm -rf "$TEST_HOME"
}

trap cleanup EXIT

echo "===== Jaewoong Linux Tools Test ====="
echo

echo "[1] Syntax check"

for file in jcheck jgrep jnote install.sh uninstall.sh test.sh
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
        echo "Install failed: $tool"
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
HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" add "Edit target note"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" list > "$TEST_HOME/jnote-list.out"
grep -q "Linux test note" "$TEST_HOME/jnote-list.out"
grep -q "Git test note" "$TEST_HOME/jnote-list.out"
grep -q "Edit target note" "$TEST_HOME/jnote-list.out"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" show 2 > "$TEST_HOME/jnote-show.out"
grep -q "Git test note" "$TEST_HOME/jnote-show.out"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" edit 3 "Edited target note"
HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" show 3 > "$TEST_HOME/jnote-show-edited.out"
grep -q "Edited target note" "$TEST_HOME/jnote-show-edited.out"

if grep -q "Edit target note" "$TEST_HOME/jnote-show-edited.out"; then
    echo "Edit failed: old note still exists in note 3"
    exit 1
fi

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" search git > "$TEST_HOME/jnote-search.out"
grep -qi "Git test note" "$TEST_HOME/jnote-search.out"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" count > "$TEST_HOME/jnote-count.out"
grep -q "Total notes: 3" "$TEST_HOME/jnote-count.out"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" export "$TEST_HOME/exported-notes.txt"
grep -q "Linux test note" "$TEST_HOME/exported-notes.txt"
grep -q "Git test note" "$TEST_HOME/exported-notes.txt"
grep -q "Edited target note" "$TEST_HOME/exported-notes.txt"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" delete 1
HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" list > "$TEST_HOME/jnote-after-delete.out"

grep -q "Git test note" "$TEST_HOME/jnote-after-delete.out"
grep -q "Edited target note" "$TEST_HOME/jnote-after-delete.out"

if grep -q "Linux test note" "$TEST_HOME/jnote-after-delete.out"; then
    echo "Delete failed: Linux test note still exists"
    exit 1
fi

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" count > "$TEST_HOME/jnote-count-after-delete.out"
grep -q "Total notes: 2" "$TEST_HOME/jnote-count-after-delete.out"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" archive 2

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" count \
    > "$TEST_HOME/jnote-count-after-archive.out"

grep -q "Total notes: 1" \
    "$TEST_HOME/jnote-count-after-archive.out"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" archived \
    > "$TEST_HOME/jnote-archived.out"

grep -q "Edited target note" \
    "$TEST_HOME/jnote-archived.out"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" list \
    > "$TEST_HOME/jnote-after-archive.out"

grep -q "Git test note" \
    "$TEST_HOME/jnote-after-archive.out"

if grep -q "Edited target note" \
    "$TEST_HOME/jnote-after-archive.out"; then
    echo "Archive test failed: archived note is still active"
    exit 1
fi

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" restore 1

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" count \
    > "$TEST_HOME/jnote-count-after-restore.out"

grep -q "Total notes: 2" \
    "$TEST_HOME/jnote-count-after-restore.out"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" list \
    > "$TEST_HOME/jnote-after-restore.out"

grep -q "Git test note" \
    "$TEST_HOME/jnote-after-restore.out"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" archived \
    > "$TEST_HOME/jnote-archive-after-restore.out"

grep -q "No archived notes." \
    "$TEST_HOME/jnote-archive-after-restore.out"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" clear --yes

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" count > "$TEST_HOME/jnote-count-after-clear.out"
grep -q "Total notes: 0" "$TEST_HOME/jnote-count-after-clear.out"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" import "$TEST_HOME/exported-notes.txt"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" count > "$TEST_HOME/jnote-count-after-import.out"
grep -q "Total notes: 3" "$TEST_HOME/jnote-count-after-import.out"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" list > "$TEST_HOME/jnote-after-import.out"
grep -q "Linux test note" "$TEST_HOME/jnote-after-import.out"
grep -q "Git test note" "$TEST_HOME/jnote-after-import.out"
grep -q "Edited target note" "$TEST_HOME/jnote-after-import.out"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" today > "$TEST_HOME/jnote-today.out"
grep -q "Linux test note" "$TEST_HOME/jnote-today.out"
grep -q "Git test note" "$TEST_HOME/jnote-today.out"
grep -q "Edited target note" "$TEST_HOME/jnote-today.out"

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" recent 2 > "$TEST_HOME/jnote-recent.out"
grep -q "Git test note" "$TEST_HOME/jnote-recent.out"
grep -q "Edited target note" "$TEST_HOME/jnote-recent.out"

if grep -q "Linux test note" "$TEST_HOME/jnote-recent.out"; then
    echo "Recent test failed: too many notes were shown"
    exit 1
fi

HOME="$TEST_HOME" "$TEST_HOME/bin/jnote" backup

backup_file=$(find "$TEST_HOME/linux-quest/notes/backups" \
    -type f -name 'jnote-*.txt' -print -quit)

if [ -z "$backup_file" ] || [ ! -f "$backup_file" ]; then
    echo "Backup test failed: backup file was not created"
    exit 1
fi

grep -q "Linux test note" "$backup_file"
grep -q "Git test note" "$backup_file"
grep -q "Edited target note" "$backup_file"

echo "OK: jnote add/list/show/search/today/recent/count/edit/export/import/backup/archive/restore/delete/clear"
echo
echo
echo "[5] jnote undo test"

UNDO_HOME="$TEST_HOME/undo-home"
mkdir -p "$UNDO_HOME"

HOME="$UNDO_HOME" "$TEST_HOME/bin/jnote" add "Keep note"
HOME="$UNDO_HOME" "$TEST_HOME/bin/jnote" add "Undo this note"
HOME="$UNDO_HOME" "$TEST_HOME/bin/jnote" undo

HOME="$UNDO_HOME" "$TEST_HOME/bin/jnote" list \
    > "$TEST_HOME/jnote-undo-add.out"

grep -q "Keep note" "$TEST_HOME/jnote-undo-add.out"

if grep -q "Undo this note" "$TEST_HOME/jnote-undo-add.out"; then
    echo "Undo add test failed."
    exit 1
fi

HOME="$UNDO_HOME" "$TEST_HOME/bin/jnote" add "Delete target"
HOME="$UNDO_HOME" "$TEST_HOME/bin/jnote" delete 1
HOME="$UNDO_HOME" "$TEST_HOME/bin/jnote" undo

HOME="$UNDO_HOME" "$TEST_HOME/bin/jnote" list \
    > "$TEST_HOME/jnote-undo-delete.out"

grep -q "Keep note" "$TEST_HOME/jnote-undo-delete.out"
grep -q "Delete target" "$TEST_HOME/jnote-undo-delete.out"

HOME="$UNDO_HOME" "$TEST_HOME/bin/jnote" clear --yes
HOME="$UNDO_HOME" "$TEST_HOME/bin/jnote" undo

HOME="$UNDO_HOME" "$TEST_HOME/bin/jnote" count \
    > "$TEST_HOME/jnote-undo-clear.out"

grep -q "Total notes: 2" "$TEST_HOME/jnote-undo-clear.out"

echo "OK: jnote one-level undo"

echo "[6] Uninstall test"

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
